<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Cart.CartDataBean"%>
<%@ page import="Cart.CartDBBean"%>
<% 
	int cartNum = Integer.parseInt(request.getParameter("cartNum"));
	int price = Integer.parseInt(request.getParameter("price"));
	int count = Integer.parseInt(request.getParameter("count"));

	
	
	CartDBBean cartProcess = CartDBBean.getInstance();
    cartProcess.updateMoney(cartNum, price, count);
    
    response.sendRedirect("cartList.jsp");

	
	
%>
