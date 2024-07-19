<%@ page import="Buy.BuyDataBean"%>
<%@ page import="Buy.BuyDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
request.setCharacterEncoding("UTF-8");
%>


<%!int pageSize = 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>


<%
String pageNum = request.getParameter("pageNum");

if (pageNum == null) {
	pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
int count = 0;
int number = 0;

List<BuyDataBean> buyList = null;

BuyDBBean buyProcess = BuyDBBean.getInstance();
count = buyProcess.getBuyCount();

if (count > 0) {
	buyList = buyProcess.getBuyList(startRow, endRow);

}
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../css/page.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/table.css">
<link rel="stylesheet" href="../css/page.css">
<style>
td img {
	width: 90px;
	height: 90px;
}
</style>
</head>
<body>
	<div class="container-fluid">


		<div>
			<div class="container-fluid">
				<a href="../managerMain.jsp">관리자 메인으로</a>
				<p></p>

			</div>
		</div>



		<%
		if (count == 0) {
		%>
		<div class="alert alert-danger" role="alert">주문된 내역이 없습니다.</div>

		<%
		} else {
			
			
			
			
			
		%>
		
		<form name="search"
			action="/BomBom/manager/orderedProduct/orderedSearch.jsp"
			method="post">
			 <input type='search' name="memberId" required /> <input
				type='submit' value='검색' />
		</form>
		
		
		<br>
			
				
<p> <%=count%>개 주문목록</p>
					
		<table class="table table-striped">
			<thead>
				<tr class="table-secondary">
                    <th scope="col">주문자아이디</th>
                    <th scope="col">주문자이름</th>
                    <th scope="col">상품이름</th>
                    <th scope="col">주문가격</th>
                    <th scope="col">주문수량</th>
                    <th scope="col">주문일</th>
                    <th scope="col">결제계좌</th>
                    <th scope="col">배송명</th>
                    <th scope="col">배송지전화</th>
                    <th scope="col">배송지주소</t>
                    <th scope="col">배송지상황</th>
                </tr>
			</thead>
			<tbody>
				<%
				for (int i = 0; i < buyList.size(); i++) {
					BuyDataBean buy = (BuyDataBean) buyList.get(i);
				
				%>





				<tr>

					        <tr>
            <td><%=buy.getMemberId() %></td>
            <td><%=buy.getMemberName() %></td>
            <td><%=buy.getPrice() %></td>
            <td><%=buy.getProCode() %></td>
            	<td><img src="/BomBom/imageFile/<%=buy.getProImg()%>"></td>      
            	
           </tr>
				<%
				}
				%>
			</tbody>
		</table>
		<div class="pagination">

			<ul class="page">
				<%
				if (count > 0) {
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					int startPage = 1;
					int pageBlock = 5;

					if (currentPage % pageBlock != 0)
						startPage = (int) (currentPage / pageBlock) * pageBlock + 1;
					else
						startPage = ((int) (currentPage / pageBlock) - 1) * pageBlock + 1;

					int endPage = startPage + pageBlock - 1;
					if (endPage > pageCount)
						endPage = pageCount;
				%>











				<%
				if (startPage < pageBlock) {
				%>
				<a class="page-link-disable"
					href="orderedList.jsp?pageNum=<%=startPage - pageBlock%>"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a>

				<%
				} else {
				%>
				<a class="page-link"
					href="orderedList.jsp?pageNum=<%=startPage - pageBlock%>"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a>




				<%
				}
				%>

				<%
				for (int i = startPage; i <= endPage; i++) {
				%>

				<li class="page-item"><a class="page-link"
					href="orderedList.jsp?pageNum=<%=i%>"><%=i%></a></li>


				<%
				}
				%>




				<%
				if (endPage >= pageCount) {
				%>
				<a class="page-link-disable"
					href="orderedList.jsp?pageNum=<%=startPage + pageBlock%>"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a>

				<%
				} else {
				%>
				<a class="page-link"
					href="orderedList.jsp?pageNum=<%=startPage + pageBlock%>"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a>




				<%
				}
				%>



				<%
				}
				%>
			</ul>

			<%
			}
			%>

		</div>
	</div>


</body>
</html>
