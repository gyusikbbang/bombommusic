<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Buy.BuyDataBean" %>
<%@ page import="Buy.BuyDBBean" %>
<%@ page import="LoginDB.LoginDataBean" %>
<%@ page import="LoginDB.LoginDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat"%>

<%
request.setCharacterEncoding("UTF-8");
%>

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

<jsp:useBean id="buy" scope="page" class="Buy.BuyDataBean">
</jsp:useBean>
<%
String buyer = (String)session.getAttribute("memberId");
int count = 0;
int number = 0;
int total = 0;

String proCode = "";
String proName = "";
String price = "";
String proImg = "";
String buyCount = "";

if(session.getAttribute("memberId") == null){
    response.sendRedirect("../main/mid.jsp");        
}else{
	
	String chkBuy = request.getParameter("chkBuy");
	if (chkBuy != null && chkBuy.equals("1")) {
		
		proCode = request.getParameter("proCode");
		System.out.println(">>> proCode : " + proCode);
		proName = request.getParameter("proName");
		price = request.getParameter("price");
		proImg = request.getParameter("proImg");
		buyCount = request.getParameter("buyCount");
		
		buy.setProCode(Integer.parseInt(proCode));
		buy.setMemberId(buyer);
		buy.setProName(proName);
		buy.setBuyCount(Integer.parseInt(buyCount));
		buy.setPrice(Integer.parseInt(price)); 
		buy.setProImg(proImg);
		
	    BuyDBBean buyProcess = BuyDBBean.getInstance();
	    int result = buyProcess.purchase(buy); 
		
	    if (result > 0) {
	    	%>
	    	<script>
	    	alert("결제가 완료되었습니다. 마이페이지로 이동합니다.");
	    	document.location.href = "../mypage/mypage2.jsp";
	    	</script>
	    	<%
	    	//response.sendRedirect("../mypage/mypage2.jsp");
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
	
    proCode = request.getParameter("proCode");
    proName = request.getParameter("proName");
    price = request.getParameter("price");
    proImg = request.getParameter("proImg");
    buyCount = request.getParameter("buyCount");
    int totalPrice = (Integer.parseInt(buyCount) * Integer.parseInt(price));
%>
<body>
<div class="mid_section">
    <div class="contents_section">
        <section class="buy">
        <form class="form-toCart" method="post" action="directBuyForm.jsp">
		    <input type="hidden" name="proCode" id="proCode" value="<%=proCode%>">
          	<input type="hidden" name="proName" id="proName" value="<%=proName %>">
		    <input type="hidden" name="price" id="proPrice" value="<%=price%>">
		    <input type="hidden" name="proImg" id="proImg" value="<%=proImg %>">   
		    <input type="hidden" name="buyCount" id="buyCount" value="<%=buyCount %>"> 
		 </form>      
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
                    <tr>
                        <td><img class="proImg" src="/BomBom/imageFile/<%=proImg %>"></td>
                        <td>
                            <p><%=proName %></p>
                        </td>
                        <td>
                            <span class="price"><%=price%></span>                           
                        </td>
                        <td>
                            <%=buyCount%>
                        </td>
                        <td>
                            <span class="price"><%=NumberFormat.getInstance().format(totalPrice)%></span>
                        </td>
                    </tr>
                    <tr>
				    	<td colspan="5" align="right"><b>총 구매금액 : <%=NumberFormat.getInstance().format(totalPrice)%></b></td>
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
<% }%>
<div class="row" id="footer">
    <div class="col">
        <jsp:include page="../main/bottom.jsp" flush="false" />
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
function fnBuy() {
	if (confirm("결제하시겠습니까?")) {
		//document.location.href = "directBuyForm.jsp?chkBuy=1";
		 // form 태그 생성 & 속성부여
	    var newForm = document.createElement("form");
	    newForm.setAttribute("method", "POST");
	    newForm.setAttribute("action", "./directBuyForm.jsp")
	    
	    // input 태그 생성 & 속성부여
	    var inputProCode = document.createElement("input");
	    inputProCode.setAttribute("type", "text");
	    inputProCode.setAttribute("name", "proCode");
	    inputProCode.setAttribute("value", "<%=proCode %>");
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputProCode);
	    
	    var inputProName = document.createElement("input");
	    inputProName.setAttribute("type", "text");
	    inputProName.setAttribute("name", "proName");
	    inputProName.setAttribute("value","<%=proName %>");
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputProName);
	    
	    var inputPrice = document.createElement("input");
	    inputPrice.setAttribute("type", "text");
	    inputPrice.setAttribute("name", "price");
	    inputPrice.setAttribute("value", "<%=price %>");
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputPrice);
	    
	    var inputProImg = document.createElement("input");
	    inputProImg.setAttribute("type", "text");
	    inputProImg.setAttribute("name", "proImg");
	    inputProImg.setAttribute("value", "<%=proImg %>");
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputProImg);
		
	    var inputProBuyCount = document.createElement("input");
	    inputProBuyCount.setAttribute("type", "text");
	    inputProBuyCount.setAttribute("name", "buyCount");
	    inputProBuyCount.setAttribute("value", "<%=buyCount %>");
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputProBuyCount);
	    
	    var inputChkBuy = document.createElement("input");
	    inputChkBuy.setAttribute("type", "text");
	    inputChkBuy.setAttribute("name", "chkBuy");
	    inputChkBuy.setAttribute("value", "1");
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputChkBuy);	    
	    
	    // form을 body태그의 자식태그로 붙이기
	    document.body.appendChild(newForm);
	    newForm.submit();		
	}
}
</script>
</body>
<link rel="stylesheet" href="js/mic.js">
</html>