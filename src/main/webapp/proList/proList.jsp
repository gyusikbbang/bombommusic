<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Manager.ShopProductDataBean" %>
<%@ page import="Manager.ShopProductDBBean" %>
<%@ page import="Product.ProductDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
    int pageSize = 15;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
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

    List<ShopProductDataBean> productList = null; 
        
    String proCate = "all";
    if (request.getParameter("proCate") != null) proCate = request.getParameter("proCate");

    String proLabel = "all";
    if (request.getParameter("proLabel") != null && !request.getParameter("proLabel").equals("undefined")) proLabel = request.getParameter("proLabel");    
    
    ProductDBBean productProcess = ProductDBBean.getInstance();
    count = productProcess.searchCount(proName, proCate, proLabel);
    
    if (count > 0) {
        productList = productProcess.searchList(proName, proCate, proLabel, startRow, pageSize);
    }   
%>
<!DOCTYPE html>
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
    <link href="../css/page.css" rel="stylesheet">
    <link href="../main/css/mic.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

 	<style>
		/*-- 얇은 형광펜 --*/
		.half_highlight {
		background: linear-gradient(to top, #ff5912 20%, transparent 40%);
		} 
    </style>
</head>
<%

String product_kindName = "";
    if(proCate.equals("100")){
        product_kindName = "음악";
    }else if(proCate.equals("200")){
        product_kindName = "클래식";  
    }else if(proCate.equals("300")){
        product_kindName = "합필갤";
    }else if(proCate.equals("all")){
        product_kindName = "전체";
    } 
%>
<jsp:include page="../main/top.jsp"/>
<div class="proList_slide" style="overflow: hidden">
    <div class="image_container">
        <div class="inner">
            <img src="../imageFile/banner1.png" style="width: 100%; height:500px; margin-top: 140px; position: relative;left: -10px;">
        </div>
        <div class="inner">
            <img src="../imageFile/banner1.png" style="width: 100%; height:500px; margin-top: 140px; position: relative;left: -10px;">
        </div>
        <div class="inner">
            <img src="../imageFile/banner1.png" style="width: 100%; height:500px; margin-top: 140px; position: relative;left: -10px;">
        </div>
    </div>
</div>
<div class="slide-btn">
    <button class="btn1">1</button>
    <button class="btn2">2</button>
    <button class="btn3">3</button>
</div>
    <div class="contents_section" style="background: #f2eeea; height: 1700px; margin-top: 10px;">
            <section class="filters">
                <h2 class="hidden">category filter</h2>
                <div class="category_menu">
                    <h3>Categories</h3>
                    <ul>
                        <li><a href="#" onclick="fnSearch('all', '<%=proLabel%>');" id="cate_all">전체</a></li>
                        <li><a href="#" onclick="fnSearch('100', '<%=proLabel%>');" id="cate_100">피아노</a></li>
                        <li><a href="#" onclick="fnSearch('200', '<%=proLabel%>');" id="cate_200">현악기</a></li>
                        <li><a href="#" onclick="fnSearch('300', '<%=proLabel%>');" id="cate_300">목관악기</a></li>
                        <li><a href="#" onclick="fnSearch('400', '<%=proLabel%>');" id="cate_400">금관악기</a></li>
                    </ul>
                </div>            
                <div class="list_filters">
                    <div class="combi_filters">
                        <div class="size_filter">
                            <h3>Label</h3>
                            <ul>
		                        <li><a href="#" onclick="fnSearch('<%=proCate%>', 'all');" id="label_all">전체</a></li>
		                        <li><a href="#" onclick="fnSearch('<%=proCate%>', '워너 클래식');" id="label_100">워너 클래식</a></li>
		                        <li><a href="#" onclick="fnSearch('<%=proCate%>', '유니버셜 클래식');" id="label_200">유니버셜 클래식</a></li>
		                        <li><a href="#" onclick="fnSearch('<%=proCate%>', '소니 클래식');" id="label_300">소니 클래식</a></li>
		                        <li><a href="#" onclick="fnSearch('<%=proCate%>', '낙소스');" id="label_400">낙소스</a></li>
		                    </ul>
                        </div>
                    </div>
                </div>            
            </section>
            <section class="new_arrivals">
    <%
        if (count == 0) {
    %>
			<div class="alert alert-danger" role="alert">등록된 상품이 없습니다.</div>   

    <% }else {%>
            <div class="proList">
                <ul class="new_arrivals_list row">
        <%  
            for (int i = 0; i <productList.size(); i++) {
                ShopProductDataBean product = (ShopProductDataBean)productList.get(i);
            %>
                    <li id="product" class="row">
                        <div class="list_contents">
                            <div class="default">
                                <a href="../proInfo/proInfo.jsp?proCode=<%=product.getProCode()%>">
                                <img style="width:150px; height:150px;" src="/BomBom/imageFile/<%=product.getProImg1()%>"></a>       
                                <a href="../proInfo/proInfo.jsp?proCode=<%=product.getProCode()%>">
                                <h3 style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%=product.getProName()%></h3></a> 
                                <% if (product.getDiscount_rate() > 0) { 
                                    int discountPrice = product.getPrice() - Math.round(((product.getPrice() * product.getDiscount_rate()) / 100));
                                %>
                                <h4><span style="color:red;"><%=product.getDiscount_rate()%>%</span>&nbsp;<%=discountPrice%>원&nbsp;<span style="text-decoration: line-through;"><%=product.getPrice()%>원</span></h4> 
                                <% } else { %>
                                <h4><%=product.getPrice()%>원</h4>
                                <% } %>
                            </div>
                            <div class="hover">
                                <p>
                                    <span class="size"><%=product.getProLabel()%></span>
                                </p>
                                <p>
                                    <span class="size"><%=product.getRecommend()%></span>
                                </p>
                                <hr/>
                            </div>
                        </div>
                    </li>
                    <% } %> 
                </ul>
            </div>           
            <%}%>
            </section>
    
        <%
        if (count > 0) {
        %>
        <div class="pagination" style="margin-top: 30px;">
            <ul class="page">
        <%
            int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
            int startPage = 1;
            int pageBlock = 5;

            if(currentPage % pageBlock != 0)
                startPage = (int)(currentPage/pageBlock)*pageBlock + 1;
            else
                startPage = ((int)(currentPage/pageBlock)-1)*pageBlock + 1;

            int endPage = startPage + pageBlock - 1;
            if (endPage > pageCount) endPage = pageCount;
        %>
            <%
            if (startPage < pageBlock) {
            %>
            <a class="page-link-disable" href="#" onclick="fnProdSearch(<%=startPage%>);" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
            </a>
            
            <%
            }else {
                %>
                <a class="page-link" href="#" onclick="fnProdSearch(<%= startPage - pageBlock %>);" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
                </a>
            <% } %>

            <% 
            for (int i = startPage; i <= endPage; i++) { %>
            <a class="page-link" href="#" onclick="fnProdSearch(<%= i %>);"><%= i %></a>
            <%  } %>
            
            <%
            if (endPage >= pageCount){
            %>
            <a class="page-link-disable" href="#" onclick="fnProdSearch(<%= endPage %>);" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
                </a>
            
            <% }else{ %>
            <a class="page-link" href="#" onclick="fnProdSearch(<%= startPage + pageBlock %>);" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
                </a>
            
            <% } %>
            </ul>
        </div>
    </div>
    <%}%>
<jsp:include page="../main/bottom.jsp"/>
</body>
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
<link rel="stylesheet" href="../main/js/mic.js">
</html>