<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="Cart.CartDataBean" %>
<%@ page import="Buy.BuyDataBean" %>
<%@ page import="Buy.BuyDBBean" %>



<%
	String memberId = request.getParameter("memberId");
	String memberName = null;
	
	// BuyDBBean 객체 생성 및 memberName 가져오기
	BuyDBBean buyDB = BuyDBBean.getInstance();
	memberName = buyDB.getMemberName(memberId);
	
	BuyDataBean buyData = new BuyDataBean();
	buyData.setMemberId(memberId);
	buyData.setMemberName(memberName);
	buyData.setProCode(Integer.parseInt(request.getParameter("proCode")));
	buyData.setProName(request.getParameter("proName"));
	buyData.setPrice(Integer.parseInt((request.getParameter("price"))));
	buyData.setBuyCount(Integer.parseInt(request.getParameter("buyCount")));
	buyData.setProImg(request.getParameter("proImg"));
	
	// 현재 날짜를 java.sql.Date로 바로 얻기
	long currentTimeMillis = System.currentTimeMillis();
	java.sql.Date sqlDate = new java.sql.Date(currentTimeMillis);
	buyData.setBuy_date(sqlDate);
	
	// buyData 객체를 사용하여 주문 처리 및 다음 페이지 이동 또는 오 메시지 표시
	int result = buyDB.purchase(buyData);
	if (result > 0) {
	    response.sendRedirect("../main/main.jsp");
	} else {
	    out.print("주문 실패");
	}
%>