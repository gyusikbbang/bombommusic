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
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link href="../main/css/mic.css" rel="stylesheet">
    <link href="../main/css/style.css" rel="stylesheet">
    <link href="css/sidebar.css" rel="stylesheet">
<title>마이 페이지</title>
</head>
<body>
<jsp:include page="../main/top.jsp"/> 
	<ul class="menu">
	  <li><a class="order" href="mypage2.jsp">주문내역</a></li>
	  <li><a href="mypage3.jsp">개인정보</a></li>
	  <li><a href="../cart/cartList.jsp">장바구니</a></li>
	  <li><a href="myReview.jsp">내 리뷰</a></li>
	</ul>
	<form class="checkpw" action="checkProcess.jsp" style="margin-top:200px;margin-left: 720px;">  
		<p> 비밀번호 :
		<input type="password" name="memberPw" placeholder="비밀번호" maxlength="20">
		<input type="hidden" name="memberId" maxlength="20" value="<%=memberId%>">
		<input type="submit" name="submit" value="확인">
    </form>
    <script src="script.js"></script>
</body>
</div>
</html>
