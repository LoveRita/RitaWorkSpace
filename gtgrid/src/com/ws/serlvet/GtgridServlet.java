package com.ws.serlvet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ws.bean.Student;


/**
 * 测试 gt-grid组件的复杂使用
 * @author whn
 * @date   2014-03-13
 */
public class GtgridServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("开始执行gt-grid");
		/*ObjectMapper objectMapper = new ObjectMapper();
		JsonGenerator jsonGenerator  = objectMapper.getJsonFactory().createJsonGenerator(resp.getOutputStream(), JsonEncoding.UTF8);
		jsonGenerator.writeObject(this.getStus());*/
		List<Student> stus = this.getStus();
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(int i=0;i<stus.size();i++){
			if(i==stus.size()-1){
				sb.append( "{ no :"+ stus.get(i).getNo()+", name :'"+stus.get(i).getName()+"', age :"+stus.get(i).getAge()+", gender : '"+stus.get(i).getGender()+"' , english : "+stus.get(i).getEnglish()+" , math :"+stus.get(i).getMath()+" }");
			}else{
				sb.append( "{ no :"+ stus.get(i).getNo()+", name :'"+stus.get(i).getName()+"', age :"+stus.get(i).getAge()+", gender : '"+stus.get(i).getGender()+"' , english : "+stus.get(i).getEnglish()+" , math :"+stus.get(i).getMath()+" },");
			}
			
		}
		sb.append("]");
		PrintWriter out = resp.getWriter();
		String result = sb.toString();
		System.out.println(result);
		out.print(result.trim());
		out.flush();
		out.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
	
	//获取100个学生
	public  List<Student> getStus(){
		DecimalFormat df=new DecimalFormat("#.00");
		List<Student> list = new ArrayList<Student>();
		for (int i=0;i<10;i++){
			Student stu = new Student();
			stu.setAge((int)(Math.random()*80));
			stu.setGender(-1*i+"");
			stu.setEnglish(Double.parseDouble(df.format(Math.random()*120+10)));
			stu.setMath(Double.parseDouble(df.format(Math.random()*120+10)));
			stu.setNo(i);
			
			stu.setName("stu"+i);
			list.add(stu);
		}
		
		return list;
	}

	
	 

}
