<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Cache-Control" content="no-cache" />
<title>GT-Grid 教程示例</title>

<link rel="stylesheet" type="text/css" href="common/grid/gt_grid.css" />

<!-- 请根据语言和系统编码,自行选择引入的 gt_msg_...js 文件 (默认的msg文件为UTF-8编码) -->
<script type="text/javascript" src="common/grid/gt_msg_cn.js"></script>


<script type="text/javascript" src="common/js/jquery.js"></script>

<script type="text/javascript" src="common/grid/gt_grid_all.js"></script>


<script type="text/javascript" >
var data2 = [{ no :0, name :'stu0', age :26, gender : '0' , english : 105.63 , math :123.73 },{ no :1, name :'stu1', age :66, gender : '-1' , english : 14.12 , math :79.25 },{ no :2, name :'stu2', age :59, gender : '-2' , english : 67.98 , math :118.03 },{ no :3, name :'stu3', age :17, gender : '-3' , english : 31.57 , math :40.19 },{ no :4, name :'stu4', age :75, gender : '-4' , english : 80.99 , math :101.73 },{ no :5, name :'stu5', age :29, gender : '-5' , english : 51.57 , math :88.57 },{ no :6, name :'stu6', age :39, gender : '-6' , english : 83.58 , math :114.56 },{ no :7, name :'stu7', age :62, gender : '-7' , english : 83.67 , math :111.72 },{ no :8, name :'stu8', age :38, gender : '-8' , english : 84.91 , math :102.52 },{ no :9, name :'stu9', age :37, gender : '-9' , english : 96.15 , math :128.03 }];


 // 教程中的代码就写在这个区域里.
/* var data1 = [
   { no : 1 , name :'aaa', age : 12, gender : 'M' , english : 76.5 , math :92 },
   { no : 2 , name :'bbb', age : 11, gender : 'F' , english : 89   , math :87 },
   { no : 3 , name :'ccc', age : 13, gender : 'F' , english : 53   , math :62 }
];

 
 */
 function  postListString(){
	 $.ajax({
	     type: "POST",
	     url: "<%=path%>/server/getStu",
	     contentType: "application/json",
	     dataType: "json",
	     data: JSON.stringify({ "BuIds": ["1", "2", "3"] }),
	     success: function (jsonResult) {
	        alert(jsonResult);
	        return jsonResult;
	     }
	 });
 }
 var data3 = postListString();

var dsConfig= {
	data :  data2,  	
	fields :[
		{name : 'no'     ,  type: 'int'    },
		{name : 'name'      },
		{name : 'age'    ,  type: 'int'    },
		{name : 'gender'    },
		{name : 'english',  type: 'float'  },
		{name : 'math'   ,  type: 'float'  },
		/* {name : 'total'   , type: 'float',
			initValue : function(record){
				return record['english'] + record['math'];
			}
		} */
	]
};

var colsConfig = [
		{ id : 'no'      , header : "学号" , width : 50},
		{ id : 'name'    , header : "姓名" , width : 100},
		{ id : 'age'     , header : "年龄" , width : 50},
		{ id : 'gender'  , header : "性别" , width : 50 ,
			renderer : GT.Grid.mappingRenderer(  {'U': '未知' , 'M':'男', 'F':'女'} , '未知' )
		},
		{ id : 'english' , header : "英语" , width : 60 , align :'right' },
		{ id : 'math'    , header : "数学" , width : 60 , align :'right' },
	 	{ id : 'total'   , header : "总成绩" , width : 70 , align :'right' ,
			renderer : function(value ,record,columnObj,grid,colNo,rowNo){
				   var total = record['total'];
				   if (total>170) {
						total =  '<span style="color:red" >'+ total +'</span>';
				   }else if (total<120) {
						total = '<span style="color:blue" >'+ total +'</span>';
				   }
				   return total;
			}
		},

		{ id : 'detail'   , header : "详细信息" , width : 120,
			renderer : function(value ,record,columnObj,grid,colNo,rowNo){
				return '&#160;<a href=".?no='+record['no']+'" style="margin-left:3px;" >&#160;'+ record['name'] +' 的详细信息&#160;</a>';
			}
		}
		
];

var gridConfig={

	id : "grid1",

	 
	//loadURL : 'server/getStu', 
	
	remotePaging :false,
	
	width: "700",  //"100%", // 700,
	height: "330",  //"100%", // 330,
	
	dataset : dsConfig ,

	columns : colsConfig ,

	container : 'grid1_container', 

	toolbarPosition : 'bottom',

	toolbarContent : 'state'



};


var mygrid=new GT.Grid( gridConfig );

GT.Utils.onLoad( function(){
	mygrid.render();
} );


</script>
</head>

<body >
<!-- grid的容器. -->
<div id="grid1_container" style="width:700px;height:300px">
</div>

 </body>
</html>