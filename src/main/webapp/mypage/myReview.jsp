<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Manager.reviewDataBean" %>
<%@ page import="Manager.reviewDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat"%>

<%
	String proCode = request.getParameter("proCode");
    String id = (String)session.getAttribute("memberId");
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
<link href="css/sidebar.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

</head>
<body>
<jsp:include page="../main/top.jsp"/> 
<%
	int pageSize = 5;

	String pageNum = request.getParameter("pageNum");
	
	if (pageNum == null) {
	pageNum = "1";
	}
	
	int currentPage =  Integer.parseInt(pageNum);
	
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	int rvCount = 0;
	
	List<reviewDataBean> reviewList = null;
    reviewDBBean reviewProcess = reviewDBBean.getInstance();
    count = reviewProcess.myRvsearchCount(id);
    if (id != null && !id.equals("")) {
    	rvCount = reviewProcess.myRvRegistCount(id);
    }
%>
<%     
    if (count > 0) {
    	reviewList = reviewProcess.myReviews(id,startRow,endRow);
    }
%>
<body>
<div class="myPageForm">
	<ul class="mymenu">
	  <li><a  href="mypage2.jsp">주문내역</a></li>
	  <li><a href="mypage1.jsp">개인정보</a></li>
	  <li><a href="mypage_.jsp">장바구니</a></li>
	  <li><a class="order" href="myReview.jsp">내 리뷰</a></li>
	</ul>
	
<div class="mid_section">
    <div class="contents_section">
        <section class="cart">
            <table>
                <thead>
                    <tr>
                        <td>상품명</td>
                        <td>리뷰 내용</td>
                        <td>등록일자</td>
                    </tr>
                </thead>
                <tbody>
                <%
        				if (count == 0) {
    					%>
    					<h5>등록된 리뷰가 없습니다.</h5>
    					<% }else{%>
                <%
                for (int i = 0; i<reviewList.size(); i++) {
                    reviewDataBean review = (reviewDataBean)reviewList.get(i);
        		%>
                    <tr>
                        <td>
                            <p><a href="../proInfo/proInfo.jsp?proCode=<%=review.getProCode()%>"><%=review.getProName()%></a></p>
                        </td>
                        <td>
                            <%=review.getRvContent()%>                    
                        </td>
                        <td>
                            <%=review.getRvRegdate()%>  
                        </td>

                    </tr>
                    <% } %>
                    <%}%>
                </tbody>
        
            </table>

        </section>
    </div>
    <div class="side_section">
        <jsp:include page="../main/side.jsp"/>
    </div>
</div>
</div>
<script src="script.js"></script>
</body>
<div class="row" id="footer" style="margin-top:250px"> 
    <div class="col">
        <jsp:include page="../main/bottom.jsp" flush="false" />
    </div>
</div>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
<link rel="stylesheet" href="js/mic.js">
</html>