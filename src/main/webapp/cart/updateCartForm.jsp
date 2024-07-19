<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Cart.CartDataBean"%>
<%@ page import="Cart.CartDBBean"%>
<% 

	int cartNum = Integer.parseInt(request.getParameter("cartNum"));
	int count = Integer.parseInt(request.getParameter("count"));
	int price = Integer.parseInt(request.getParameter("price"));
	CartDBBean cartProcess = CartDBBean.getInstance();
	
	cartProcess.updateCount(cartNum,count);
    cartProcess.updateMoney(cartNum, price, count);
    
	if(count <= 0) { %>
		<script>
			alert("1개이상만 구매 가능합니다");
			response.sendRedirect("cartList.jsp");
		</script>
		<%
		count = 1;
		cartProcess.updateCount(cartNum,count);
	    cartProcess.updateMoney(cartNum, price, count);	    
	}
	response.sendRedirect("cartList.jsp");

	
	
	
%>
