<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Cart.CartDataBean" %>
<%@ page import="Cart.CartDBBean" %>
<%@ page import="Buy.BuyDataBean" %>
<%@ page import="Buy.BuyDBBean" %>
<%@ page import="LoginDB.LoginDataBean" %>
<%@ page import="LoginDB.LoginDBBean" %>
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
String buyer = (String)session.getAttribute("memberId");
List<CartDataBean> cartLists = null;
CartDataBean cartList = null;
int count = 0;
int number = 0;
int total = 0;

if(session.getAttribute("memberId") == null){
    response.sendRedirect("../main/mid.jsp");        
}else{
	
	String chkBuy = request.getParameter("chkBuy");
	if (chkBuy != null && chkBuy.equals("1")) {
	    BuyDBBean buyProcess = BuyDBBean.getInstance();
	    int result = buyProcess.purchase(buyer);
		
	   out.println(">>>>>>>>>> result : " + result);
	    if (result > 0) {
	    	%>
	    	<script>
	    	alert("결제가 완료되었습니다. 마이페이지로 이동합니다.");
	    	document.location.href = "../mypage/mypage2.jsp";
	    	</script>
	    	<%
	    	
	    	// my page redirect
	    } else {
	    	%>
	    	<script>
	    	alert("결제가 실패되었습니다.");
	    	</script>
	    	<%
	    }
	} 

    LoginDBBean loginProcess = LoginDBBean.getInstance();
    LoginDataBean member = loginProcess.getMypage(buyer);
	
    CartDBBean bookProcess = CartDBBean.getInstance();
    count = bookProcess.getListCount(buyer);

    if(count == 0){
    	
%>
<%
    }else{
        cartLists = bookProcess.getCart(buyer);
%>
<body>
<div class="mid_section">
    <div class="contents_section">
        <section class="buy">
            <table>
                <thead>
                    <tr>
                         <td colspan="5"><font size="+1" ><b>구매 목록</b></font></td>
                    </tr>               
                    <tr>
                        <td colspan="2">상품정보</td>
                        <td>가격</td>
                        <td>수량</td>	
                        <td>총 금액</td>
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
                            <%=cartList.getBuyCount()%>
                        </td>
                        <td>
                            <span class="price"><%=cartList.getTotalPrice()%></span>
                        </td>
                    </tr>
                    <% 
                    total += cartList.getTotalPrice();
            		} 
                    %>
                    <tr>
				    	<td colspan="5" align="right"><b>총 구매금액 : <%=NumberFormat.getInstance().format(total)%></b></td>
					</tr>
                </tbody>
        		
            </table>
  
            <table>
			   <tr> 
			    <td  colspan="2"><font size="+1" ><b>주문자 정보</b></font></td>
			   </tr>
			   <tr> 
			    <td  width="200" align="left">성명</td>
			    <td  width="400" align="left"><%=member.getMemberName() %></td>
			   </tr>
			   <tr> 
			    <td  width="200" align="left">전화번호</td>
			    <td  width="400" align="left"><%=member.getMemberPhone()%></td>
			   </tr>
			   <tr> 
			    <td  width="200" align="left">이메일</td>
			    <td  width="400" align="left"><%=member.getMemberEmail() %></td>
			   </tr>
            </table>     
         
            <table>
			   <tr> 
			    <td  colspan="2"><font size="+1" ><b>배송지 정보</b></font></td>
			   </tr>
			   <tr> 
			    <td  width="200" align="left">주소</td>
			    <td  width="400" align="left"><%=member.getMemberAddr() %></td>
			   </tr>
            </table>        
            
            
            <div class="buy__mainbtns">
                <button class="buy__bigorderbtn right" onclick="fnBuy();">결제하기</button>
            </div>
        </section>
    </div>
    <div class="side_section">
       <%--  <jsp:include page="../main/side.jsp"/> --%>
    </div>
</div>
</body>
<%} }%>
<div class="row" id="footer">
    <div class="col">
        <jsp:include page="../main/bottom.jsp" flush="false" />
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
function fnBuy() {
	if (confirm("결제하시겠습니까?")) {
		document.location.href = "buyForm.jsp?chkBuy=1";
	}
}
</script>
</body>
<link rel="stylesheet" href="js/mic.js">
</html>