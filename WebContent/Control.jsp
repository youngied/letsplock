<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="beans.*"%>

<% request.setCharacterEncoding("utf-8"); %>
  
<jsp:useBean id="lb" scope="page" class="beans.LetsgoBean"/>
<jsp:useBean id="plock" scope="page" class="beans.Plock"/>
<!-- form의 모든 속성들을 name빈즈와 매칭시킨다. -->
<!-- mybean.setUserid(request.getParameter("username")); 이런 기능 -->
<jsp:setProperty name="plock" property="*" />

<%!

java.util.Date utilDate = new java.util.Date();
java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
//System.out.println("" + sqlDate);
public String scriptAlert(int i) {
  switch (i) {
  case 0:
  return "<script>alert('메세지');" + "history.back();</script>";
  case 1:
  return "<script>alert('페이지 범위를 벗어났습니다.');" + "history.back();</script>";
  default:
    return null;
  }
}

public ArrayList<BlockData> splitPlock(Plock selectedPlock){
  ArrayList<BlockData> splitPlock = new ArrayList<BlockData>();
  String[] block = selectedPlock.getBlock_data().split("&");
  
  for(int i=0; i<block.length; i++) {
    String[] tmpsplit = block[i].split(":");
    BlockData tmpBlockData = new BlockData();
    tmpBlockData.setPosition(tmpsplit[0]);
    tmpBlockData.setRotation(tmpsplit[1]);
    tmpBlockData.setColor(tmpsplit[2]);
    tmpBlockData.setType(Integer.parseInt(tmpsplit[3]));
    
    splitPlock.add(tmpBlockData);
  }
  return splitPlock;
}

%>

<%
String action = request.getParameter("action");
String search = request.getParameter("search");
String nextPage = request.getParameter("nextPage");

if(action == null)
  action = "list";

/* Control for page */
if(action.equals("list")) {
  ArrayList<beans.Plock> datas = lb.getPlockList(search);
  request.setAttribute("datas", datas);

  //get Page Part
	int PLOCK_PER_PAGE = 12;
	int totalPage = datas.size() / PLOCK_PER_PAGE + 1;
	int currentPage = -1;
	Object sgc = session.getAttribute("currentPage");
	if(sgc != null) {
		currentPage = (Integer) sgc;
	}
	if(currentPage < 1 || sgc == null || sgc.equals("") || nextPage == null)
		currentPage = 1;
	else {
		int nextPageInt = Integer.parseInt(nextPage);
		if(nextPageInt > totalPage || nextPageInt < 1)
			scriptAlert(1);
		else 
			currentPage = nextPageInt;
	}
	
	int startNum = (currentPage - 1) * PLOCK_PER_PAGE;
	int endNum = currentPage * PLOCK_PER_PAGE - 1;
	//out.println(totalPage + ", " + currentPage + ", " + startNum + ", " + endNum);
	session.setAttribute("currentPage", currentPage);
	session.setAttribute("PLOCK_PER_PAGE", PLOCK_PER_PAGE);
	session.setAttribute("totalPage", totalPage);
	session.setAttribute("startNum", startNum);
	session.setAttribute("endNum", endNum);

	//response.sendRedirect("index.jsp?action="+action);
	pageContext.forward("index.jsp?action=" + action);
} else if (action.equals("details")) {
		beans.Plock selectedPlock = lb.getPlock(plock.getIdx());
		request.setAttribute("selectedPlock", selectedPlock);
		ArrayList<BlockData> splitedPlock = splitPlock(selectedPlock);
		request.setAttribute("splitPlock", splitedPlock);

		//response.sendRedirect("details.jsp");
		pageContext.forward("details.jsp");
	}

	// 리스트 출력

	/*
	  if (action.equals("list")) {
	    //무비 리스트 화면으로 넘어갈때에 datas로 속성 설정하여 넘기기
	    //System.out.println(session.getAttribute("login"));
	    ArrayList<beans.Plock> datas = fb.getPlockList();
	    request.setAttribute("datas", datas);
	    pageContext.forward("MovieMain.jsp");
	  }
	  else if (action.equals("seatlist")) {
	      try {
	        //age를 구해서 Plock age와 비교하여 들어가지 못하게 한다.
	        if(!(fb.compareAge((Membership)session.getAttribute("login"), Plock))) { //관람가 알림
	          out.println(scriptAlert(13));  //jsp가 먼저 실행되어 인식하지 못함.
	          //System.out.println("여기?"+((Membership)session.getAttribute("login")).getAge_mem());
	          //pageContext.forward("Control.jsp?action=list");
	        } else {
	        
	        //id_Plock이 자동으로 등록된다.
	        beans.SeatNo data = fb.getSeatList(Plock.getId_Plock());
	        //좌석 리스트 화면으로 넘어갈때에 data로 속성 설정하여 넘기기
	        request.setAttribute("sn", data);
	        request.setAttribute("Plock", Plock);
	        pageContext.forward("MovieReservation.jsp");
	        }
	      } catch (Exception e) {
	        e.printStackTrace();
	      }
	  }
	    else if (action.equals("mymovielist")) {
	        try {
	          membership.setName_mem(((Membership)session.getAttribute("login")).getName_mem());
	          
	          ArrayList<beans.PlockResv> datas = fb.getMyMovieList(membership);
	          //무비 리스트 화면으로 넘어갈때에 datas로 속성 설정하여 넘기기
	          request.setAttribute("datas", datas);
	          pageContext.forward("MyMovieList.jsp");
	        } catch (Exception e) {
	          e.printStackTrace();
	        }
	    }
	  */
%>
