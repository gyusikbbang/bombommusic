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
    int count1= 0;
    int number = 0;

    String proName = "";
    if (request.getParameter("proName") != null) proName = request.getParameter("proName");

    List<mdPickDataBean> productList = null; 
        List<mdPickDataBean> productList1 = null;
        
    String proCate = "all";
    if (request.getParameter("proCate") != null) proCate = request.getParameter("proCate");

    String proLabel = "all";
    if (request.getParameter("proLabel") != null && !request.getParameter("proLabel").equals("undefined")) proLabel = request.getParameter("proLabel");    
    
    mdPickProductDBBean productProcess = mdPickProductDBBean.getInstance();
    count = productProcess.searchCount(proName, proCate, proLabel);
    
    mdPickProductDBBean productProcess1 = mdPickProductDBBean.getInstance();
    count1 = productProcess1.searchCount(proName, proCate, proLabel);
    
    if (count > 0) {
        productList = productProcess.searchList(proName, proCate, proLabel, startRow, pageSize);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title></title>
    <meta name="keywords" content="shopping mall, jacket, men, women">
    <meta name="description" content="shop any where for women and men's ware">
    <meta name="robots" content="index, follow">

    <!-- open graph -->
    <meta property="og:title" content="Shopy shop any where" />
    <meta property="og:type" content="website" />
    <meta property="og:description" content="shop any where for women and men's ware" />
    <meta property="og:url" content="http://www.shopy.com" />
    <meta property="og:image" content="http://www.shopy.com/images/logo.png" />

    <!-- favicon -->
    <link rel="apple-touch-icon" sizes="57x57" href="images/favicon/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="images/favicon/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="images/favicon/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="images/favicon/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="images/favicon/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="images/favicon/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="images/favicon/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="images/favicon/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="images/favicon/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192"  href="images/favicon/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="images/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="images/favicon/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon/favicon-16x16.png">
    <link rel="manifest" href="images/favicon/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="images/favicon/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">

    <!-- fontawesome -->
    <script src="js/all.min.js"></script>

    <script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
    <script src="js/isotope.pkgd.min.js"></script>
    <script src="js/main.js"></script>

    <!-- bootstrap grid -->
    <link rel="stylesheet" href="css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="css/star-rating.min.css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="css/main.css">
    <link href="../main/css/style.css" rel="stylesheet">
    <link href="../main/css/bottom.css" rel="stylesheet">
    <link href="../main/css/side.css" rel="stylesheet">
    <link href="./css/page.css" rel="stylesheet">
    <link href="../main/css/mic.css" rel="stylesheet">
    <link rel="stylesheet" href="css/md-pick.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

 	<style>
		/*-- 얇은 형광펜 --*/
		.half_highlight {
		background: linear-gradient(to top, #ff5912 20%, transparent 40%);
		} 
    </style>
</head>
<body>
<jsp:include page="../main/top.jsp"/>
<div class="proList_slide" style="overflow: hidden">
    <div class="image_container">
        <div class="inner">
            <img src="images/room.jpg">
        </div>
        <div class="inner">
            <img src="images/room.jpg">
        </div>
        <div class="inner">
            <img src="images/room.jpg">
        </div>
    </div>
    <!-- <p class="controls">
        <span class="prev">prev</span>
        <span class="next">next</span>
    </p> -->
</div>
<div class="slide-btn">
    <button class="btn1">1</button>
    <button class="btn2">2</button>
    <button class="btn3">3</button>
</div>
<div class="mid_section">
    <div class="contents_section">
        <% 
        if (count1 > 0) {
        productList1 = productProcess1.searchList(proName, proCate, proLabel, startRow, pageSize);
    	}
        %>
        <!--md-pick-->
        <div class="recommand-section">
            <div class="md-image">
                <h2 style="font-size:40px; font-family: 'abster'; font-weight: 500;letter-spacing: -0.38px;margin-top: 30px;margin-bottom: 5px;">취향의 발견</h2>
                <span style="color: #767676;
                font-size: 16px;
                font-weight: 400;">취향에 맞는 클래식을 찾아보세요</span>
            </div>
            <div class="md-pick">
             <%
        if (count1 == 0) {
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
                        <a href="../proInfo/proInfo.jsp?proCode=<%=product1.getProCode()%>"><img style="border-radius:20px; width:250px; height: 250px;" src="/BomBom/imageFile/<%=product1.getProImg1()%>"></a>       
                        <div class="text" style="margin-top: 30px; height: 70px;">
	                       	<div id="label" style="margin-top: 5px;"><%=product1.getProLabel()%></div>
	                        <div id="name" style="margin-top: 5px;"><%=product1.getProName()%></div>
	                        
                        </div>
                    </li>
                    <% } %>
                </ul>
                <%}%>
            </div>
                <a class="prev" style="position: relative;left: -540px; top:-300px;">
					<img style=" width: 35px;" src="../imageFile/free-icon-left-arrow-271220.png" alt="">
				</a>
                <a class="next" style="position: relative; top: -300px; right: -540px;">
					<img style=" width: 35px;" src="../imageFile/free-icon-right-arrow-271228.png" alt="">
				</a>
        </div>
    <div class="recommendList-section">
        <div class="img-area" style="width: 100vw; height: 250px; background-color: #acd6a8;">
            <img src="images/wallpaperbetter.com_2732x1536.png" style=" width: 1000px; height: 250px; display: inline-block;">
        </div>
        <div class="mdPickBanner">
            <h2>이번 여름에 이런 앨범 어떠세요?</h2>
        </div>
        <section class="mdProList">
                <!-- <h2 class="content_title"><span>Men's</span> Clothes</h2>
                <p class="content_desc">총 -- 개의 상품</p> -->
    <%
        if (count == 0) {
    %>
			    <div class="alert alert-danger" role="alert">
			        등록된 상품이 없습니다.
			    </div>   
		     
    <% }else {%>
				<ul class="mdProduct">
    <%  
        for (int i = 0; i <productList.size(); i++) {
            mdPickDataBean product = (mdPickDataBean)productList.get(i);
    %>
                
                    <li class="detail">
                        <a href="../proInfo/proInfo.jsp?proCode=<%=product.getProCode()%>"><img src="/BomBom/imageFile/<%=product.getProImg1()%>"></a>       
                        <div class="text">
	                       	<div id="label"><%=product.getProLabel()%></div>
	                        <div id="name"><%=product.getProName()%></div>
                        </div>
                    </li>
                
            <% } %>
    			</ul>	
    		<%}%>	
        </section>
    </div>
</div>
</div>
<jsp:include page="../main/bottom.jsp"/>
<script>
    document.querySelector('.btn1').addEventListener('click', function(){
    document.querySelector('.image_container').style.transform = 'translate(0)'; 
    })

    document.querySelector('.btn2').addEventListener('click', function(){
        document.querySelector('.image_container').style.transform = 'translate(-100vw)';  
    })

    document.querySelector('.btn3').addEventListener('click', function(){
        document.querySelector('.image_container').style.transform = 'translate(-200vw)';  
    })

    var i = 1;

    document.querySelector('.next').addEventListener('click', function(){
        if (i == 1) {
            document.querySelector('.image_container').style.transform = 'translate(-100vw)';
            i += 1;
        } 
        else if (i == 2){
            document.querySelector('.image_container').style.transform = 'translate(-200vw)'; 
            i += 1;
        }
    })

document.querySelector('.prev').addEventListener('click', function(){
    if (i == 2) {
        document.querySelector('.image_container').style.transform = 'translate(0)';
        i -= 1;
    } 
    else if (i == 3){
        document.querySelector('.image_container').style.transform = 'translate(-100vw)'; 
        i -= 1;
    }
})
var value_list;
    
	$(".checkbox-box .checkbox-btn").click(function() {
	  	if(!$(this).is(":checked")){
	  		$("#labelAll-chk").prop("checked", false);
	  	}
	  	
	    value_list = []
        // input 태그 중 name 값이 'test_checkbox'인 것중 상태가 checked인 것들에게 각각 value값을 가져와서 value_list 리스트에 push하여 화면에 alert으로 보여준다.
	    $("input[name='labelChk']:checked").each(function(){
	        var checked_value = $(this).val();
	        value_list.push(checked_value)
	    });
	    alert(value_list);	  	
	});

    
    
    
    
    /* var chkList = $("input[name=labelChk]");

    $("#labelAll-chk").click(function(){
       if($(this).is(":checked")){
          chkList.prop("checked", true);
       }else
          chkList.prop("checked", false);
    }); */
    
    var proCate = "<%=proCate%>";
    $("#cate_" + proCate).addClass("half_highlight");
    
    var proLabel = "<%=proLabel%>";
    switch (proLabel)
    { 
    	case 'all' : $("#label_all").addClass("half_highlight"); break;
    	case '워너 클래식' : $("#label_100").addClass("half_highlight"); break;
    	case '유니버셜 클래식' : $("#label_200").addClass("half_highlight"); break;
    	case '소니 클래식' : $("#label_300").addClass("half_highlight"); break;
    	case '낙소스' : $("#label_400").addClass("half_highlight"); break;
    }
    
    function fnProdSearch(pageno) {
    	document.location.href = "proList.jsp?proCate="+proCate+"&proLabel="+proLabel+"&pageNum="+pageno;	
    }
</script>
</body>
<link rel="stylesheet" href="../main/js/mic.js">
<script src="js/md-pick.js"></script>
</html>