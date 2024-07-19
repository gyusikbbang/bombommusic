<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Manager.reviewDataBean"%>
<%@ page import="Manager.reviewDBBean"%>
<%@ page import = "java.sql.Timestamp" %>

<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
</head>
<body>


<jsp:useBean id="review" scope="page" 
	class="Manager.reviewDataBean">
</jsp:useBean>


<%
// 이거 안해서 한글 깨진거임 ㅠ
request.setCharacterEncoding("UTF-8");

String proCode = request.getParameter("proCode");
String id = request.getParameter("id");
String RvContent = request.getParameter("RvContent");

review.setRvRegdate(new Timestamp(System.currentTimeMillis()));


reviewDBBean reviewProcess = reviewDBBean.getInstance();
String proName = reviewProcess.ReviewProName(Integer.parseInt(proCode));
int recheck =  reviewProcess.reviewModify(review, Integer.parseInt(proCode), proName, id, RvContent);


%>

<%
if (recheck == 0) {
%>
	<script>location.href = document.referrer;</script>

<%} else { %>
	<script>alert('수정실패');</script>
<%} %>
</body>
</html>
