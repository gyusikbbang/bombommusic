<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Cart.CartDataBean" %>
<%@ page import="Cart.CartDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<%
  String proCode = request.getParameter("proCode");
  String proCate = request.getParameter("proCate");
  String proName = request.getParameter("proName");
  String proLabel = request.getParameter("proLabel");
  String price = request.getParameter("price");
  String proImg = request.getParameter("proImg");
  String proInfo = request.getParameter("proInfo");
  String proStock = request.getParameter("proStock");
  String regdate = request.getParameter("regdate");
  String proManu = request.getParameter("proManu");
  String proSupp = request.getParameter("proSupp");
  
  String buyCount = request.getParameter("buyCount");
  String id = (String)session.getAttribute("memberId");
%>

<jsp:useBean id="cart" scope="page" class="Cart.CartDataBean">
</jsp:useBean>

<%
	int total = Integer.parseInt(price) * Integer.parseInt(buyCount);
	cart.setProCode(Integer.parseInt(proCode));
	cart.setMemberId(id);
	cart.setProName(proName);
	cart.setBuyCount(Integer.parseInt(buyCount));
	cart.setPrice(Integer.parseInt(price));
	cart.setProImg(proImg);
	cart.setTotalPrice(total);
	
	
	
	CartDBBean cartProcess = CartDBBean.getInstance();
	cartProcess.insertCart(cart);
	
	response.sendRedirect("../mypage/mypage_.jsp");
%>