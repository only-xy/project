package com.ifeng.xuyan.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.util.JSONUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ifeng.xuyan.service.impl.*;
import com.ifeng.xuyan.service.IDataService;

@Controller   //spring-mvc中的action层注入  即：控制层
@RequestMapping("time")  //spring注解   后面代表路径
public class TimeController {
	
	@Autowired   //使用该注解  仅需要声明即可
	private IDataService ds;//声明 Spring AOP 特性
	
	@RequestMapping(value = "index", method = RequestMethod.POST)
	public void index(HttpServletRequest request,HttpServletResponse response) {
		 //获得name属性参数 
		 String name = request.getParameter("name");
		 String type = request.getParameter("type");
		 String id = request.getParameter("id");
		 
		 String nameSql = "";
		 if(name!=null&&!("").equals(name)) {
			 nameSql = " and objname = '"+name+"'";
		 }
		 if(type!=null&&!("").equals(type)) {
			 if(type.equals("1")) {
				 nameSql = " and orgid = '"+id+"'";
			 } else if(type.equals("2")){
			 } else {
				 nameSql = " and id = '"+id+"'";
			 }
		 }
		 //时间类
		 java.text.DateFormat format_1 = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	     String s = format_1.format(new Date());
	     System.out.println(s);
	     
	     //实例化DataService对象
	     //DataService ds = new DataService();
	     //调用DataService的方法实现对sql的操作
	     //List list = ds.getValue("select id,objname from humres t where objname like '%"+name+"%'");
	     String sql = "select ID,OBJNAME, f_labelname(t.hrstatus) hrstatus ,f_orgname(t.orgid) orgid, email, tel2 from humres t where 1=1 "+nameSql+"and hrstatus<>'402881ea0b1c751a010b1cd0a73e0004' ";
	     List list = ds.getValue(sql);	     
	     //输出
	     PrintWriter printWriter = null;
	     try {
	       printWriter = response.getWriter();
	       //Json解析 将List对象序列化为JSON文本
	       printWriter.print(JSONArray.fromObject(list));
	     } catch (IOException ex) {

	     } finally {
	       if (null != printWriter) {
	         printWriter.flush();
	         printWriter.close();
	       }
	     }
	}
	
	@RequestMapping(value = "getdept", method = RequestMethod.POST)
	public void getDept(HttpServletRequest request,HttpServletResponse response) {
		 //获得name属性参数 
		 String pid = request.getParameter("pid");
	     String sql = "select ID,OBJNAME from orgunitview where pid='"+pid+"' and orgstatus='87A1302EEB1C4906A3698AA952D2399E'";
	     List list = ds.getValue(sql);	     
	     //输出
	     PrintWriter printWriter = null;
	     try {
		      printWriter = response.getWriter();
		      //Json解析 将List对象序列化为JSON文本
		      printWriter.print(JSONArray.fromObject(list));
	     } catch (IOException exception) {

	     } finally {
	       if (null != printWriter) {
	          printWriter.flush();
	          printWriter.close();
	       }
	     }
	}
	
	
	@RequestMapping(value = "getperson", method = RequestMethod.POST)
	public void getPerson(HttpServletRequest request,HttpServletResponse response) {
		 //获得name属性参数 
		 String id = request.getParameter("id");   
	     String sql = "select id,objname,email,tel2 from humres t where t.orgid='"+id+"' and t.hrstatus='402881ea0b1c751a010b1cd0a73e0003' and t.workstatus='402881ea0b1c751a010b1cd262610007'";
	     List list = ds.getValue(sql);	     
	     //输出流
	     PrintWriter printWriter = null;
	     try {
		     printWriter = response.getWriter();
		     //Json解析 将List对象序列化为JSON文本
		     printWriter.print(JSONArray.fromObject(list));
	     } catch (IOException exception) {

	     } finally {
	       if (null != printWriter) {
	         printWriter.flush();
	         printWriter.close();
	       }
	     }
	}
	
}
