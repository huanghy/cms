Id(CommUtil
							.null2Long(goods_id));
					if (type.equals("goods") && goods != null) {
						map.put("type", type);
						map.put("module_id", module_id);
						map.put("goods_id", goods_id);
						map.put("img_url", goods.getGoods_main_photo()
								.getPath()
								+ "/"
								+ goods.getGoods_main_photo().getName());
						map.put("goods_price", goods.getGoods_price());
						map.put("store_price", goods.getGoods_current_price());
						map.put("goods_name", goods.getGoods_name());
						map.put("href_url", CommUtil.getURL(request)
								+ "/goods_" + goods_id + ".htm");
					}
					if (type.equals("img")) {
						String uploadFilePath = this.configService
								.getSysConfig().getUploadFilePath();
						String saveFilePathName = request.getSession()
								.getServletContext().getRealPath("/")
								+ uploadFilePath + File.separator + "advert";
						Map map1 = new HashMap();
						try {
							map1 = CommUtil.saveFileToServer(request, "img",
									saveFilePathName, null, null);
							if (map1.get("fileName") != "") {
								map.put("type", type);
								map.put("module_id", module_id);
								map.put("goods_id", "");
								map.put("goods_price", "");
								map.put("store_price", "");
								map.put("goods_name", "");
								map.put("img_url",
										uploadFilePath
												+ "/advert/"
												+ CommUtil.null2String(map1
														.get("fileName")));
							}
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						map.put("href_url", request.getParameter("adv_url"));
					}
					if (type.equals("adv")) {
						AdvertPosition ap = this.advertPositionService
								.getObjById(CommUtil.null2Long(adv_id