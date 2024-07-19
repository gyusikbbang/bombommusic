<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Cart.CartDataBean" %>
<%@ page import="Cart.CartDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat"%>

<%
	String proCode = request.getParameter("proCode");
    String buyer = (String)session.getAttribute("memberId");
%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BomBom Event</title>
<link href="../main/css/style.css" rel="stylesheet">
<link href="../main/css/bottom.css" rel="stylesheet">
<link href="../main/css/side.css" rel="stylesheet">
<link href="style.css" rel="stylesheet">
<link href="../main/css/mic.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

</head>
<body>
<jsp:include page="../main/top.jsp"/> 
<div class="mid_section">
    

</div>
<div class="side_section">
    <jsp:include page="../main/side.jsp"/>
</div>






<div class="row" id="footer">
    <div class="col">
        <jsp:include page="../main/bottom.jsp" flush="false" />
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
<link rel="stylesheet" href="js/mic.js">
</html>