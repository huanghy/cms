package com.cqunis.cms.controller.exte;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cqunis.cms.entity.ExType;
import com.cqunis.cms.service.IExTypeService;
import com.cqunis.common.JsonResult;
import com.cqunis.controller.BaseController;
import com.cqunis.service.specification.SimpleSpecificationBuilder;
import com.cqunis.service.specification.SpecificationOperator.Operator;
@Controller("exTypeController")
@RequestMapping({"/oa/exty"})
public class ExTypeController extends BaseController {

	
	@Resource(name="exTypeServiceImpl")
	IExTypeService exTypeService;
	
	
	/***广告类型管理
	 * @param map
	 * @return
	 */
	@RequestMapping(value = {"/index" })
	public String index(ModelMap map) {
		return "oa/exty/index";
	}
	
	
	/**
	 * 查询集合
	 * @return
	 */
	@RequestMapping(value = { "/list" })
	@ResponseBody
	public Page<ExType> list(ModelMap map) {
		Page<ExType> page = null;
		try{
			super.initCurrentUser();
			SimpleSpecificationBuilder<ExType> builder = new SimpleSpecificationBuilder<ExType>();
			String searchText = request.getParameter("searchText");
			if(StringUtils.isNotBlank(searchText)){
				builder.add("typeName", Operator.likeAll.name(), searchText);
			}
			builder.add("entCode",Operator.eq.name(),entCode);
			page = exTypeService.findAll(builder.generateSpecification(), getPageRequest());
		}catch(Exception e){
			e.printStackTrace();
		}
		return page;
	}
	
	
	/***
	 * 推广类型
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(ModelMap map) {
		Integer sort = exTypeService.maxSort(ExType.class.getName()," 1=1 ");
		sort+=1;
		map.put("sort",sort);
		return "oa/exty/form";
	}
	
	/***编辑推广类型
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	public String edit(@PathVariable String id,ModelMap map) {
		try{
			ExType exType = exTypeService.find(id);
			map.put("exType",exType);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "oa/exty/form";
	}
	
	/***编辑推广类型
	 */
	@RequestMapping(value= {"/edit"} ,method = RequestMethod.POST)
	@ResponseBody
	public JsonResult edit(ExType exType, ModelMap map){
		try {
			if(null != exType.getId()
					&&exType.getId().trim().length()>0){
				exTypeService.update(exType);
			} else {
				exTypeService.save(exType);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return JsonResult.failure(e.getMessage());
		}
		return JsonResult.success();
	}
	
	
	/***删除推广分类
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult delete(@PathVariable String id,ModelMap map) {
		try {
			exTypeService.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return JsonResult.failure(e.getMessage());
		}
		return JsonResult.success();
	}
}
