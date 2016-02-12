package org.pesc.cds.networkserver.controller;

import org.pesc.cds.networkserver.service.DatasourceManagerUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class documentationController {
	@RequestMapping("/documentation")
	public String viewHome(Model model) {
		model.addAttribute("transactions", DatasourceManagerUtil.getTransactions().all());
		return "documentation";
	}
}
