<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>个人信息</title>
		<link rel="shortcut icon" href="favicon.ico">
	    <link href="${ctx!}/hadmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/bootstrap-treeview.css?v=3.3.6" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/animate.css" rel="stylesheet">
	    <link href="${ctx!}/hadmin/css/style.css?v=4.1.0" rel="stylesheet">
	</head>
	<body>
		<div class="perbox">
			<table class="tabperson">
				<tr>
					<td class="text-right" width="20%"><img class="radius" width="40" height="40" src="<#if user.imageUrl?exists>${user.imageUrl}<#else>${ctx!}/hadmin/img/header.png</#if>"/></td>
					<td width="70%">
						<div class="name">${user.humanName}</div>
						<div class="darpat">
							<#if units?exists>
								<#list units as unit>
									${unit.unitName}
									<#if departments?exists>
											<#list departments as department>
												<#if department.unitId==unit.id>
														/${department.name}
														<#if posts?exists>
															<#list posts as post>
																<#if post.unitId==unit.id&&post.departmentId==department.id>
																	/${post.name}
																</#if>
															</#list>
														</#if>
												</#if>
											</#list>
									</#if>
								</#list>
							</#if>
						</div>
					</td>
				</tr>
				<tr>
					<td class="text-right">手机号码:</td>
					<td width="70%">
						${user.phone}
					</td>
				</tr>
				<tr>
					<td class="text-right">办公电话:</td>
					<td width="70%">
						${user.officePhone}
					</td>
				</tr>
				<tr>
					<td class="text-right">邮箱地址:</td>
					<td width="70%">
						${user.email}
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
