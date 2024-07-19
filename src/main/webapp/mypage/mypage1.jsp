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
    CartDBBean cartDBBean = CartDBBean.getInstance();
    BuyDBBean buyDBBean = BuyDBBean.getInstance();
    LoginDBBean loginDBBean = LoginDBBean.getInstance();
    String memberId = (String) session.getAttribute("memberId");

    List<CartDataBean> carts = cartDBBean.getCart(memberId);
    List<BuyDataBean> orders = buyDBBean.getBuyList(memberId);

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
<div class="myPageForm">
	<ul class="mymenu">
	  <li><a  href="mypage2.jsp">주문내역</a></li>
	  <li><a class="order" href="mypage1.jsp">개인정보</a></li>
	  <li><a href="mypage_.jsp">장바구니</a></li>
	  <li><a href="myReview.jsp">내 리뷰</a></li>
	</ul>
    <div>
    <form method="post" action="checkPw.jsp" style="margin-top: 60px;
    		width:585px; height:300px; margin-left:-30px; border: 1px soild black">
	    <div class="form-group" style="padding:10px;">
	      <p> 아이디 : <%=memberId%></p>
	    </div>
	    <div class="form-group" style="padding:10px;">
	      <p> BomBom포인트 : <%=loginDBBean.userPoint(memberId)%></p>
	    </div>
	    <div class="form-group" style="padding:10px;">
	      <p> 이름 : <%=loginDBBean.userName(memberId)%>
	     
	    </div>
	    <div class="form-group" style="padding:10px;">
	      <p> 전화번호 : <%=loginDBBean.userPhone(memberId)%>
	      
	    </div>
	    <div class="form-group" style="padding:10px;">
    	  <p> 이메일 : <%=loginDBBean.userEmail(memberId)%>
	    </div>
	    <div class="form-group" style="padding:10px;">
	      <p> 주소 : <%=loginDBBean.userAddr(memberId)%>
	    </div>
	    <input type="submit" class="btn btn-primary form-control" 
	    style="margin-left:205px;width:200px;height:40px;" value="수정하기">  
    </form>
    </div> 
</div> 
    
    <script src="script.js"></script>
</body>
<div class="row" id="footer" style="margin-top:320px">
    <div class="col">
        <jsp:include page="../main/bottom.jsp" flush="false" />
    </div>
</div>
</html>
