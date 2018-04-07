package com.iskyshop.manage.admin.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.iskyshop.core.annotation.SecurityMapping;
import com.iskyshop.core.beans.BeanUtils;
import com.iskyshop.core.beans.BeanWrapper;
import com.iskyshop.core.domain.virtual.SysMap;
import com.iskyshop.core.mv.JModelAndView;
import com.iskyshop.core.query.support.IPageList;
import com.iskyshop.core.tools.CommUtil;
import com.iskyshop.core.tools.WebForm;
import com.iskyshop.foundation.domain.Accessory;
import com.iskyshop.foundation.domain.AdvertPosition;
import com.iskyshop.foundation.domain.Goods;
import com.iskyshop.foundation.domain.GoodsClass;
import com.iskyshop.foundation.domain.GoodsFloor;
import com.iskyshop.foundation.domain.query.GoodsBrandQueryObject;
import com.iskyshop.foundation.domain.query.GoodsFloorQueryObject;
import com.iskyshop.foundation.domain.query.GoodsQueryObject;
import com.iskyshop.foundation.service.IAccessoryService;
import com.iskyshop.foundation.service.IAdvertPositionService;
import com.iskyshop.foundation.service.IGoodsBrandService;
import com.iskyshop.foundation.service.IGoodsClassService;
import com.iskyshop.foundation.service.IGoodsFloorService;
import com.iskyshop.foundation.service.IGoodsService;
import com.iskyshop.foundation.service.ISysConfigService;
import com.iskyshop.foundation.service.IUserConfigService;
import com.iskyshop.manage.admin.tools.GoodsFloorTools;

/**
 * 
 * <p>
 * Title: GoodsFloorManageAction.java
 * </p>
 * 
 * <p>
 * Description: 商品楼层管理控制器，通过拖拽式管理完成首页楼层管理，平台管理员可以任意管理控制商城首页楼层信息
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2015
 * </p>
 * 
 * <p>
 * Company: 沈阳网之商科技有限公司 www.iskyshop.com
 * </p>
 * 
 * @author erikzhang
 * 
 * @d