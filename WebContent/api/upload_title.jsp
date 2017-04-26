<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ page import="java.util.*"%><%@ page
	import="beans.*"%><%@ page import="com.google.gson.*"%><jsp:useBean
	id="lb" scope="page" class="beans.LetsgoBean" />

<%
//post test
        request.setCharacterEncoding("UTF-8");       //한글이 깨지지 않도록 UTF-8으로 받음. getParameter위에 써야함!!
       
        String title = request.getParameter("title");
        String image_url = request.getParameter("image_url");
        //String description = request.getParameter("description");
        String block_data = request.getParameter("block_data");
        boolean result = lb.insertPlock(title,image_url,block_data);
        
        //ArrayList<beans.Plock> datas = lb.getPlockList("");
        String json = new Gson().toJson(result);
		out.println(json);
%>