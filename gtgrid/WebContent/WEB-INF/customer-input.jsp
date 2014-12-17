<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/common/taglibs.jsp"%>
<wp:res path="/js/import/common.js" />
<wp:res path="/js/import/grid.js" />
<wp:res path="/js/import/validate.js" />
<wp:res path="/js/import/tree.js" />
<title>RAD复杂示例</title>
<style>
.dynamicform{margin:0 10px 5px;text-align:left}
.dynamicform ul{margin:10px 0 20px 0}
.dynamicform li{padding:5px;overflow:hidden;display:block;*display:inline-block;}
.dynamicform li label{float:left;width:110px;text-align:right;padding-right:5px;}
.dynamicform li span{float:left;width:35%;}
.dynamicform li span label.invalid{display:block;color:red;text-align:left;width:97%}
.dynamicform div.required{float:left;width:10px;color:red}
.dynamicform div.note{float:left;display:inline;padding-left:5px;width:40%}
.dynamicform li span.textarea .note{width:500px;}
.dynamicform ul input,.dynamicform select{width:97%}
.dynamicform textarea{width:500px;}
.dynamicform li span.choose input{width:20px;}
.dynamicform li span.choose label{float:none;}
.dynamicform li.active{background:#fff7c0}
.dynamicform .btn{padding:5px;overflow:hidden;}
.dynamicform .submit{text-align:right;width:30%;float:left;padding-right:30px}
.dynamicform input.button{cursor:pointer;}
.dynamicform .dyngroup{background:#d7f9fe;border:1px solid #a6c8ce;border-radius:3px;color:#00627b;font-size:12px;font-weight:bold;line-height:30px;padding:0 0 0 10px;}
.grid_popup_container{display:none;cursor: default;width:700px;height:400px}
.grid_popup_container .popup_top{ width:100%; height:30px; background:url(../images/skier.png) no-repeat -70px -63px;  line-height:30px; text-align:left}
.grid_popup_container .popup_top_title{float:left;padding-left:1em;height:100%;font-weight:bold; color:#065FB6; }
.grid_popup_container .popup_top_search{float:right;height:100%;margin:auto}
.grid_popup_container .popup_top_search_title{float:left;padding-right:.5em}
.grid_popup_container .popup_top_search_field{float:left;padding-right:.5em}
.grid_popup_container .popup_top_search_button{float:left;padding-right:.5em}
.grid_popup_container .popup_center{width:100%;height:320px}
.grid_popup_container .popup_bottom{width:100%;height:50px;text-align:center;padding:.8em}
</style>
</head>
<body>
<%@ include file="/common/header.jsp"%>
<%@ include file="/common/nav.jsp"%>
<div id="main">
    <div class="main_left"><wp:leftMenu/></div>
	<div class="main_right">
        <div class="main_right_top">
			<c:choose>
			<c:when test="${wp:isNullId(customer.id)}">
				<div class="main_left_top_title">新增客户</div>
			</c:when>
			<c:otherwise>
				<div class="main_left_top_title">修改客户</div>
			</c:otherwise>
			</c:choose>
			<div class="main_right_top_mbx"><div class="ckpz_back_a"><a href="customer.action">返回客户列表</a></div></div>
		</div>
		<div id="content" class="main_right_middle">
		<form id="fieldform" class="dynamicform" method="post">
			<div class="dyngroup">基础信息</div>
			<ul>
				<li>
					<label><wp:i18n name="customer.name" note="客户名称" /></label>
					<span>
						<input type="text" name="customer.name" class="user_input" value="${customer.name}">
					</span>
					<div class="note">该字段后台校验，需非空</div>
				</li>
				<li>
					<label><wp:i18n name="customer.code" note="客户代码" /></label>
					<span>
						<input ${empty customer.id ? '' : 'readonly'} type="text" name="customer.code" class="user_input {required:true,letterdigitdash:true}" value="${customer.code}">
					</span>
					<div class="required"><em>*</em></div>
					<c:choose>
					<c:when test="${empty customer.id}">
					<div class="note">仅含英文、数字、中划线或下划线，不区分大小写，需唯一</div>
					</c:when>
					<c:otherwise>
					<div class="note">不允许修改</div>
					</c:otherwise>
					</c:choose>
				</li>
				<li>
					<label><wp:i18n name="customer.branch" note="所属分公司" /></label>
					<span>
						<wp:paramSelect paramType="<%=DemoConstants.TYPE_BRANCH%>" id="customer.branch" name="customer.branch" value="${customer.branch}"/>
					</span>
					<div class="required"><em>*</em></div>
				</li>
				<li>
					<label><wp:i18n name="customer.vipLevel" note="VIP级别" /></label>
					<span>
						<wp:paramSelect paramType="<%=DemoConstants.TYPE_VIPLEVEL%>" id="customer.vipLevel" name="customer.vipLevel" value="${customer.vipLevel}"/>
					</span>
					<div class="required"><em>*</em></div>
				</li>
				<li>
					<label><wp:i18n name="customer.email" note="邮箱" /></label>
					<span>
						<input name="customer.email" value="${customer.email}">
					</span>
					<div class="note">该字段后台校验，需符合*@lxdns.com</div>
				</li>
				<li>
					<label><wp:i18n name="customer.industry" note="所属行业" /></label>
					<span>
						<input id="industryName" class="user_input {required:true}" value="${customer.industryName}" readonly onclick="showGridPopup(null,'industryDiv',initTree);">
					</span>
					<div class="note"><input type="button" onclick="showGridPopup(null,'industryDiv',initTree);" value="选择行业"></div>
				</li>
				<input type="hidden" id="industry" name="customer.industry" value="${customer.industry}">
			</ul>
			<input type="hidden" name="customer.id" value="${customer.id}">
			<div class="btn">
				<span class="submit"><input class="button" type="submit" value="提交"></span>
				<span class="cancel"><input class="button" type="button" onclick="cancel()" value="返回"></span>
			</div>
		</form>
		</div>
		<div class="main_right_bottom"></div>
	</div>
	<div class="clear"></div>
</div>
<div id="industryDiv" class="grid_popup_container">
	<div class="popup_top">
            <div class="popup_top_title">选择行业</div>
	</div>
	<div class="popup_center"><div id="tree" style="overflow:auto;height:100%"></div></div>
    <div class="popup_bottom">
		<input type="button" class="button" value="取消" onclick="closePopup()"/>
	</div>
</div>
<script>
var selectedItem = null;
function initTree() {
	$.ajax( {
		traditional: true,
		type : "POST",
		url : "customer!initTree.action",
		data : {},
		dataType : "text",
		cache : false,
		success : function(data, textStatus) {
			var o = {
			    showcheck: false,
			    onnodeclick: selectNode
			};
			o.data = $.parseJSON(data);
			$("#tree").treeview(o);
			selectedItem = null;
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			closePopup();
			alert("Invoke ajax error:" + textStatus + " " + errorThrown);
		}
	});
};
function selectNode(item) {
	selectedItem=item;
	if(selectedItem.hasChildren){
		alert("请选择一个叶子节点");
		return;
	}
	var rootNode = selectedItem.parent;
	var nodeValue = selectedItem.text;
	while(rootNode.id!='0'){
		nodeValue = rootNode.text+"-"+nodeValue;
		rootNode = rootNode.parent;
	}
	$('#industryName').val(nodeValue);
	$('#industry').val(selectedItem.id);
	closePopup();
};
function cancel() {
	window.history.back(-1);
};
function save(form) {
	var data=$(form).serialize();
	Util.doAjaxPost("customer!save.action",data,function(text){
		var rst=jQuery.parseJSON(text);
		if (rst.success){
			location.href = "customer!view.action?id=" + rst.param;
		}
		else {
			alert(rst.msg);
		}
	});
};
function validate() {
	$("#fieldform").validate({
		submitHandler: function(form){save(form);},
		errorClass:"invalid",
		validClass:"valid",
		errorPlacement:function(error, element) {
            error.appendTo(element.parent());
      	}
	});
};
$(document).ready(function(){
	$('input[placeholder],textarea[placeholder]').placeholder();
	$(".dynamicform ul :input").bind("focus",function(){
		$(this).parent().parent().addClass("active");
	}).bind("blur",function(){
		$(this).parent().parent().removeClass("active");
	});
	validate();
});
</script>
</body>
</html>