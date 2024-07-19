<%@page import="java.awt.print.Book"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Cart.CartDataBean" %>
<%@ page import="Cart.CartDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Book Shopping Mall</title>
<link href="../main/css/style.css" rel="stylesheet">
<link href="../main/css/bottom.css" rel="stylesheet">
<link href="../main/css/side.css" rel="stylesheet">
<link href="style.css" rel="stylesheet">
<link href="../main/css/mic.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

</head>
<body>
<jsp:include page="../main/top.jsp"/> 
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
<body>
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
                            <span class="price"><%=cartList.getPrice()%></span>                           
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
	                        <span class="price"><%=cartList.getTotalPrice()%></span>
                        </td>
                        <td>
                        	 <form action="deleteCart.jsp" method="POST">
					          <input type="hidden" id="cartDelete" name="cartDelete" value="<%=cartList.getCartNum()%>" />
					          <button type="submit">장바구니 삭제</button>
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
    	<script>
    	alert("상품 없음");
    	</script>
    	<%}%>
        </section>
        
    </div>
    <div class="side_section">
        <jsp:include page="../main/side.jsp"/>
    </div>
</div>

</body>
<% }%>
<div class="row" id="footer">
    <div class="col">
        <jsp:include page="../main/bottom.jsp" flush="false" />
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
function fnOrder() {
	document.location.href = "../buy/buyForm.jsp";
}
</script>


</body>
<link rel="stylesheet" href="js/mic.js">
</html>