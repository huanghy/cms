package com.cqunis.cms.controller.exte;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cqunis.cms.entity.ExRecord;
import com.cqunis.cms.entity.Extension;
import com.cqunis.cms.service.IExRecordService;
import com.cqunis.cms.service.IExtensionService;
import com.cqunis.common.JsonResult;
import com.cqunis.controller.BaseController;
import com.cqunis.entity.User;
import com.cqunis.service.IUserService;
import com.cqunis.service.specification.SimpleSpecificationBuilder;
import com.cqunis.service.specification.SpecificationOperator.Operator;
/***
 * 推广管理
 * @author huanghy
 *
 */
@Controller("extensionController")
@RequestMapping({"/oa/exte"})
public class ExtensionController extends BaseController {

	
	@Resource(name="extensionServiceImpl")
	IExtensionService extensionService;
	@Resource(name="adminUserServiceImpl")
	IUserService userService;
	@Resource(name="exRecordServiceImpl")
	IExRecordService exRecordService; 
	
	
	/***推广管理
	 * @param newtype
	 * @param map
	 * @return
	 */
	@RequestMapping(value = {"/index" })
	public String index(ModelMap map) {
		try{
			super.initCurrentUser();
			map.put("currentUser",currentUser);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "oa/exte/index";
	}
	
	
	/**
	 * 查询集合
	 * @return
	 */
	@RequestMapping(value = { "/list" })
	@ResponseBody
	public Page<Extension> list(ModelMap map) {
		Page<Extension> page = null;
		try{
			super.initCurrentUser();
			SimpleSpecificationBuilder<Extension> builder = new SimpleSpecificationBuilder<Extension>();
			String searchText = request.getParameter("searchText");
			if(StringUtils.isNotBlank(searchText)){
				builder.add("exName", Operator.likeAll.name(), searchText);
			}
			if(!currentUser.getUserName().equals("admin")){
				builder.add("humanId",Operator.eq.name(),currentUser.getId());
			}
			builder.add("entCode",Operator.eq.name(),entCode);
			page = extensionService.findAll(builder.generateSpecification(), getPageRequest());
		}catch(Exception e){
			e.printStackTrace();
		}
		return page;
	}
	
	
	/***
	 * 增加推广
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(ModelMap map) {
		Integer sort = extensionService.maxSort(Extension.class.getName()," 1=1 ");
		sort+=1;
		try{
			super.initCurrentUser();
			map.put("currentUser",currentUser);
			List<User> users = userService.findAll();
			if(null != users 
					&& users.size()>0){
				map.put("users",users);
			}
			map.put("sort",sort);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "oa/exte/form";
	}
	
	/***
	 * 编辑推广
	 * @param id
	 * @param newtype
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	public String edit(@PathVariable String id,ModelMap map) {
		try{
			Extension extension = extensionService.find(id);
			super.initCurrentUser();
			map.put("currentUser",currentUser);
			List<User> users = userService.findAll();
			if(null != users 
					&& users.size()>0){
				map.put("users",users);
			}
			map.put("extension",extension);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "oa/exte/form";
	}
	
	
	/***保存编辑信息
	 * @param extension
	 * @param map
	 * @return
	 */
	@RequestMapping(value= {"/edit"} ,method = RequestMethod.POST)
	@ResponseBody
	public JsonResult edit(Extension extension, ModelMap map){
		try {
			if(null != extension.getId()
					&&extension.getId().trim().length()>0){
				extensionService.update(extension);
			} else {
				extensionService.save(extension);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return JsonResult.failure(e.getMessage());
		}
		return JsonResult.success();
	}
	
	/***删除任务
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult delete(@PathVariable String id,ModelMap map) {
		try {
			Extension extension = extensionService.find(id);
			if(extension.getTaskState()==0){
				return JsonResult.failure("任务已经启用不允许删除!");
			}
			/***删除记录**/
			String spec = " extId='"+id+"'";
			exRecordService.del(ExRecord.class.getName(), spec, id);
			extensionService.delete(extension);
		} catch (Exception e) {
			e.printStackTrace();
			return JsonResult.failure(e.getMessage());
		}
		return JsonResult.success();
	}
	
	
	/***操作推广
	 * @param id
	 * @param state
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/opr/{id}/{state}", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult oPr(@PathVariable String id,@PathVariable Integer state,ModelMap map) {
		try {
			Extension extension = extensionService.find(id);
			/***启动**/
			if(state==0){
				extension.setExeState(-1);
			}
			extension.setTaskState(state);
			extensionService.update(extension);
		} catch (Exception e) {
			e.printStackTrace();
			return JsonResult.failure(e.getMessage());
		}
		return JsonResult.success();
	}
}
