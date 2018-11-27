package com.ifeng.xuyan.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ifeng.xuyan.service.IDataService;

import net.sf.json.util.JSONUtils;

@Service("ds")
public class DataService implements IDataService{
	@SuppressWarnings("finally")//给编译器一条指令，告诉它对被批注的代码元素内部的某些警告保持静默

	public  ArrayList<Map<Object,Object>> getValue(String sql) {
		ArrayList<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
		//Oracle数据库链接    IO异常抛出
		Connection connect = null;
        Statement statement = null;
        ResultSet resultSet = null;
		try {
			Class.forName("oracle.jdbc.OracleDriver"); 
			connect = DriverManager.getConnection("jdbc:oracle:thin:@10.21.6.85:1521:AMT", "amt20170207", "1");
			statement = connect.createStatement();
			resultSet = statement.executeQuery(sql);
			//ReaultSet 动态获取列名
			ResultSetMetaData rsmd = resultSet.getMetaData(); //获得列集
			int Columncount = rsmd.getColumnCount();   //获得列的个数
			
			while (resultSet.next()) {
				Map<Object,Object> map = new HashMap<Object,Object>();
				for(int i=1;i<=Columncount;i++) {
					String key = rsmd.getColumnLabel(i);
					key = key.toLowerCase();
					String value = resultSet.getString(key);
					map.put(key, value);
			    }
				
				list.add(map);
				
            }
			System.out.println(sql);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
            //关闭资源
            try {
                if (resultSet!=null) resultSet.close();
                if (statement!=null) statement.close();
                if (connect!=null) connect.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return list;
    }
	}

 }
