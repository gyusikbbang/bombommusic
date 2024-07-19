<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="Manager.ShopProductDataBean" %>
<%@ page import="Manager.ShopProductDBBean" %>

 

<%
int ProCode = Integer.parseInt(request.getParameter("ProCode"));
String proCate = request.getParameter("proCate");
try{
	ShopProductDBBean productProcess = ShopProductDBBean.getInstance();
	ShopProductDataBean product =  productProcess.getProduct(ProCode); 
%>
<html>
<head>
<title>상품수정</title>
<link rel="stylesheet" href="../css/form.css">
<link rel="stylesheet" href="../css/form.scss">

<script type="text/javascript" src="./images/jquery-1.7.1.min.js"></script>

</head>
<body>

  <a href="../managerMain.jsp"> 관리자 메인으로</a> &nbsp;
  <a href="productList.jsp?proCate=<%=proCate%>">목록으로</a>

<div id="inputform">
  <div class="panell shadow1 animated fadeInUp animate1" >
<form method="post"  class="input-form " name="writeform" 
   action="/BomBom/manager/productProcess/productUpdate_Pro.jsp" target="_blank" enctype="multipart/form-data">
   <h1  id="title-input">상품 수정</h1>
             <h5>수정하실 상품을 수정해주세요</h5>
             <br>
             <h1 class="animated fadeInUp animate1 hidden" id="title-signup"></h1>
      <fieldset id="input-fieldset">
      
      <select class= "select" name="ProCate">

			<option value="100" <% if (product.getProCate().equals("100")) { %>selected<% } %>>피아노</option>
<option value="200" <% if (product.getProCate().equals("200")) { %>selected<% } %>>바이올린</option>
<option value="210" <% if (product.getProCate().equals("210")) { %>selected<% } %>>비올라</option>
<option value="220" <% if (product.getProCate().equals("220")) { %>selected<% } %>>첼로</option>
<option value="230" <% if (product.getProCate().equals("230")) { %>selected<% } %>>더블베이스</option>
<option value="300" <% if (product.getProCate().equals("300")) { %>selected<% } %>>플룻</option>
<option value="310" <% if (product.getProCate().equals("310")) { %>selected<% } %>>오보에</option>
<option value="320" <% if (product.getProCate().equals("320")) { %>selected<% } %>>바순</option>
<option value="330" <% if (product.getProCate().equals("330")) { %>selected<% } %>>클라리넷</option>
<option value="400" <% if (product.getProCate().equals("400")) { %>selected<% } %>>호른</option>
<option value="410" <% if (product.getProCate().equals("410")) { %>selected<% } %>>트럼펫</option>
<option value="420" <% if (product.getProCate().equals("420")) { %>selected<% } %>>트럼본</option>
<option value="430" <% if (product.getProCate().equals("430")) { %>selected<% } %>>튜바</option>
<option value="500" <% if (product.getProCate().equals("500")) { %>selected<% } %>>심벌즈</option>
<option value="510" <% if (product.getProCate().equals("510")) { %>selected<% } %>>팀파니</option>
<option value="520" <% if (product.getProCate().equals("520")) { %>selected<% } %>>마림바</option>


					</select> 
					
				  <select class= "select" name="ProLabel">

						  <option value="워너 클래식" 
             <%if (product.getProLabel().equals("워너 클래식")) {%>selected<%} %>
              >워너 클래식</option>
					  <option value="유니버셜 클래식" 
             <%if (product.getProLabel().equals("유니버셜 클래식")) {%>selected<%} %>
              >유니버셜 클래식</option>
					  <option value="소니 클래식" 
             <%if (product.getProLabel().equals("소니 클래식")) {%>selected<%} %>
              >소니 클래식</option>
						  <option value="낙소스" 
             <%if (product.getProLabel().equals("낙소스")) {%>selected<%} %>
              >낙소스</option>

					</select>
					<select class= "select" name="Concerto">
					
					
					
					
								  <option value="true" 
             <%if (product.isConcerto()==true) {%>selected<%} %>
              >협주곡 O</option>
							  <option value="false" 
             <%if  (product.isConcerto()==false)  {%>selected<%} %>
              >협주곡 X</option>
						

					</select>
 
      
   <script src= "../js/file.js"></script>
        <input type="text"  class="input animated fadeInUp animate3" maxlength="50" name="ProName"  
            value="<%=product.getProName() %>">
        <input type="hidden" class="input animated fadeInUp animate3" name="ProCode" value="<%=ProCode%>">
      
 
   
        <input type="text" class="input animated fadeInUp animate3" size="10" maxlength="9" name="Price" 
          value="<%=product.getPrice() %>">
 

        <input type="file"  onchange="fileCheck(this)" class="input animated fadeInUp animate3 " name="ProImg1" accept="image/gif, image/jpeg, image/png" placeholder="<%=product.getProImg1() %>"
        value="<%=product.getProImg1() %>">
    <input type="text"   class="input animated fadeInUp animate3 " placeholder="이전에 선택한 상품이미지1:<%=product.getProImg1() %>" readonly>
   
    
        <input type="file" onchange="fileCheck(this)" class="input animated fadeInUp animate3 " name="ProImg2"   accept="image/gif, image/jpeg, image/pngp"laceholder="<%=product.getProImg2() %>">
        <input type="text"   class="input animated fadeInUp animate3 " placeholder="이전에 선택한 상품이미지2:<%=product.getProImg2() %>"readonly>

        <input type="file"   onchange="fileCheck(this)" class="input animated fadeInUp animate3 " name="ProImg3"  accept="image/gif, image/jpeg, image/png" placeholder="<%=product.getProImg3() %>">
        <input type="text"   class="input animated fadeInUp animate3 " placeholder="이전에 선택한 상품이미지3:<%=product.getProImg3() %>" readonly>
    
  
  
         <input type="file"  onchange="fileCheckaudio(this)" class="input animated fadeInUp animate3 " name="audio" accept="audio/*" placeholder="<%=product.getAudio() %>"
        value="<%=product.getAudio() %>">
    <input type="text"   class="input animated fadeInUp animate3 " placeholder="이전에 선택한 오디오:<%=product.getAudio() %>" readonly>
 
  
        <input type="text" class="input animated fadeInUp animate3" size="20" maxlength="30" name="ProInfo" 
          value="<%=product.getProInfo() %>">
  
    <input class="input " name="discount_rate"
						type="text" required placeholder="할인율" value="<%=product.getDiscount_rate() %>"> 
        <input type="text" class="input animated fadeInUp animate3" size="5" maxlength="2" name="ProStock" 
          value="<%=product.getProStock() %>">
          <input type="submit" class="input_form button animated fadeInUp animate4" action="/BomBom/manager/productProcess/productUpdate_Pro.jsp"  value="입력완료">
      </fieldset>
      
      
        
</form>  

</div>
</div>


<%
}catch(Exception e){
	e.printStackTrace();
}%>         
</body>
</html>

