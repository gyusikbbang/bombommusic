<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Manager.mdPickDataBean" %>
<%@ page import="Manager.mdPickDBBean" %>
<%@ page import="Product.mdPickProductDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
    int pageSize = 6;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
	String pageNum = request.getParameter("pageNum");

    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage =  Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize;
    //int endRow = currentPage * pageSize;
    int count = 0;
    int number = 0;

    String proName = "";
    if (request.getParameter("proName") != null) proName = request.getParameter("proName");

    List<mdPickDataBean> productList = null; 
        
    String proCate = "all";
    if (request.getParameter("proCate") != null) proCate = request.getParameter("proCate");

    String proLabel = "all";
    if (request.getParameter("proLabel") != null && !request.getParameter("proLabel").equals("undefined")) proLabel = request.getParameter("proLabel");    
    
    mdPickProductDBBean productProcess = mdPickProductDBBean.getInstance();
    count = productProcess.searchCount(proName, proCate, proLabel);
    
    if (count > 0) {
        productList = productProcess.searchList(proName, proCate, proLabel, startRow, pageSize);
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>BomBom</title>
<link href="css/style.css" rel="stylesheet">
<link href="css/side.css" rel="stylesheet">
</head>
<body>
    <div class="side-container">
        <div class="side_menu">
            <label style="    text-align: center;
            box-shadow: inset 0 -17px 0 #bfffa1;
            color: black;" class="menu_name"for="expand-menu">MD Pick</label>
            <ul class="side_ul">
                <%
        if (count > 0) {
            int displayCount = 3;
            if (count < displayCount) displayCount = count;
        for (int i = 0; i<displayCount; i++) {
            mdPickDataBean product = (mdPickDataBean)productList.get(i);
    %>
                <li style="margin-bottom: 80px; width: 100px; display: inline-block;">
                    <a href="../proInfo/proInfo.jsp?proCode=<%=product.getProCode()%>">
                        <img style="width: 80px;
                        border-radius: 8px;
                        border: 3px solid white;"
                        src="/BomBom/imageFile/<%=product.getProImg1()%>"></a>
                </li>
         <% }
        }
        %>      
            </ul>
        </div>
        <div class="side-toOrder">
            <button id="toOrder-btn" onclick = "location.href = '../mypage/mypage2.jsp' "><h4>Order List</h4></button>
        </div>
    </div>
</body>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="js/side.js"></script>
</html>