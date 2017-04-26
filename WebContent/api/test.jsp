<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ page import="java.util.*"%><%@ page
	import="beans.*"%><%@ page import="com.google.gson.*"%><jsp:useBean
	id="lb" scope="page" class="beans.LetsgoBean" />
<%ArrayList<beans.Plock> datas = lb.getPlockList("");
out.println(datas.size());

//List<Map<String, String>> list = new ArrayList();
Map<String, String> map = new HashMap();
map.put("test1", "test2");
//list.add(map);

String json = new Gson().toJson(datas);

out.println(json);
%>