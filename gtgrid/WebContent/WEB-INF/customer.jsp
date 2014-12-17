<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/common/taglibs.jsp"%>
<wp:res path="/js/import/common.js" />
<wp:res path="/js/import/grid.js" />
<title>RAD复杂示例</title>
<style>
.grid{margin:10px 5px 5px;height:470px;}
.placeholder { color: #aaa; }
.queryTable tr{height:30px}
.queryTable td select{width:96%}
</style>
</head>
<body>
<%@ include file="/common/header.jsp"%>
<%@ include file="/common/nav.jsp"%>
<div id="main">
    <div class="main_left"><wp:leftMenu/></div>
	<div class="main_right">
        <div class="main_right_top">
			<div class="main_left_top_title">复杂示例-列表查询</div>
		</div>
		<div id="content" class="main_right_middle">
			<table cellspacing="0" cellpadding="0" align="center" width="710">
			  <tr>
				<td class="xx_ti_left"></td>
				<td class="xx_ti_center" align="left" width="702">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr>
                           <td width="5">&nbsp;</td>
                           <td width="60" class="xx_ti_title">客户管理</td>
                           <td width="13" class="ser_fg_line">&nbsp;</td>
                           
                            <td><table border="0" cellpadding="0" cellspacing="0">
                             <tr>
                               <td width="45"><div class="xx_add"><a href="javascript:doOnAdd();" />新增</a></div></td>
							   <td width="45"><div class="xx_modi"><a href="javascript:doOnUpdate();"/>修改</a></div></td>
                               <td width="45"><div class="xx_del"><a href="javascript:void(0);return false;" onclick="javascript:doOnDelete();"/>删除</a></div></td>
                               <td width="45"><div class="xx_pz"><a href="javascript:doOnView();" />查看</a></div></td>
                             </tr>
                           </table>
                           </td>					                             
                           <td align="right">&nbsp;</td>
                         </tr>
                       </table></td>
				<td class="xx_ti_right"></td>
			  </tr>
			  <tr><td colspan="3">
              	<div style="margin:10px 0 0;padding:5px;background:#f0f0f0;border-radius:5px;text-align:center">
              	  <form id="advSearch" style="margin:0;padding:0"><table border="0" cellspacing="0" cellpadding="0" style="margin:auto;width:100%" class="queryTable">
              	  <tr height="30">
              	  	<td align="right">客户：</td>
              	  	<td colspan="3"><input style="width:96%" type="text" id="q_name" name="q_name_like_s" placeholder="客户名/英文简称/ID" title="支持按 客户名/英文简称/ID 查找"></td>
              	  	<td align="right">状态：</td>
              	  	<td><wp:paramSelect paramType="<%=DemoConstants.TYPE_CUSTOMER_STATUS %>" id="q_status" name="q_status_eq_s" blank="true"/></td>
              	  </tr>
              	  <tr height="30">
              	  	<td align="right">邮箱：</td>
              	  	<td><input type="text" id="q_csman" name="q_email_like_s" placeholder="客户邮箱"></td>
              	  	<td align="right">所属分公司：</td>
              	  	<td><wp:paramSelect paramType="<%=DemoConstants.TYPE_BRANCH%>" id="q_branch" name="q_branch_eq_s" blank="true"/></td>
              	  	<td align="right">VIP级别：</td>
              	  	<td><wp:paramSelect paramType="<%=DemoConstants.TYPE_VIPLEVEL%>" id="q_viplevel" name="q_viplevel_eq_s" blank="true"/></td>
              	  </tr>
              	  <tr height="30">
              	  	<th align="center" colspan="6">
              	  		<input type="button" id="find_cust_advance" style="margin-right:80px;" name="find_cust_advance" value="查询" class="nr_1_btn" onclick="doOnQuery();"/>
						<input type="button" id="clean_cust_advance_con" name="clean_cust_advance_con" value="重置" class="nr_1_btn" onclick="document.getElementById('advSearch').reset()"/>
					</th>
              	  </tr>
              	  </table></form>
              	</div>
			  </td></tr>
			</table>
			<div id="customer_container" class="grid"></div>
		</div>
		<div class="main_right_bottom"></div>
	</div>
	<div class="clear"></div>
</div>
</body>
<script>
var custGrid = window.custGrid || (function(){
	var custDs= {
	  	fields :[
	        {name:'id'},
	       	{name:'name'},
	       	{name:'branch'},
	       	{name:'code'},
	       	{name:'email'},
	       	{name:'vipLevel'},
	       	{name:'status'},
	       	{name:'creator'}
	   	]
	};
	var custCols = [
		{id:'id', header:"ID", hidden:true},
	    {id:'name', header:"客户名称", width:200},
	    {id:'branch', header:"所属分公司", width:80,renderer:Sigma.Grid.mappingRenderer(<%=ParamServiceUtil.getComParamJson(DemoConstants.TYPE_BRANCH,locale)%>)},
		{id:'code', header:"英文简称", width:80},
	    {id:'email', header:"邮箱", width:125},
	    {id:'vipLevel', header:"VIP级别", width:60,renderer:Sigma.Grid.mappingRenderer(<%=ParamServiceUtil.getComParamJson(DemoConstants.TYPE_VIPLEVEL,locale)%>)},
		{id:'status', header:"状态", width:45,
	    	renderer:function(value){
	    		var map=<%=ParamServiceUtil.getComParamJson(DemoConstants.TYPE_CUSTOMER_STATUS,locale)%>;
	    		var color="green";
	    		if(<%=DemoConstants.VALUE_CUST_STATUS_SUSPEND%>==value){
	        		color="red";
	        	}
	    		else if(<%=DemoConstants.VALUE_CUST_STATUS_LOCK%>==value){
	        		color="blue";
	        	}
	        	return "<span style='color:"+color+"'>"+map[value]+"</span>";
	        }
	    }
	];
	<wp:hasPermission permissionCode="<%=DemoConstants.FUNC_MANAGE_CUST%>">
	custCols.push({id:'oper',header:'操作',width:95,renderer:function(value,record,col,grid,colNo,rowNo){
		var content="";
		if(<%=DemoConstants.VALUE_CUST_STATUS_ACTIVE%>==record.status){
			content+="<a href='javascript:void(0)' onclick='doOnSuspend("+rowNo+")'>[挂起]</a>&nbsp;";
		}
		if(<%=DemoConstants.VALUE_CUST_STATUS_SUSPEND%>==record.status){
			content+="<a href='javascript:void(0)' onclick='doOnActivate("+rowNo+")'>[启用]</a>&nbsp;";
		}
		return content;
	}});
	</wp:hasPermission>

	var custConfig={
		id : "custGrid",
		queryId : "CUSTOMER",
		dataset : custDs,
		columns : custCols,
		container : 'customer_container',
		pageSize : 50,
		pageSizeList : [50,100,500,2000],
		toolbarContent : 'nav | goto | pagesize | reload | state',
		loadURL : '${ctx}/common/gt-grid!load.action',
		saveURL : '${ctx}/common/gt-grid!save.action',
		autoLoad : false,
		remotePaging : true,
		beforeExport : function() {
			var params=$("#advSearch").serializeQueryObject();
	        custGrid.exportURL = 'customer!export.action?params=' + encodeURIComponent(JSON.stringify(params));
		},
		onRowDblClick:doOnView
	};
	var instanceGrid = new Sigma.Grid( custConfig );
	
	return instanceGrid;
})();

function getSelectedCust(){
	var record=custGrid.getSelectedRecord();
	return record;
};

<wp:hasPermission permissionCode="<%=DemoConstants.FUNC_MANAGE_CUST%>">
function doOnAdd(){
	window.location.href="customer!add.action";
};
function doOnUpdate(){
	var cust=getSelectedCust();
	if(cust){
		var id=cust.id;
		window.location.href="customer!update.action?id="+id;
		return false;
	}
	alert("请选择要操作的客户！");
};
function doOnDelete(){
	var cust=getSelectedCust();
	if(cust) {
		if(cust.status!="<%=DemoConstants.VALUE_CUST_STATUS_SUSPEND%>"){
			alert("该客户未挂起，不能删除。");
			return false;
		};
		if(cust.creator!="${principal.id}") {
			if(!confirm("您正在操作其他人的客户，是否继续？")) {
				return false;
			};
		}
		if(confirm("确定要删除客户:"+cust.name+"("+cust.code+")"+"?")){
			Util.doAjaxPost("customer!delete.action",{id:cust.id},function(text){
				var rst=jQuery.parseJSON(text);
				alert(rst.msg);
				if(rst.success) custGrid.reload(true);
			});
		}
		return false;
	}
	alert("请选择要操作的客户！");
};
function doOnSuspend(rowNo) {
	var record=getSelectedCust();
	if(rowNo) {
		record=custGrid.getRecord(rowNo);
	}
	if(record.creator!="${principal.id}") {
		if(!confirm("您正在操作其他人的客户，是否继续？")) {
			return false;
		}
	}
	if(<%=DemoConstants.VALUE_CUST_STATUS_ACTIVE%>!=record.status) {
		alert("该客户已锁定或挂起，不能再次挂起！");
		return false;
	}
	if(confirm("确定要挂起客户:"+record.name+"("+record.code+")"+"?")){
		Util.doAjaxPost("customer!suspend.action",{id:record.id},function(text){
			var rst=jQuery.parseJSON(text);
			alert(rst.msg);
			if(rst.success) custGrid.reload(true);
		});
	}
	return false;
};
function doOnActivate(rowNo) {
	var record=getSelectedCust();
	if(rowNo) {
		record=custGrid.getRecord(rowNo);
	}
	if(record.creator!="${principal.id}") {
		if(!confirm("您正在操作其他人的客户，是否继续？")) {
			return false;
		}
	}
	if(!confirm("你确定要重新启用该客户？")) {
		return false;
	}
	Util.doAjaxPost("customer!activate.action?id="+record.id,null,function(text){
		var rst=jQuery.parseJSON(text);
		alert(rst.msg);
		if(rst.success) {
			custGrid.reload(true);
		};
	});
};
</wp:hasPermission>
function doOnView(){
	var cust=getSelectedCust();
	if(cust){
		var id=cust.id;
		window.location.href="customer!view.action?id="+id;
		return false;
	}
	alert("请选择要操作的客户！");
};
function doOnQuery() {
	var params=$("#advSearch").serializeQueryObject();
	custGrid.query(params);
};

$(function(){
	$('input[placeholder],textarea[placeholder]').placeholder();
	$("#advSearch").bindEnterQuery(doOnQuery);
	custGrid.render();
	//custGrid.reload(true);
});

	
</script>
</html>