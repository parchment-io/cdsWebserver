package org.pesc.cds.networkserver.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.pesc.cds.networkserver.domain.Transaction;
import org.pesc.cds.networkserver.domain.TransactionsDao;
import org.pesc.cds.networkserver.service.DatasourceManagerUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class homeController {
	
	private static final Log log = LogFactory.getLog(homeController.class);
	
	@RequestMapping({"/", "/home"})
	public String viewHome(Model model) {
		model.addAttribute("transactions", DatasourceManagerUtil.getTransactions().all());
		return "home";
	}
}
