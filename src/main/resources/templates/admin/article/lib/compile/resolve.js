ion e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@SecurityMapping(title = "楼层分类下级加载", value = "/admin/goods_floor_data.htm*", rtype = "admin", rname = "首页楼层", rcode = "goods_floor", rgroup = "装修")
	@RequestMapping("/admin/goods_floor_data.htm")
	public ModelAndView goods_floor_data(HttpServletRequest request,
			HttpServletResponse response, String pid, String currentPage) {
		ModelAndView mv = new JModelAndView("admin/blue/goods_floor_data.html",
				configService.getSysConfig(),
				this.userConfigService.getUserConfig(), 0, request, response);
		Map map = new HashMap();
		map.put("pid", CommUtil.null2Long(pid));
		List<GoodsFloor> gfs = this.goodsfloorService
				.query("select obj from GoodsFloor obj where obj.parent.id =:pid order by obj.gf_sequence asc",
						map, -1, -1);
		mv.addObject("gfs", gfs);
		mv.addObject("currentPage", currentPage);
		return mv;
	}

	@SecurityMapping(title = "楼层模板编辑", value = "/admin/goods_floor_template.htm*", rtype = "admin", rname = "首页楼层", rcode = "goods_floor", rgroup = "装修")
	@RequestMapping("/admin/goods_floor_template.htm")
	public ModelAndView goods_floor_template(HttpServletRequest request,
			HttpServletResponse response, String currentPage, String id,
			String tab) {
		ModelAndView mv = new JModelAndView(
				"admin/blue/goods_floor_template.html",
				configService.getSysConfig(),
				this.userConfigService.getUserConfig(), 0, request, response);
		GoodsFloor obj = this.goodsfloorService.getObjById(CommUtil
				.null2Long(id));
		mv.addObject("obj", obj);
		mv.addObject("gf_tools", this.gf_tools);
		mv.addObject("currentPage", currentPage);
		mv.addObject("tab", tab);
		mv.addObject("url", CommUtil.getURL(request));
		return mv;
	}

	@SecurityMapping(title = "楼层模板商品分类编辑", value = "/admin/goods_floor_class.htm*", rtype = "admin", rname = "首页楼层", rcode = "goods_floor", rgroup = "装修")
	@RequestMapping("/admin/goods_floor_class.htm")
	public ModelAndView goods_floor_class(HttpServletRequest request,
			HttpServletResponse response, String currentPage, String id) {
		ModelAndView mv = new JModelAndView(
				"admin/blue/goods_floor_class.html",
				configService.getSysConfig(),
				this.userConfigService.getUserConfig(), 0, request, response);
		GoodsFloor obj = this.goodsfloorService.getObjById(CommUtil
				.null2Long(id));
		List<GoodsClass> gcs = this.goodsClassService
				.query("select obj from GoodsClass obj where obj.parent.id is null order by obj.sequence asc",
						null, -1, -1);
		mv.addObject("gcs", gcs);
		mv.addObject("obj", obj);
		mv.addObject("gf_tools", this.gf_tools);
		mv.addObject("currentPage", currentPage);
		return mv;
	}

	@SecurityMapping(title = "楼层模板商品分类加载", value = "/admin/goods_floor_class_load.htm*", rtype = "admin", rname = "首页楼层", rcode = "goods_floor", rgroup = "装修")
	@RequestMapping("/admin/goods_floor_class_load.htm")
	public ModelAndView goods_floor_class_load(HttpServletRequest request,
			HttpServletResponse response, String currentPage, String gc_id) {
		ModelAndView mv = new JModelAndView(
				"admin/blue/goods_floor_class_load.html",
				configService.getSysConfig(),
				this.userConfigService.getUserConfig(), 0, request, response);
		GoodsClass gc = this.goodsClassService.getObjById(CommUtil
				.null2Long(gc_id));
		mv.addObject("gc", gc);
		return mv;
	}

	@SecurityMapping(title = "楼层模板商品分类保存", value = "/admin/goods_floor_class_save.htm*", rtype = "admin", rname = "首页楼层", rcode = "goods_floor", rgroup = "装修")
	@RequestMapping("/admin/goods_floor_class_save.htm")
	public String goods_floor_class_save(HttpServletRequest request,
			HttpServletResponse response, String id, String ids, String gf_name) {
		GoodsFloor obj = this.goodsfloorService.getObjById(CommUtil
				.null2Long(id));
		obj.setGf_name(gf_name);
		List gf_gc_list = new ArrayList();
		String[] id_list = ids.split(",pid:");
		for (String t_id : id_list) {
			String[] c_id_list = t_id.split(",");
			Map map = new HashMap();
			for (int i = 0; i < c_id_list.length; i++) {
				String c_id = c_id_list[i];
				if (c_id.indexOf("cid") < 0) {
					map.put("pid", c_id);
				} else {
					map.put("gc_id" + i, c_id.substring(4));
				}
			}
			map.put("gc_count", c_id_list.length - 1);
			if (!map.get("pid").toString().equals(""))
				gf_gc_list.add(map);
		}
		// System.out.println(Json.toJson(gf_gc_list, JsonFormat.compact()));
		obj.setGf_gc_list(Json.toJson(gf_gc_list, JsonFormat.compact()));
		this.goodsfloorService.update(obj);
		return "redirect:goods_floor_template.htm?id=" + id;
	}

	@SecurityMapping(title = "楼层模板分类商品编辑", value = "/admin/goods_floor_gc_goods.htm*", rtype = "admin", rname = "首页楼层", rcode = "goods_floor", rgroup = "装修")
	@RequestMapping("/admin/goods_floor_gc_goods.htm")
	public ModelAndView goods_floor_gc_goods(HttpServletRequest request,
			HttpServletResponse response, String currentPage, String id) {
		ModelAndView mv = new JModelAndView(
				"admin/blue/goods_floor_gc_goods.html",
				configService.getSysConfig(),
				this.userConfigService.getUserConfig(), 0, request, response);
		GoodsFloor obj = this.goodsfloorService.getObjById(CommUtil
				.null2Long(id));
		List<GoodsClass> gcs = this.goodsClassService
				.query("select obj from GoodsClass obj where obj.parent.id is null order by obj.sequence asc",
						null, -1, -1);
		mv.addObject("gcs", gcs);
		mv.addObject("obj", obj);
		mv.addObject("gf_tools", this.gf_tools);
		mv.addObject("currentPage", currentPage);
		return mv;
	}

	@SecurityMapping(title = "楼层模板分类商品保存", value = "/admin/goods_floor_gc_goods_save.htm*", rtype = "admin", rname = "首页楼层", rcode = "goods_floor", rgroup = "装修")
	@RequestMapping("/admin/goods_floor_gc_goods_save.htm")
	public String goods_floor_gc_goods_save(HttpServletRequest request,
			HttpServletResponse response, String gf_name, String id, String ids) {
		GoodsFloor obj = this.goodsfloorService.getObjById(CommUtil
				.null2Long(id));
		obj.setGf_name(gf_name);
		String[] id_list = ids.split(",");
		Map map = new HashMap();
		for (int i = 0; i < id_list.length; i++) {
			if (!id_list[i].equals("")) {
				map.put("goods_id" + i, id_list[i]);
			}
		}
		// System.out.println(Json.toJson(map, JsonFormat.compact()));
		obj.setGf_gc_goods(Json.toJson(map, JsonFormat.compact()));
		this.goodsfloorService.update(obj);
		return "redirect:goods_floor_template.htm?id="
				+ obj.getParent().getId() + "&tab=" + id;
	}

	@SecurityMapping(title = "楼层模板右侧商品列表编辑", value = "/admin/goods_floor_list_goods.htm*", rtype = "admin", rname = "首页楼层", rcode = "goods_floor", rgroup = "装修")
	@RequestMapping("/admin/goods_floor_list_goods.htm")
	public ModelAndView goods_floor_list_goods(HttpServletRequest request,
			HttpServletResponse response, String currentPage, String id) {
		ModelAndView mv = new JModelAndView(
				"admin/blue/goods_floor_list_goods.html",
				configService.getSysConfig(),
				this.userConfigService.getUserConfig(), 0, request, response);
		GoodsFloor obj = this.goodsfloorService.getObjById(CommUtil
				.null2Long(id));
		List<GoodsClass> gcs = this.goodsClassService
				.query("select obj from GoodsClass obj where obj.parent.id is null order by obj.sequence asc",
						null, -1, -1);
		mv.addObject("gcs", gcs);
		mv.addObject("obj", obj);
		mv.addObject("gf_tools", this.gf_tools);
		mv.addObject("currentPage", currentPage);
		return mv;
	}

	@SecurityMapping(title = "楼层模板右侧商品列表保存", value = "/admin/goods_floor_list_goods_save.htm*", rtype = "admin", rname = "首页楼层", 