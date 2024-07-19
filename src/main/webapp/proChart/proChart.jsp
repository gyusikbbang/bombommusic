<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Manager.ShopProductDataBean" %>
<%@ page import="Manager.ShopProductDBBean" %>
<%@ page import="Product.ProductDBBean" %>
<%@ page import="Manager.mdPickDataBean" %>
<%@ page import="Manager.mdPickDBBean" %>
<%@ page import="Product.mdPickProductDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>BomBom</title>
<link href="css/style.css" rel="stylesheet">
<link href="css/imageBanner.css" rel="stylesheet">
<link href="css/chart.css" rel="stylesheet">
<link href="css/md-pick.css" rel="stylesheet">
<link href="../main/css/style.css" rel="stylesheet">
<link href="../main/css/bottom.css" rel="stylesheet">
<link href="../main/css/side.css" rel="stylesheet">
<link href="./css/page.css" rel="stylesheet">
<link href="../main/css/mic.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<style>
    .owl-carousel .owl-item img{display:block;width:100%;margin-top:190px;}
</style>
<%

/// 순위 몇개 까지 출력하는지 여기 수정하면됨
int startRow = 1;
int endRow = 10;
int count = 0;
String proCate = "all";
String select = "buyrecommend";



String selectname = "";
if (select.equals("buyrecommend")) {
	selectname = "판매량+추천수";
	
}else if(select.equals("recommend")) {
	selectname = "추천";
}else if(select.equals("buy")) {
	selectname = "구매량";
}


List<ShopProductDataBean> productList = null;
ShopProductDBBean productProcess = ShopProductDBBean.getInstance();

count = productProcess.getProductCount();

if (count > 0) {
	productList = productProcess.getrankingProducts(proCate, startRow, endRow, select);
}

%>
<%
	int pageSize = 6;
	int count1 = 0;	
	
	String proName = "";
	if (request.getParameter("proName") != null) proName = request.getParameter("proName");

	List<mdPickDataBean> productList1 = null; 
        
    if (request.getParameter("proCate") != null) proCate = request.getParameter("proCate");

    String proLabel = "all";
    if (request.getParameter("proLabel") != null && !request.getParameter("proLabel").equals("undefined")) proLabel = request.getParameter("proLabel");    
    
    mdPickProductDBBean productProcess1 = mdPickProductDBBean.getInstance();
    count1 = productProcess1.searchCount(proName, proCate, proLabel);
%>
</head>
<body>
<jsp:include page="../main/top.jsp"/>

<%
	if (count == 0) {
	%>
	<div class="alert alert-danger" role="alert">등록된 상품이 없습니다.</div>

	<%
	} else {
	%>  

    <div class="contents_section">
        <!--앨범 순위-->
        <div class="chart-section" style="background-color: rgb(242 242 242);">
            <div class="chart-text">
                <h1>BomBom 인기앨범 순위<img src="images\thumb-up.png"><!--제작자: Dooder - Flaticon--></h1>
                <h3 style="margin-top: 10px; color:gray text-align:center;">추천수와 판매량을 종합한 순위 입니다</h3>
            </div>
            <ul class="chart">
                <!--1위-->
                <%
					for (int i = 0; i < productList.size(); i++) {
						ShopProductDataBean product = productList.get(i);
					%>
                <li class="chart-li">
						<div class="chart-num">
							<p><%=i + 1%>
							</p>
						</div>
						<div class="chart-img">
							<a
								href="../proInfo/proInfo.jsp?proCode=<%=product.getProCode()%>"><img
								src="/BomBom/imageFile/<%=product.getProImg1()%>"></a>
						</div>
						<div class="chart-detail">
							<div class="contents1"><%=product.getProName()%></div>
							<div class="contents2"><%=product.getProLabel()%></div>
						</div>
						<div class="chart-btn">
							<div type="button" class="favorite-btn">
								<span class="material-symbols-outlined">favorite
								<p><%=product.getSalerecommend()%></p>
								</span>
								
							</div>
							<div type="button" class="play-btn">
								<span class="material-symbols-outlined">play_arrow</span>
							</div>
							<div type="button" class="toCart-btn">
								<span class="material-symbols-outlined"></span>
							</div>
						</div>
					</li>
					<%
					}
					%>
					<%
					}
					%>
            </ul>
        </div>
    </div>
    <jsp:include page="../main/bottom.jsp"/>
    </div>  
    <!-- 제이쿼리 불러오기 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <!-- owl 캐러셀 불러오기 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.theme.default.min.css">
    <!-- 폰트어썸 불러오기 -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <script src="js\imageBanner.js"></script>
    <script src="js\md-pick.js"></script>
    <script type="js\side.js"></script>
</body>
</html>