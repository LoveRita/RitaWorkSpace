package com.ws.test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonEncoding;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.ObjectMapper;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.ws.bean.Student;

public class JsonTest {
	private JsonGenerator jsonGenerator = null;
    private ObjectMapper objectMapper = null;
    private Student bean = null;
    
    @Before
    public void init() { 
  	    bean = new Student();
        bean.setName("whn");
        bean.setAge(26);
        bean.setNo(1);
        objectMapper = new ObjectMapper();
        try {
            jsonGenerator = objectMapper.getJsonFactory().createJsonGenerator(System.out, JsonEncoding.UTF8);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
  /*  @Test
    public void writeEntityJSON() {        
        try {
            System.out.println("jsonGenerator");
            //writeObject可以转换java对象，eg:JavaBean/Map/List/Array等
            jsonGenerator.writeObject(bean);    
            System.out.println();
            
            System.out.println("ObjectMapper");
            //writeValue具有和writeObject相同的功能
            objectMapper.writeValue(System.out, bean);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    *//**
     * <b>function:</b>将map转换成json字符串
     *//*
    @Test
    public void writeMapJSON() {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("name", bean.getName());
            map.put("account", bean);
      	    bean = new Student();
            bean.setName("whn2");
            bean.setAge(27);
            bean.setNo(2);
            map.put("account2", bean);
            
            System.out.println("jsonGenerator");
            jsonGenerator.writeObject(map);
            System.out.println("");
            
            System.out.println("objectMapper");
            objectMapper.writeValue(System.out, map);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }*/
    
    
    @Test
    public void writeListJSON() {
        try {
        	List<Student> list = new ArrayList<Student>();
    		for (int i=0;i<100;i++){
    			Student stu = new Student();
    			stu.setNo(i);
    			stu.setName("stu"+i);
    			stu.setAge((int)(Math.random()*80));
    			stu.setGender(-1*i+"");
    			stu.setEnglish(Math.random()*120+10);
    			stu.setMath(Math.random()*120+10);
    			
    			
    			list.add(stu);
    		}
            System.out.println("jsonGenerator");
            //list转换成JSON字符串
            jsonGenerator.writeObject(list);
            System.out.println();
            System.out.println("ObjectMapper");
            //用objectMapper直接返回list转换成的JSON字符串
            System.out.println("1###" + objectMapper.writeValueAsString(list));
            System.out.print("2###");
            //objectMapper list转换成JSON字符串
            objectMapper.writeValue(System.out, list);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @After
    public void destory() {
        try {
            if (jsonGenerator != null) {
                jsonGenerator.flush();
            }
            if (!jsonGenerator.isClosed()) {
                jsonGenerator.close();
            }
            jsonGenerator = null;
            objectMapper = null;
            bean = null;
            System.gc();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
