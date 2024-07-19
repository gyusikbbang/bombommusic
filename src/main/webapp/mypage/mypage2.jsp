<!-- mypage.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Cart.CartDataBean"%>
<%@ page import="Cart.CartDBBean"%>
<%@ page import="Buy.BuyDataBean" %>
<%@ page import="Buy.BuyDBBean" %>
<%@ page import="LoginDB.LoginDBBean" %>
<%@ page import="LoginDB.LoginDataBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	int count = 0;

    LoginDBBean loginDBBean = LoginDBBean.getInstance();
    String memberId = (String) session.getAttribute("memberId");

    BuyDBBean buyDBBean = BuyDBBean.getInstance();
    List<BuyDataBean> orders = null;
	count = buyDBBean.getBuyCount(memberId);
	
	 if(count == 0){
%>
<%
    }else{
    	orders = buyDBBean.getBuyList(memberId);
%>
<%
    CartDBBean cartDBBean = CartDBBean.getInstance();
    List<CartDataBean> carts = cartDBBean.getCart(memberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
<link href="../main/css/style.css" rel="stylesheet">
<link href="../main/css/bottom.css" rel="stylesheet">
<link href="../main/css/side.css" rel="stylesheet">
<link href="style.css" rel="stylesheet">
<link href="../main/css/mic.css" rel="stylesheet">
<link href="css/sidebar.css" rel="stylesheet">
<title>마이 페이지</title>
</head>
<body>
<jsp:include page="../main/top.jsp"/> 
	<ul class="mymenu">
	  <li><a class="order" href="mypage2.jsp">주문내역</a></li>
	  <li><a href="mypage1.jsp">개인정보</a></li>
	  <li><a href="mypage_.jsp">장바구니</a></li>
	  <li><a href="myReview.jsp">내 리뷰</a></li>
	</ul>
    <table class = "profile" border="1">
    	<thead>
        <tr>
            <th>상품명</th>
            <th>가격</th>
            <th>수량</th>
            <th>주문 날짜</th>
        </tr>
        </thead>
        <% if (orders != null) {
            for (BuyDataBean order : orders) { %>
        <tr>
            <td><%= order.getProName() %></td>
            <td><%= order.getPrice() %></td>
            <td><%= order.getBuyCount() %></td>
            <td><%= order.getBuy_date() %></td>
            
        </tr>
        <% } } else { %>
        <tr>
          <td colspan="4">주문 내역이 없습니다.</td>
        </tr>
        <% } } %>
    </table>    
    <script src="script.js"></script>
</body>
<div class="row" id="footer" style="margin-top:320px">
    <div class="col">
        <jsp:include page="../main/bottom.jsp" flush="false" />
    </div>
</div>
</html>
