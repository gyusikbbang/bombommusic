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
<link href="../main/css/side.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<style>
    .owl-carousel .owl-item img{display:block;width:100%;margin-top:190px;}
</style>
<%

/// 순위 몇개 까지 출력하는지 여기 수정하면됨
int startRow = 1;
int endRow = 5;
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
<jsp:include page="top.jsp"/>
<!--이미지 슬라이드-->
<div class="carousel-1" data-carousel-1-autoplay-status="Y">
    <ul class="owl-carousel owl-theme">
        <li class="item"><img src="../imageFile/962489325.jpg" style="width: 100vw; height: 400px;"></li>
        <li class="item"><img src="../imageFile/shutterstock_1842831988.jpg" style="width: 100vw; height: 400px;"></li>
        <li class="item"><img src="images\room.jpg" style="width: 100vw; height: 400px;"></li>
        <li class="item"><img src="images\room.jpg" style="width: 100vw; height: 400px;"></li>
    </ul>
    <!-- <div class="play">시작</div>
    <div class="stop">정지</div> -->
</div>
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
            </div>
            <ul class="chart">
                <!--1위-->
                <%
					for (int i = 0; i < productList.size(); i++) {
						ShopProductDataBean product = productList.get(i);
						String audioId = "customPlayButton_" + i;
						String audioElementId = "audio_" + i;
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
								<p><%=product.getRecommend()%></p>
								</span>
								
							</div>
							<div type="button" class="play-btn">
								<button style="height:50px; margin-top:22px"><span id="<%=audioId%>" class="material-symbols-outlined">play_arrow
								</button>
								</span>
								<script>
									var track_<%=i%> = new Audio();
									track_<%=i%>.src = "/BomBom/imageFile/<%=product.getAudio()%>";
									var customPlayButton_<%=i%> = document.getElementById("<%=audioId%>");
									var audioElement_<%=i%> = document.getElementById("<%=audioElementId%>");
									var isPlaying_<%=i%> = false;
									
									customPlayButton_<%=i%>.addEventListener("click", function() {
									  if (!isPlaying_<%=i%>) {
									    track_<%=i%>.play();
									    isPlaying_<%=i%> = true;
									  } else {
									    track_<%=i%>.pause();
									    isPlaying_<%=i%> = false;
									  }
									});
									
									track_<%=i%>.addEventListener("ended", function() {
									  isPlaying_<%=i%> = false;
									});
									</script>
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
			<a style="margin-top: 40px; margin-bottom: 20px;" href = "../proChart/proChart.jsp">
				<img style="width: 70px; position: relative; left: -697.5px; top:277px" src="../imageFile/free-icon-more-463292.png" alt="">
			</a>
        </div>
		
        <% 
        if (count1 > 0) {
        productList1 = productProcess1.searchList(proName, proCate, proLabel, startRow, pageSize);
    	}
        %>
        <!--md-pick-->
        <div class="recommand-section">
            <div class="md-image">
                <img src=
                    "//image.kyobobook.co.kr/newimages/giftshop_new/resources/images/pc/main/tit_wel_md_pick.svg" 
                        alt="MD PICK">
            </div>
            <div class="md-pick">
             <%
        if (count == 0) {
    		%>
			    <div class="alert alert-danger" role="alert">
			        등록된 상품이 없습니다.
			    </div>   
		     
    <%}else {%>
                <ul class="slides">
                <%  
        for (int i = 0; i <productList1.size(); i++) {
            mdPickDataBean product1 = (mdPickDataBean)productList1.get(i);
    %>
                    <li>
                        <a href="../proInfo/proInfo.jsp?proCode=<%=product1.getProCode()%>"><img style="border-radius: 20px; width:250px" src="/BomBom/imageFile/<%=product1.getProImg1()%>"></a>       
                        <div class="text" style="margin-top: 30px;">
	                       	<div id="label" style="margin-top: 5px;"><%=product1.getProLabel()%></div>
	                        <div id="name" style="margin-top: 5px;"><%=product1.getProName()%></div>
                        </div>
                    </li>
                    <% } %>
                </ul>
                <%}%>
            </div>
                <a class="prev" style="position: relative;left: -466px; top:-300px;">
					<img style=" width: 35px;" src="../imageFile/free-icon-left-arrow-271220.png" alt="">
				</a>
                <a class="next" style="position: relative; top: -300px; right: -540px;">
					<img style=" width: 35px;" src="../imageFile/free-icon-right-arrow-271228.png" alt="">
				</a>
            <a style="margin-top: 40px; margin-bottom: 20px;" href = "../mdPick/mdPick.jsp">
				<img style="width: 70px; position: relative; left: -40px; top: -35px;" src="../imageFile/free-icon-more-463292.png" alt="">
			</a>
        </div>
    </div>
    <jsp:include page="bottom.jsp"/>
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