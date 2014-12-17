<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/common/taglibs.jsp"%>
<wp:res path="/js/import/common.js" />
<wp:res path="/js/import/grid.js" />
<title>RAD复杂示例</title>
<style>
.dynamicform{margin:0 10px 5px;text-align:left}
.dynamicform ul{margin:10px 0 20px 0}
.dynamicform li{padding:5px;overflow:hidden;}
.dynamicform li label{float:left;width:120px;text-align:right;padding-right:15px;font-weight:bold}
.dynamicform li span{float:left;width:500px;}
.dynamicform ul input,.dynamicform select,.dynamicform textarea{width:97%}
.dynamicform li span.choose input{width:20px;}
.dynamicform li span.choose label{float:none;}
.dynamicform .btn{padding:5px;overflow:hidden;}
.dynamicform .submit{text-align:right;width:30%;float:left;padding-right:30px}
.dynamicform input.button{cursor:pointer;}
.dynamicform .dyngroup{background:#d7f9fe;border:1px solid #a6c8ce;border-radius:3px;color:#00627b;font-size:12px;font-weight:bold;line-height:30px;padding:0 0 0 10px;}
.dynamicform pre{margin:0;padding:0;white-space:pre-wrap;word-wrap: break-word;}
.gridtitle {background:#d7f9fe;border:1px solid #a6c8ce;border-radius:3px;color:#00627b;font-size:12px;font-weight:bold;line-height:30px;padding:0 0 0 10px;text-align:left;margin:10px auto;width:96%;}
.grid{margin:0 5px 5px;}
</style>
</head>
<body>
<%@ include file="/common/header.jsp"%>
<%@ include file="/common/nav.jsp"%>
<div id="main">
    <div class="main_left"><wp:leftMenu/></div>
	<div class="main_right">
        <div class="main_right_top">
			<div class="main_left_top_title">复杂示例-查看客户</div>
			<div class="main_right_top_mbx"><div class="ckpz_back_a"><a href="customer.action">返回客户列表</a></div></div>
		</div>
		<div id="content" class="main_right_middle">
		<div style="padding:3px;font-weight:bold;font-size:14px;">当前客户：<c:out value="${customer.name}" /> - <c:out value="${customer.code}" /></div>
		<form id="fieldform" class="dynamicform" method="post" onsubmit="return false;">
			<div class="dyngroup">基础信息</div>
			<ul>
				<li>
					<label><wp:i18n name="customer.name" note="客户名称" /></label>
					<span>
						<c:out value="${customer.name}" />
					</span>
				</li>
				<li>
					<label><wp:i18n name="customer.code" note="客户代码" /></label>
					<span>
						<c:out value="${customer.code}" />
					</span>
				</li>
				<li>
					<label><wp:i18n name="customer.branch" note="所属分公司" /></label>
					<span>
						<wp:paramText plain="true" paramType="<%=DemoConstants.TYPE_BRANCH%>" paramValue="${customer.branch}"/>
					</span>
				</li>
				<li>
					<label><wp:i18n name="customer.vipLevel" note="VIP级别" /></label>
					<span>
						<wp:paramText plain="true" paramType="<%=DemoConstants.TYPE_VIPLEVEL%>" paramValue="${customer.vipLevel}"/>
					</span>
				</li>
				<li>
					<label><wp:i18n name="customer.email" note="邮箱" /></label>
					<span>
						<c:out value="${customer.email}" />
					</span>
				</li>
				<li>
					<label><wp:i18n name="customer.industry" note="所属行业" /></label>
					<span>
						<c:out value="${customer.industryName}" />
					</span>
				</li>
			</ul>
			<input type="hidden" name="customer.id" value="${customer.id}">
			<div class="btn">
				<span class="submit"><input class="button" type="button" onclick="cancel()" value="返回"></span>
			</div>
		</form>
		</div>
		<div class="main_right_bottom"></div>
	</div>
	<div class="clear"></div>
</div>
<script>
function cancel() {
	location.href="customer.action";
};
</script>
</body>
</html>