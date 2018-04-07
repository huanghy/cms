package com.cqunis.cms.controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cqunis.cms.service.IExRecordService;
import com.cqunis.cms.service.IExtensionService;
import com.cqunis.controller.BaseController;
import com.cqunis.service.IDepartmentService;
import com.cqunis.service.IEnterpService;
import com.cqunis.service.IUnitService;

@Controller("adminIndexController")
public class AdminIndexController extends BaseController {

	@Autowired
	IUnitService unitService;
	@Resource(name = "extensionServiceImpl")
	IExtensionService extensionService;
	@Resource(name = "exRecordServiceImpl")
	IExRecordService exRecordService;
	@Autowired
	IDepartmentService departmentService;

	@Resource(name = "enterpServiceImpl")
	IEnterpService enterpService;

	@RequestMapping({ "/admin/index" })
	public String index(ModelMap model) {
		try {
			super.initCurrentUser();
			model.put("currentUser", this.currentUser);
			List enterps = this.enterpService.findAll();
			if ((null != enterps) && (enterps.size() > 0))
				model.put("enterp", enterps.get(0));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/index";
	}

	/***
	 * 首页信息
	 * @param map
	 * @return
	 */
	@RequestMapping({ "/admin/welcome" })
	public String welcome(ModelMap map) {
		try {
			java.text.SimpleDateFormat sdfstart = new java.text.SimpleDateFormat("yyyy-MM-dd 00:00:00");
			java.text.SimpleDateFormat sdfend = new java.text.SimpleDateFormat("yyyy-MM-dd 23:59:59");
			super.initCurrentUser();
			map.put("currentUser", currentUser);
			/**可用余额**/
			String humanId = currentUser.getId();
			String welcomeBalance = extensionService.welcomeBalance(humanId, entCode);
			if(null != welcomeBalance){
				BigDecimal bigDecimal = new BigDecimal(welcomeBalance);
				BigDecimal scale = bigDecimal.setScale(2,BigDecimal.ROUND_HALF_UP);
				map.put("welcomeBalance", scale.toString());
			}
			/**今日消费**/
			String dayConsume = exRecordService.dayConsume(humanId,entCode,sdfstart.format(new Date()), sdfend.format(new Date()));
			if(null != dayConsume){
				BigDecimal bigDecimal = new BigDecimal(dayConsume);
				BigDecimal scale = bigDecimal.setScale(2,BigDecimal.ROUND_HALF_UP);
				map.put("dayConsume", scale.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/welcome";
	}

	@RequestMapping({ "/admin/", "/admin/common/upload" })
	public String commonUpload(ModelMap model) {
		return "admin/common/upload";
	}
}