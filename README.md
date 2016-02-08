# Post Secondary Electronic Standards Council - Common Data Exchange Standards

## Description
Any provider using the Common Data Services Standards (CDS) and registered in the service network could communicate directly with the appropriate exchange host for a targeted institution. The services would be 'payload agnostic' and while the immediate interest is for transcript exchange, the network could be used for the exchange of other existing or future PESC standard transactions.

As the technological landscape has evolved significantly over the years, web services standards are now available to enable automated directory lookup and efficient machine-to-machine communication in a highly secure transmission environment. The PESC CDS Task Force looks to maximize the use of this new technology to meet the emerging needs of schools, institutions, states and other service provider organizations to exchange student records, accounts and educational data.

The mission of the PESC CDS taskforce is to improve security, reliability, efficiency and speed in the transfer of all educational data types by developing an open web services network and associated standards to benefit the education of students, streamline processes for institutions, and facilitate the advancement of services offered for education.  Please refer to http://www.pesc.org for more information on PESC.

## Technical Requirements
-  Language – Java
-  Framework – Apache CXF web services; Spring
-  Deployment target – Tomcat
-  Configuration of services – Spring
-  Security – Spring
-  Persistence layer – DataNucleus or Hibernate
-  Database schema changes - Liquibase
-  Build system – Maven
-  Database – MySQL 
-  Development Environment
-  Eclipse (free) - preference or
     - IntellinJ (free – community edition or commercial version)
-  Source Control
     - GitHub (are components free?)
-  Issue Tracking
-  Wiki
-  Documentation
     - Wiki
     - Swagger documentation for REST API (after authenticating, see <baseURL>/EdExchange/swagger-ui/index.html)
-  Development Methodology
     - Specifications for initial release – as per defined on project site
     - Code review (less important on initial efforts – depends on size of development team and allocation of member’s time)
     - Bi-weekly review for development progress during regular scheduled CDS meetings

## Building and Running

### Directory Server

You will need a tomcat instance and a mariadb (or mysql) database server up and running and accessible from the source code location.

1. Pull down the source code to a local working directory
2. Change the `liquibase.url`, `liquibase.username`, and `liquibase.password` values in `directoryServer/src/main/filters/filters.dev.properties` for your database.
3. Build the war file with maven.

    `mvn clean package`
4. Deploy war to the tomcat `webapps` directory.
5. Edit the `{tomcat directory}/conf/context.xml` file and add a `<Resource>` element to it, e.g.

```
<Context>
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>${catalina.base}/conf/web.xml</WatchedResource>
    <Resource name="jdbc/pesc" auth="Container" type="javax.sql.DataSource"
      driverClassName="org.mariadb.jdbc.Driver"
      maxActive="20" maxIdle="10" maxWait="-1" username="{your db username}" password="{your db password}"
      url="jdbc:mariadb://localhost/pesc_edexchange" />
</Context>
```
6. Restart tomcat.


**Docker-ized**

In the `src/main/docker` directory there is a docker file that can be used with the `docker build` command to build an image containing the database, tomcat, and apache.
