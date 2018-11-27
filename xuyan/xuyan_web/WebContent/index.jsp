<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="keywords" content="jquery,ui,easy,easyui,web">
	<meta name="description" content="easyui help you build your web page easily!">
	<link rel="stylesheet" type="text/css" href="http://www.w3cschool.cc/try/jeasyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="http://www.w3cschool.cc/try/jeasyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="http://www.w3cschool.cc/try/jeasyui/demo/demo.css">
	<link rel="stylesheet" href="https://static.runoob.com/assets/js/jquery-treeview/jquery.treeview.css" />
	<link rel="stylesheet" href="https://static.runoob.com/assets/js/jquery-treeview/screen.css" />
	<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
	<script src="https://static.runoob.com/assets/js/jquery-treeview/jquery.cookie.js"></script>
	<script src="https://static.runoob.com/assets/js/jquery-treeview/jquery.treeview.js" type="text/javascript"></script>
	<script type="text/javascript" src="http://www.w3cschool.cc/try/jeasyui/jquery.easyui.min.js"></script>
<style type="text/css">
	th.nobg {
			 border-top: 0;
			 border-left: 0;
			 border-right: 1px solid #C1DAD7;
			 background: none;
	}
	td.alt {
			 background: #F5FAFA;
			 color: #797268;
	
	}
	.filetree span.folder, .filetree span.file{
		cursor:pointer;   /* 光标变手型 */
	}
	#fm{
			margin:0;
			padding:10px 30px;
		}
	.ftitle{
			font-size:14px;
			font-weight:bold;
			color:#666;
			padding:5px 0;
			margin-bottom:10px;
			border-bottom:1px solid #ccc;
	}
	.fitem{
			margin-bottom:5px;
	}
	.fitem label{
			display:inline-block;
			width:80px;
	}	
</style>
<title>test_demo</title>
</head>
<body>
	<div id="main" style="width:1200px;">
	<!-- 树形结构 -->
	<div id="left" style="width:300px;float:left;">
	<ul id="browser" class="filetree treeview">
		<!-- 部门id -->
		<li><span class="folder" id="402881e70ad1d990010ad1e5ec930008"> <a href='javascript:void(0)'>凤凰网</a></span></li>
	</ul>
	</div>
	
	<!-- 表格结构 -->
	<div id="right" style="width:900px;float:right;">
	<div class="demo-info" style="margin-bottom:10px;">
		<div class="demo-tip icon-tip">&nbsp;</div>
		<div>
		姓名：<input id = "name" name = "name"></input>
					<button onclick="doFindByName()">查询</button>
				</div>
	</div>
	
	<table id="datagrid" title="人员信息" class="easyui-datagrid" style="width:900px;height:500px"
			url="get_users.php"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="true">  <!-- 动态显示与隐藏  显示中文 行号  自动展开收缩网格的宽度  单选 -->
		<thead>
			<tr>
				<th field="id" width="50">ID</th>
				<th field="name" width="50">姓名</th>
				<th field="hrstatus" width="50">人事状态</th>
				<th field="orgid" width="50">部门</th>
				<th field="email" width="50">邮箱</th>
				<th field="tel2" width="50">电话</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
	<!-- 将标签渲染成对话框 -->
	<!-- iconCls：动态修改 -->
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新建用户</a>  
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑用户</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeUser()">删除用户</a>
	</div>
	<!-- 对话框信息 -->
	<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<div class="ftitle">用户信息</div>
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<label>ID:</label>
				<input name="id" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>姓名:</label>
				<input name="name" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>人事状态:</label>
				<input name="hrstatus">
			</div>
			<div class="fitem">
				<label>部门:</label>
				<input name="orgid">
			</div>
			<div class="fitem">
				<label>Email:</label>
				<input name="email" class="easyui-validatebox" validType="email">
			</div>
			<div class="fitem">
				<label>电话:</label>
				<input name="tel2" class="easyui-validatebox" validType="tel">
			</div>
		</form>
	</div>
	<!-- 对话框按钮-->
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">Save</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>
	</div>
	</div>
	</div>
</body>

<script type = "text/javascript">	

	function dofind(param) {
		var url = "${pageContext.request.contextPath}/time/index";
		
		//查询需要载入的数据
		getDateGrid();
		getData(url,param);
	}
	//姓名查找 name
	function doFindByName(){
		var searchname = $("#name").val();//从input框中获取输入的name的值
		var  param= {"name":searchname,"type":"2"};
		dofind(param);		
	}
	
	//部门查找id
	function searchdept(deptid){
		var  param= {"id":deptid,"type":"1"};
		dofind(param);
	}
	
	//通过id查人
	function searchPerById(id){
		var  param= {"id":id,"type":"3"};
		dofind(param);
	}
	
	/*
	**得到数据网格
	*/
	
	$(document).ready(function(){
		//初始载入数据
		loadData();
		//刷新数据
		reload();
	
	});
	
	//初始载入数据
	function loadData()
	{
		var url = "${pageContext.request.contextPath}/time/index";
		var param = null;
		//查询需要载入的数据
		getDateGrid();
		getData(url,param);
	};
	
	//在表格中载入数据
	function getDateGrid(){
		  $('#datagrid').datagrid({
				rownumbers:true,	
				singleSelect:false,	
				pageSize:20,           	
				pagination:true,	
				multiSort:true,	
				fitColumns:true,	
				fit:true,	
				columns:[[	
				    {checkbox:true},	
					{ field:'id',title:'ID',width:100,sortable:true},	
					{ field:'objname',title:'姓名',width:100,sortable:true},	
					{ field:'hrstatus',title:'人事状态',width:100},	
					{ field:'orgid',title:'部门',width:100},	
					{ field:'email',title:'邮箱',width:100},	
					{ field:'tel2',title:'电话',width:100}
				]]
			});    
	}
	//Ajax发送请求  获取数据
	function getData(url,param)
	{
		$.ajax({
			url: url,
			type: "POST",
			async : false,
			data:param,
	        dataType: "json",
	        timeout: 20000,
	        success : function (result_1) {
	        	reLodadDateGrid(result_1);
	        },
	        error : function (result_1){
	        }
	    });
	}
	//组装dataGrid数据
	function reLodadDateGrid(result_1)
	{
		var values = [];//声明一个数组  遍历
			for(var i = 0; i <result_1.length; i++) {
				//a对象  存在6个属性
	         var a = {
	             'id' : result_1[i].id,
	             'objname' : result_1[i].objname,
	             'hrstatus' : result_1[i].hrstatus,
	             'orgid' : result_1[i].orgid,
	             'email' : result_1[i].email,
	             'tel2' : result_1[i].tel2
	         };
	         //将参数添加到原数组后  并返回 数组长度
	         values.push(a);
	     }
	 	 $('#datagrid').datagrid('loadData', values);
	 	 
	}
	
	//刷新纪录
	function reload()
	{
		$("#customer-reload").click(function(){
			$.messager.confirm('信息提示','确定要刷新？', function(result)
			{
				loadData();
			});
		});
	}

	//获取部门的数据
	function doFindDept(deptid) {
		var target=$("#"+deptid);
		if(target.parent().attr("class").indexOf("expandable")>=0){
			//定义一个ul标签
			var container=$("<ul>");
			getperson(deptid,container);
			//判断li标签是否有expandable类
			$.ajax({
		        type: "POST",
		        data:{"pid":deptid},
		        url: "${pageContext.request.contextPath}/time/getdept",
		        dataType: "json", 
		        async: false,     
					success: function(result_2){
						var str ="";
						for(var i=0;i<result_2.length;i++)
						{
							//获取部门id和部门name
							var id = result_2[i].id;
							var objname = result_2[i].objname;
							str += "<li class=\"expandable\" id=\"li_"+id+"\"><div class=\"hitarea expandable-hitarea\"></div><span  class='folder' id='"+id+"' name='deptid'> "+objname+" </span></li>";
						}	
						container.append(str);
						$("#"+deptid).append(container);
						
						//绑定事件
						$("#"+deptid).find("li").click(function(event){
							event.stopPropagation(); 
							var ids=$(this).attr("id");
							doFindDept(ids.substr(3,ids.length));
							searchdept(ids.substr(3,ids.length));
						});
						
						target.parent().removeClass("expandable");
						target.parent().addClass("collapsable");
						target.prev().removeClass("hitarea expandable-hitarea");
						target.prev().addClass("hitarea collapsable-hitarea");
		        }
			});
		}else{
			target.find("ul").remove();
			target.parent().removeClass("collapsable");
			target.parent().addClass("expandable");
			target.prev().removeClass("hitarea collapsable-hitarea");
			target.prev().addClass("hitarea expandable-hitarea");
		}
		
	}
	

	//初始化部门数据 
	function init(deptid) {
		$.ajax({
	        type: "POST",
	        data:{"pid":deptid},
	        url: "${pageContext.request.contextPath}/time/getdept",
	        dataType: "json", 
	        async: false,     
				success: function(result_2){
					var str ="";
					str +="<ul>";
					for(var i=0;i<result_2.length;i++)
					{
						//获取部门id和部门name
						var id = result_2[i].id;
						var objname = result_2[i].objname;
						str += "<li class=\"expandable\" style=\"cursor:hand\" id=\"li_"+id+"\"><div class=\"hitarea expandable-hitarea\"></div><span class='folder' id='"+id+"' name='deptid'>"+objname+"</span></li>";
					}	
					str +="</ul>";
					$("#"+deptid).append(str);
					
					//绑定事件
					$("#"+deptid).find("li").click(function(event){
						event.stopPropagation(); 
						var ids=$(this).attr("id");
						doFindDept(ids.substr(3,ids.length));
						searchdept(ids.substr(3,ids.length));
					});
	        }
		});
	}
	//获取人员数据
	function getperson(deptid,container) {
		$.ajax({
	        type: "POST", //请求方式
	        data:{"id":deptid},
	        url: "${pageContext.request.contextPath}/time/getperson", //地址，就是json文件的请求路径
	        dataType: "json", //数据类型可以为 text xml json  script  jsonp
	        async: false,     //是否异步刷新
				success: function(result){//返回的参数就是 action里面所有的有get和set方法的参数
	 			//$("#time").text(result);
					//遍历result数组
					var str ="";
					for(var i=0;i<result.length;i++)
					{
						var id = result[i].id;
						var objname = result[i].objname;
						str += " <li class='last'><span class='file' id='"+id+"'><a href='#' onclick=searchPerById('"+id+"')>"+objname+"</a></span></li>";
					}
					container.append(str);
					$("#"+deptid).append(container);
	        }
		});
	}
	
	$(document).ready(function(){
		init("402881e70ad1d990010ad1e5ec930008");
		$("#browser").treeview({
			toggle: function() {
				alert("hello");
			}	
	   });
	});
	</script>
	<script type="text/javascript">
		var url;
		function newUser(){
			$('#dlg').dialog('open').dialog('setTitle','新用户');
			$('#fm').form('clear');
			url = 'save_user.php';
		}
		function editUser(){
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#dlg').dialog('open').dialog('setTitle','Edit User');
				$('#fm').form('load',row);
				url = 'update_user.php?id='+row.id;
			}
		}
		function saveUser(){
			$('#fm').form('submit',{
				url: url,
				onSubmit: function(){
					return $(this).form('validate');
				},
				success: function(result){
					var result = eval('('+result+')');
					if (result.success){
						$('#dlg').dialog('close');		
						$('#dg').datagrid('reload');	
					} else {
						$.messager.show({
							title: 'Error',
							msg: result.msg
						});
					}
				}
			});
		}
		function removeUser(){
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$.messager.confirm('Confirm','Are you sure you want to remove this user?',function(r){
					if (r){
						$.post('remove_user.php',{id:row.id},function(result){
							if (result.success){
								$('#dg').datagrid('reload');	// reload the user data
							} else {
								$.messager.show({	// show error message
									title: 'Error',
									msg: result.msg
								});
							}
						},'json');
					}
				});
			}
		}
	</script>
</html>