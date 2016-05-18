package org.pesc.api;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.cxf.jaxrs.ext.multipart.Attachment;
import org.apache.cxf.jaxrs.ext.multipart.Multipart;
import org.pesc.api.model.AuthUser;
import org.pesc.api.model.InstitutionsUpload;
import org.pesc.api.model.OrganizationDTO;
import org.pesc.service.InstitutionUploadService;
import org.pesc.service.OrganizationService;
import org.pesc.service.PagedData;
import org.pesc.web.AppController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import javax.activation.DataHandler;
import javax.jws.WebService;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.List;
import java.util.UUID;


/**
 * Created by james on 3/22/16.
 */
@Component
@WebService
@Path("/institutions")
@Api("/institutions")
public class InstitutionResource {

    private static final Log log = LogFactory.getLog(InstitutionResource.class);

    @Autowired
    private OrganizationService organizationService;

    @Autowired
    private InstitutionUploadService uploadService;

    @Context
    private HttpServletResponse servletResponse;

    @Value("${directory.uploaded.csv}")
    private String csvDir;

    private InstitutionsUpload persistUploadRecord(String inputFilepath, Integer orgID) {

        if (SecurityContextHolder.getContext().getAuthentication() != null &&
                SecurityContextHolder.getContext().getAuthentication().isAuthenticated() &&
                //when Anonymous Authentication is enabled
                !(SecurityContextHolder.getContext().getAuthentication() instanceof AnonymousAuthenticationToken)) {

            AuthUser auth = (AuthUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

            //Ideally, this should be done with an annotation, but for some reason, the annotation was conflicting
            //with the Context annotation, making the HttpServletResponse null.
            if (AppController.hasRole(auth.getAuthorities(), "ROLE_SYSTEM_ADMIN") ||
                    (AppController.hasRole(auth.getAuthorities(), "ROLE_ORG_ADMIN") && auth.getOrganizationId().equals(orgID))) {
                InstitutionsUpload institutionsUpload = new InstitutionsUpload();
                institutionsUpload.setUserId(auth.getId());
                institutionsUpload.setOrganizationId(auth.getOrganizationId());
                institutionsUpload.setInputPath(inputFilepath);

                return uploadService.create(institutionsUpload);
            }

        }

        return null;
    }

    @POST
    @Path("/csv")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public void convertCSVtoJSON(@Multipart("org_id") Integer orgID,
                                     @Multipart("file") Attachment attachment) {




        DataHandler handler = attachment.getDataHandler();
        try {
            InputStream stream = handler.getInputStream();
            MultivaluedMap<String, String> map = attachment.getHeaders();
            //System.out.println("fileName Here" + getFileName(map));


            File outfile = new File(csvDir + File.separator + UUID.randomUUID().toString() + ".csv");
            Files.copy(stream, outfile.toPath());

            InstitutionsUpload institutionsUpload = persistUploadRecord(outfile.getAbsolutePath(), orgID);

            uploadService.processCSVFile(institutionsUpload, outfile.getPath(), orgID);

        } catch (Exception e) {
            log.error("Failed to save uploaded CSV file", e);

            throw new RuntimeException("Failed to save uploaded CSV file");

        }


    }



    private String getFileName(MultivaluedMap<String, String> header) {
        String[] contentDisposition = header.getFirst("Content-Disposition").split(";");
        for (String filename : contentDisposition) {
            if ((filename.trim().startsWith("filename"))) {
                String[] name = filename.split("=");
                String exactFileName = name[1].trim().replaceAll("\"", "");
                return exactFileName;
            }
        }

        throw new RuntimeException("Failed to extract file name.");
    }

    @GET
    @ApiOperation("Return the institutions that are serviced by this service provider.")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<OrganizationDTO> getServiceProvidersForInstitution(
            @QueryParam("service_provider_id") @ApiParam(value="The directory identifier for the service provider.", required = true) Integer id,
            @QueryParam("limit") @DefaultValue("5") Integer limit,
            @QueryParam("offset") @DefaultValue("0") Integer offset) {

        if (limit == null || offset == null) {
            limit = 5;
            offset = 0;
        }
        PagedData<OrganizationDTO> pagedData = new PagedData<OrganizationDTO>(limit,offset);

        if (id == null) {
            throw new IllegalArgumentException("The service provider's id must be provided.");
        }
        organizationService.getInstitutionsByServiceProviderId(id, pagedData);
        servletResponse.addHeader("X-Total-Count", String.valueOf(pagedData.getTotal()));
        return pagedData.getData();
    }



}
