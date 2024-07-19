<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Manager.ShopProductDataBean" %>
<%@ page import="Manager.ShopProductDBBean" %>
<%@ page import="Manager.reviewDataBean" %>
<%@ page import="Manager.reviewDBBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    String ip = request.getRemoteAddr();
    String proCode = request.getParameter("proCode");
    //String id = request.getParameter("id");
    String id = (String)session.getAttribute("memberId");
    
   String rvContent = "";
    
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 상세보기</title>
    <link href="../main/css/style.css" rel="stylesheet">
    <link href="../main/css/bottom.css" rel="stylesheet">
    <link href="../main/css/side.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/infoBody.css" rel="stylesheet">
    <link href="css/review.css" rel="stylesheet">
    <link href="../main/css/mic.css" rel="stylesheet">
    <link href="css/modify.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />


</head>
<%
    ShopProductDataBean productList = null;
    ShopProductDBBean productProcess = ShopProductDBBean.getInstance();
    
    String  ck = request.getParameter("ck");
    if(request.getParameter("ck")==null){
        ck= String.valueOf(productProcess.recommend(Integer.parseInt(proCode),ip));
	}else{
    	ck = request.getParameter("ck");
	}
    
    
    productList = productProcess.getProduct(Integer.parseInt(proCode));
    int discountPrice = productList.getPrice() - Math.round(((productList.getPrice() * productList.getDiscount_rate()) / 100));
%>
<%
	int pageSize = 5;

	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
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
    count = reviewProcess.rvsearchCount(Integer.parseInt(proCode));
    if (id != null && !id.equals("")) {
    	rvCount = reviewProcess.rvRegistCount(Integer.parseInt(proCode), id);
    }
%>
	<%-- <script>
		alert("<%=count%>");	
	</script> --%>
<%     
    if (count > 0) {
    	reviewList = reviewProcess.reviews(Integer.parseInt(proCode),startRow,endRow);
    	
    }
%>
<body>
<jsp:include page="../main/top.jsp"/>
<div class="mid_section">
    <div class="contents_section">
        <div class="product_view">
            <h2><%=productList.getProName()%></h2>
            <tr>
                	<td><button id="customPlayButton" class="btn btn-primary">미리듣기</button></td>
                </tr>
            <table class="ProDetailTable">
                <colgroup>
                <col style="width:173px;">
                <col>
                </colgroup>
                <tbody>
                <tr>
                    <th>판매가</th>
                    <% if (productList.getDiscount_rate() > 0) { %>
                    <td class="price" id="price"><span style="color:red;"><%=productList.getDiscount_rate()%>%</span>&nbsp;<%=discountPrice%>원&nbsp;<span style="text-decoration: line-through;"><%=productList.getPrice()%>원</span></td> 
                    <%-- <td id="price"><%=discountPrice%>원&nbsp;(<%=productList.getDiscount_rate()%>% 할인)</td>--%>
                    <% } else { %>
                    <td class="price" id="price"><%=productList.getPrice()%>원</td>
                    <% } %>
                </tr>
                <tr>
                    <th>상품코드</th>
                    <td><%=productList.getProCode() %></td>
                </tr>
                <tr>
                    <th>제조사/공급사</th>
                    <td><%=productList.getProLabel() %></td>
                </tr>
                <tr>
                    <th>사용가능쿠폰</th>
                    <td>0개</td>
                </tr>
                <tr>
                    <th>배송비</th>
                    <td>무료배송</td>
                </tr>
                
                
                  <%
         if (ck.equals("0")) {
              
         %>
       
         <a  onclick="location.replace('recommendpro.jsp?proCode=<%=proCode%>&ip=<%=ip%>'); return false;" >
         추천해제♥
         </a>

         
         
         <% }
         else {
            
         %>
         <a  onclick="location.replace('recommendpro.jsp?proCode=<%=proCode%>&ip=<%=ip%>'); return false;" >
         추천해줘♥
         </a>
         <%
         } %>
                </tbody>
            </table>
            <div class="img">
                <img src="/BomBom/imageFile/<%=productList.getProImg1()%>" alt="" id="productImg">
                <ul>
                	<% if (productList.getProImg1() != null && !productList.getProImg1().equals("")) { %>
	                <li class="on" id="img1"><a href="javascript:selectImg(1);" ><img src="/BomBom/imageFile/<%=productList.getProImg1()%>" alt=""></a></li>
	                <% } %>                
                	<% if (productList.getProImg2() != null && !productList.getProImg2().equals("")) { %>
	                <li id="img2"><a href="javascript:selectImg(2);"><img src="/BomBom/imageFile/<%=productList.getProImg2()%>" alt=""></a></li>
	                <% } %>
	                <% if (productList.getProImg3() != null && !productList.getProImg3().equals("")) { %>
	                <li id="img3"><a href="javascript:selectImg(3);"><img src="/BomBom/imageFile/<%=productList.getProImg3()%>" alt=""></a></li>
	                <% } %>
                </ul>
            </div>
            <div class="btns">
                <form class="form-toCart" method="post" action="toCart.jsp">
                    <input type="hidden" name="proCode" id="proCode" value="<%=proCode%>">
                    <input type="hidden" name="proName" id="proName" value="<%=productList.getProName() %>">
                    <input type="hidden" name="price" id="proPrice" value="<%=discountPrice%>">
                    <input type="hidden" name="proImg" id="proImg" value="<%=productList.getProImg1() %>">

                    <input type="number" class="form-control" name="buyCount" id="proBuyCount" value="1">
                    <input type="submit" class="btn-success" value="장바구니에 담기">
                </form>
                <a href="#a" class="btn2" onClick="directBuy();">구매하기</a>
            </div>
        </div>
        <div class="info_body">
            <div class="tabs">
                <input id="content1" type="radio" name="tab_item" checked>
                <label class="tab_item" for="content1">상품정보</label>
                <input id="content2" type="radio" name="tab_item">
                <label class="tab_item" for="content2">리뷰</label>
                <input id="content3" type="radio" name="tab_item">
                <label class="tab_item" for="content3">QnA</label>
                <input id="content4" type="radio" name="tab_item">
                <label class="tab_item" for="content4">배송문의</label>
                <div class="tab_content" id="content1">
                <caption>
                	<div style="width:1200px; text-align:center">
                    <!--     <h5 style="text-align:left; line-height: 2; font-size: 20px; margin-bottom:20px" >
                        <%=productList.getProInfo()%></h5> -->
                    </div>
                </caption>
                    <ul>
                        <li class="item"><img src="images\iii.PNG"></li>
                        <li class="item"><img src="images\room.jpg"></li>
                        <li class="item"><img src="images\room.jpg"></li>
                        <li class="item"><img src="images\room.jpg"></li>
                    </ul>
                </div>
                <div class="tab_content" id="content2">
                    <h3 style="text-align: left">한줄평(<%=count %>건)</h3>
                    <h4 style="text-align: left">1,000원 이상 구매 후 한줄평 작성 시 50원 BomBom포인트를 드립니다.</h4>
                                <%
                                if (id == null || id.equals("null")) {
                                	
                                %>
                    <div class="review-input">
                        <span class="input-area">          
                            <div class="input-box">
                                  <button id="submit" type="button" onclick="location.href='../login/login.jsp'">로그인하세요</button>
                            </div>
                        </span>
                    </div>
                               
                                
                                <%} else if (rvCount == 0) { %>
                    <div class="review-input">
                        <span class="input-area">          
                            <div class="input-box">                                       
                              
                                 <form method="post" action="reviewinsertpro.jsp">
                                 	<input id="review-text" name="RvContent" type="text" placeholder="리뷰를 입력해주세요(최대 1000자)"/>
                                  	<input id="review-text" name="id" value="<%=id %>" style="display:none" type="text" placeholder="리뷰를 입력해주세요(최대 1000자)"/>
                              
                                   	<input name="proCode" value="<%=proCode%>"  style="display:none" placeholder="리뷰를 입력해주세요(최대 1000자)"/>
                                    <button id="submit" type="submit" >작성</button>
                                    
                                    
                        		</form> 
                            </div>
                        </span>
                    </div>
                                <%} %>
                    <div class="review-list">
                    	<%
        				if (count == 0) {
    					%>
    					<h5>등록된 리뷰가 없습니다.</h5>
    					<% }else{%>
                        <%  
                        for (int i = 0; i<reviewList.size(); i++) {
                            reviewDataBean review = (reviewDataBean)reviewList.get(i);
                            Timestamp date1 = review.getRvRegdate();
                            String date2 = String.valueOf(sdf.format(date1));
                        %> 
                        <div class="rvContent">
                        	<h3><%=review.getMemberId()%></h3>
                        	<h4 style="width:690px; text-align:left; margin-left:10px"><%=review.getRvContent()%></h3>
                            <%
                        	if (review.getMemberId().equals(id)) {
                       		 %> 
                       		 <h5><%=date2 %></h5>
                       		 <div class="btn">
                            	<a href="#pop_info_1" class="btn_open">수정</a> 
                                <a href="#pop_info_2" class="btn_open">삭제</a>
                             </div>
                             
                                <%} %>
                        </div>
                        
                                <div id="pop_info_1" class="pop_wrap" style="display:none;">
                                    <div class="pop_inner">
                                    	<div class="inner-title">
	                                    	<p>상품 수정하기</p>	
                                    	</div>
                                    	<button type="button" class="btn_close">취소</button>
                                        <div class="review-input1">
                                            <span class="input-area1">          
                                                <div class="input-box1">                                       
                                                    <form method="post" action="reviewModifyPro.jsp">
                                                        <input id="review-text1" name="RvContent" type="text" placeholder="리뷰를 입력해주세요(최대 1000자)"/>
                                                            <input id="review-text1" name="id" value="<%=id %>" style="display:none" type="text" />
                                                        <input name="proCode" value="<%=proCode%>"  style="display:none"/>
                                                        <button id="submit1" type="submit" >작성</button>  
                                                    </form> 
                                                </div>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            	
                            	<div id="pop_info_2" class="pop_wrap" style="display:none;">
								    <div class="pop_inner1">
								      <p class="dsc">삭제하시겠습니까?</p>
								      <button type="button" class="btn_close1">취소</button>
								      <form class="form-delete"method="post" action="reviewDeletePro.jsp">
                                           	<input id="review-text1" name="id" value="<%=id %>" style="display:none" type="text" />
                                            <input name="proCode" value="<%=proCode%>"  style="display:none"/>
                                            <button id="submit2" type="submit" >삭제</button>  
                                      </form>
								    </div>
								</div>
                            <% }%> 

                        <%}%>
                        
                    </div>
                    
                </div>
                <div class="tab_content" id="content3">
                    <div style="margin-bottom: 40px; text-align: left;" >
                        <h2 style="margin-bottom: 10px; width: 350px; background-color: rgb(206, 255, 255);" >상품을 교환/반품하고 싶습니다.</h2>
                        <h4 style="line-height: 30px;">상품(업체)마다 교환/반품 절차가 상이하오니 교환/반품을 원하실 경우 전화(국번없이) 1111-2222으로 연락주시어

                            교환/반품 절차 안내를 받으시면 됩니다.
                            (이 경우 주문번호, 반품하실 상품명을 알려주시기 바랍니다.)

                            고객변심으로 인한 교환/반품시 발생하는 왕복비용(배송비)은 고객 부담이며 사용된 할인쿠폰은 반환되지 않습니다.
                            
                            발생된 배송비는 계좌입금으로 처리 되고 있습니다.</h4>
                    </div> 
                    <div style="margin-bottom: 40px; text-align: left;">
                        <h2 style="margin-bottom: 10px; width: 630px; background-color: rgb(206, 255, 255);">주문한 상품이 품절인 경우, 환불은 어떻게 이루어 지나요?</h2>
                        <h4 style="line-height: 30px;">주문하신 상품이 품절인 경우에는 상품준비가 불가능하기 때문에 발송하기 어려워 문자 안내 후 자동 주문 취소가 됩니다.<br>


                            1. 주문시 카드로 결제하신 경우
                               주문 전체가 품절인 경우에는 카드승인내역을 취소하며, 일부 상품이 품절인 경우에는 예치금으로 전환됩니다.<br>
                            
                             
                            
                            2. 주문시 현금성 결제를 하신 경우    실시간 계좌이체, 온라인 송금 등으로 입금하신 경우는 금액이 예치금으로 전환됩니다.<br>
                            
                             
                            
                            3. 통합포인트, 예치금, 쿠폰 등을 사용하신 경우 
                               통합포인트는 통합포인트로, 예치금은 다시 예치금으로 전환됩니다.<br> 쿠폰은 동일한 내역으로 재발급해 드립니다.
                               단, 유효기간이 경과된 경우에는 쿠폰 재발급이 불가하오니 유의해 주시기 바랍니다.<br>
                            </h4>
                    </div>
                    
                </div>
                <div class="tab_content" id="content4">
                    
                    <div style="margin-bottom: 40px; text-align: left;">
                        <h2 style="margin-bottom: 10px; width: 330px; background-color: rgb(206, 255, 255);">주문한 상품이 아직 안 왔어요.</h2>
                        <h4 style="line-height: 30px;">주문하신 상품을 아직 못받아 보셨다면 다음 사항을 확인해 주십시오.

 

                            1. 주문 및 발송확인에서 상품의 처리상태가 발송완료로 되어 있는 경우 당사(업체)에서는 발송처리를 한 것입니다.<br>
                            
                                당사(업체)에서 발송처리가 되었으나 2~3일 이내에 받아보시지 못한 경우는 다음을 확인하시기 바랍니다.<br>
                            
                            * 배송조회를 확인하셔서 주문하신 상품이 받아보실 주소의 근처 취급소에 있다고 조회되면, 택배사 직원이 방문했음에도
                               불구하고 부재중이셔서 배송받지 못하신 경우가 많습니다.<br>
                               이 경우 전화(국번없이)1111-2222를 이용하시면 신속히 처리해 드립니다.<br>
                            
                             
                            
                            2. 주문 및 발송 단계에『상품 준비중』단계에 오래 머물러있을 경우 상품 재고부족으로 인한 품절이거나 입고지연으로 인한 
                                발송 지연된 경우입니다.<br>품절로 인한 발송이 어려울 경우 유선상 별도 안내를 드리고 있습니다만,
                                연락처가 불분명하거나 배송정보 오기로 인해 연락이 닿지 못하는 경우가 대부분입니다.<br>
                             
                            [마이페이지]의 [회원정보 수정]에서 개인연락처 등을 수정해주시고 1111-2222으로 연락주시면 보다 상세히 상담해드리겠습니다.<br></h4>
                    </div>
                    <div style="margin-bottom: 40px; text-align: left;">
                        <h2 style="margin-bottom: 10px; width: 430px; background-color: rgb(206, 255, 255);">주문하면 얼마 만에 받아볼 수 있나요?</h2>
                        <h4 style="line-height: 30px;">고객님께서 주문하신 상품을 실제 받기까지의 기간은 "예상출고일+배송일"입니다.<br>

 

                            ’예상출고일’이란 근무일 기준으로 상품이 준비되는 시간만을 안내하는 것이며, 배송기간은 예상출고일 외 택배를 통해
                            
                            고객님께 실제 배송되는 기간을 말합니다.<br>
                            
                            출고예정일은 상품에 따라 준비기간이 다르며 배송 기간은 지역에 따라 약간씩 다르나 보통 1~3일정도 소요됩니다.
                            
                            (도서산간지역은 최대 7일 소요)<br>
                            
                             
                            
                            * 예상출고일은 영업일 기준으로 산정되며, 일요일과 공휴일 및 기타 휴무일에는 배송되지 않습니다.<br>
                            (’예상출고일’은 상품 상세페이지에 기재되어 있습니다.)
                            * 주문한 상품의 당사(업체)에 재고가 없을 경우에는 거래처로 다시 주문을 요청하여 재고 확보 후 발송합니다만, 재 입고 예정일이 길어질 경우 수일이 더 소요 될수 있습니다.
                            (상품 단종으로 인한, 재고 확보가 어려울 경우 발송이 어려울 수 있습니다.)<br>
                            * 천재지변 등의 불가항력적 사유로 인한 배송 지연은 그 해당기간 동안의 배송소요 기간에서 제외됩니다</h4>
                    </div>                  
                </div>
            </div>
        </div>
    </div>
    <div class="side_section">
        <jsp:include page="../main/side.jsp"/>
    </div>
</div>
<jsp:include page="../main/bottom.jsp"/>s
<script>
function qtyPlusMinus(flag) {
	var buyCount = parseInt($("#buyCount").val());
	if (buyCount == 1 && flag == -1) {
		return;
	} else {
		buyCount += flag;
		$("#buyCount").val(buyCount);
		calcAmount();
	}
}

function calcAmount() {
	var buyCount = parseInt($("#buyCount").val());
	var price = parseInt("<%=productList.getPrice()%>");
	$("#totalAmount").text(addComma(buyCount * price));
}

$(document).ready(function(){
	calcAmount();
	$("#price").text(addComma($("#price").text()));
});

function addComma(data) {
    return data.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function selectImg(position) {
	var imgUrl = "/BomBom/imageFile/";
	if (position == 1) imgUrl += "<%=productList.getProImg1()%>";
	else if (position == 2) imgUrl += "<%=productList.getProImg2()%>";
	else imgUrl += "<%=productList.getProImg3()%>";
	
	$(".img > ul > li").removeClass("on");
	
	$("#img" + position).addClass("on");
	
	$("#productImg").attr("src", imgUrl);
}
</script>
 <script> 
  var track3 = new Audio();
  track3.src = "/BomBom/imageFile/<%=productList.getAudio()%>";
  var customPlayButton = document.getElementById("customPlayButton");
  customPlayButton.addEventListener("click", function(){
    if( track3.paused ){
      track3.play();
    setTimeout(function () { 
        track3.pause();
    }, 60000);
    track3.currentTime = 0; 
    track3.play();
    }else if(track3.played){
    	track3.pause();
    }
  });
  
  $(document).ready(function(){
		calcAmount();
		
		<% if (productList.getDiscount_rate() > 0) { %>
		$("#price").html('<span style="color:red;"><%=productList.getDiscount_rate()%>%</span>&nbsp;' + addComma('<%=discountPrice%>')
			+ '원&nbsp;<span style="text-decoration: line-through;">' + addComma('<%=productList.getPrice()%>') + '원</span>'); 
	    <% } else { %>
		$("#price").text(addComma($("#price").text()));
		<% }%>
	});
  
  function directBuy() {
	     // form 태그 생성 & 속성부여
	    var newForm = document.createElement("form");
	    newForm.setAttribute("method", "POST");
	    newForm.setAttribute("action", "../buy/directBuyForm.jsp")

	    // input 태그 생성 & 속성부여
	    var inputProCode = document.createElement("input");
	    inputProCode.setAttribute("type", "text");
	    inputProCode.setAttribute("name", "proCode");
	    inputProCode.setAttribute("value", $("#proCode").val());
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputProCode);

	    var inputProName = document.createElement("input");
	    inputProName.setAttribute("type", "text");
	    inputProName.setAttribute("name", "proName");
	    inputProName.setAttribute("value",$("#proName").val());
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputProName);

	    var inputPrice = document.createElement("input");
	    inputPrice.setAttribute("type", "text");
	    inputPrice.setAttribute("name", "price");
	    inputPrice.setAttribute("value", $("#proPrice").val());
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputPrice);

	    var inputProImg = document.createElement("input");
	    inputProImg.setAttribute("type", "text");
	    inputProImg.setAttribute("name", "proImg");
	    inputProImg.setAttribute("value", $("#proImg").val());
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputProImg);

	    var inputProBuyCount = document.createElement("input");
	    inputProBuyCount.setAttribute("type", "text");
	    inputProBuyCount.setAttribute("name", "buyCount");
	    inputProBuyCount.setAttribute("value", $("#proBuyCount").val());
	    // input을 form의 자식태그로 붙이기
	    newForm.appendChild(inputProBuyCount);

	    // form을 body태그의 자식태그로 붙이기
	    document.body.appendChild(newForm);
	    newForm.submit();
	}
</script>
</body>
<script type="text/javascript" src="js/modify.js"></script>
</html>