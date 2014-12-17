package com.ws.bean;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;

/**
 * 测试 gt-grid组件 实体类  student
 * @author whn
 * @date   2014-03-13
 */
public class Student {
	private int no;        //学生学号
	private String name;   //学生姓名
	private int age;       //学生年龄
	private String gender; //性别
	private double english; //英语成绩
	private double math;    //数学成绩
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public double getEnglish() {
		return english;
	}
	public void setEnglish(double english) {
		this.english = english;
	}
	public double getMath() {
		return math;
	}
	public void setMath(double math) {
		this.math = math;
	}

	public Student(int no, String name, int age, String gender, double english,
			double math) {
		super();
		this.no = no;
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.english = english;
		this.math = math;
	}
	public Student() {
		super();
	}
	
	public static void main(String[] args) {
		List<Student> list = new ArrayList<Student>();
		for (int i=0;i<100;i++){
			Student stu = new Student();
			stu.setAge((int)(Math.random()*80));
			stu.setEnglish(Math.random()*120+10);
			stu.setMath(Math.random()*120+10);
			stu.setNo(i);
			stu.setGender(-1*i+"");
			stu.setName("stu"+i);
			list.add(stu);
		}
		String s  =  JSON.toJSONString(list.get(0));
		System.out.println(s);
	}

}
