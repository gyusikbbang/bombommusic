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
	String proCode = request.getParameter("proCode");
    String buyer = (String)session.getAttribute("memberId");
%>
<%
List<CartDataBean> cartLists = null;
CartDataBean cartList = null;
int count = 0;
int number = 0;
int total = 0;

if(session.getAttribute("memberId") == null){
    response.sendRedirect("../main/mid.jsp");        
}else{
    CartDBBean bookProcess = CartDBBean.getInstance();
    count = bookProcess.getListCount(buyer);
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
	  <li><a href="mypage1.jsp">개인정보</a></li>
	  <li><a class="order" href="mypage_.jsp">장바구니</a></li>
	  <li><a href="myReview.jsp">내 리뷰</a></li>
	</ul>

    <div class="mid_section">
    <div class="contents_section">
        <section class="cart">
            <div class="cart__information">
                <ul>
                    <li>장바구니 상품은 최대 30일간 저장됩니다.</li>
                    <li>가격, 옵션 등 정보가 변경된 경우 주문이 불가할 수 있습니다.</li>
                    <li>오늘출발 상품은 판매자 설정 시점에 따라 오늘출발 여부가 변경될 수 있으니 주문 시 꼭 다시 확인해 주시기 바랍니다.</li>
                </ul>
            </div>
            <%
    if(count != 0){
    	cartLists = bookProcess.getCart(buyer);
%>
            <table>
                <thead>
                    <tr>
                        <td colspan="2">상품정보</td>
                        <td>가격</td>
                        <td>수량</td>
                        <td>총 금액</td>
                        <td>장바구니 삭제</td>
                    </tr>
                </thead>
                <tbody>
                <%
            for(int i=0; i<cartLists.size(); i++){
            cartList = (CartDataBean)cartLists.get(i);
        	%>
                    <tr>
                    	                 	                  
                        <td><img class="proImg" src="/BomBom/imageFile/<%=cartList.getProImg()%>"></td>
                        <td>
                            <p><%=cartList.getProName()%></p>
                        </td>
                        <td>
                            <span class="price"><%=cartList.getPrice()%>원</span>                           
                        </td>
                        <td>
                            <form action="updateCartForm.jsp">     
                            	<input type="hidden" id="cartNum" name="cartNum" value="<%=cartList.getCartNum()%>">                  
						        <input type="number" id="count" name="count" value="<%=cartList.getBuyCount()%>"/>
						        <input type="hidden" id="price" name="price" value="<%=cartList.getPrice()%>"/>
						        <input type="submit" name="submit" value="수정">
						    </form>
                        </td>
                        <td>             	
	                        <span class="price"><%=cartList.getTotalPrice()%>원</span>
                        </td>
                        <td>
                        	 <form action="deleteCart.jsp" method="POST">
					          <input type="hidden" id="cartDelete" name="cartDelete" value="<%=cartList.getCartNum()%>" />
					          <button type="submit">삭제</button>
					        </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
        
            </table>
            <div class="cart__mainbtns">
                <button class="cart__bigorderbtn left">쇼핑 계속하기</button>
                <button class="cart__bigorderbtn right" onclick="fnOrder();">주문하기</button>
            </div>
            <%
    		}else{
    	%>
    	<h2>장바구니에 담긴 상품이 없습니다.</h2>
    	<%} }%>
        </section>
        
    </div>
    <div class="side_section">
        <jsp:include page="../main/side.jsp"/>
    </div>
</div>
</div>
    <script src="script.js"></script>
</body>
<div class="row" id="footer" style="margin-top:320px">
    <div class="col">
        <jsp:include page="../main/bottom.jsp" flush="false" />
    </div>
</div>
<script>
function fnOrder() {
	document.location.href = "../buy/buyForm.jsp";
}
</script>
</html>
