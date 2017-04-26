<%@ page language="java" contentType="text/html; charset=UTF-8" %>
 
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="java.io.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
 
<%
    request.setCharacterEncoding("UTF-8");
    int maxSize = 10*1024*1024;
    String savePath = "./fileBox";
    String format = "UTF-8";
    String uploadFile="";
    int read = 0;
    byte[] buf = new byte[1024];
    try{
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, format, new DefaultFileRenamePolicy());
        String title = multi.getParameter("title");
        uploadFile = multi.getFilesystemName("uploadFile");
        File file = new File(savePath + uploadFile);
    }catch(Exception e){
        e.printStackTrace();
    }
    
%>
<script>
    alert("제출 완료");
</script>