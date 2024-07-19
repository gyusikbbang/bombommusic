<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="LoginDB.LoginDataBean" %>
<%@ page import="LoginDB.LoginDBBean" %>
 

<%
String memberId = request.getParameter("memberId");
String loginNum = request.getParameter("loginNum");
String typename = request.getParameter("typename");


try{
	LoginDBBean loginProcess = LoginDBBean.getInstance();
	LoginDataBean member =  loginProcess.getMember(memberId); 
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
  <a href="memberList.jsp?loginNum=<%=loginNum%>">목록으로</a>

<div id="inputform">
  <div class="panel shadow1 animated fadeInUp animate1" >
<form method="post"  class="input-form " name="writeform" 
   action="/BomBom/manager/productProcess/memberUpdate_Pro.jsp" target="_blank" >
   <h1  id="title-input"><%=member.getMemberName()%> 수정</h1>
             <h5>수정하실 <%=member.getMemberName()%> 정보를 수정해주세요</h5>
             <br>
             <h1 class="animated fadeInUp animate1 hidden" id="title-signup"></h1>
      <fieldset id="input-fieldset">
      

 
      
   <script src= "../js/file.js"></script>
   
   
   
   
   
   
   
   
   
   <%
    if (loginNum.equals("2")) {
    	
    
   
   
   
    	 %>
   
      
   
   <input type="text" class="input animated fadeInUp animate3" readonly value="이름">
<input type="text" class="input animated fadeInUp animate3" name="memberName" value="<%=member.getMemberName()%>">
  <input type="text" class="input animated fadeInUp animate3" readonly value="패스워드">
<input type="text" class="input animated fadeInUp animate3"  readonly name="memberPw" value="<%=member.getMemberPw()%>">
 <input type="text" class="input animated fadeInUp animate3" readonly value="이메일">
<input type="text" class="input animated fadeInUp animate3" name="memberEmail" value="<%=member.getMemberEmail()%>">
<input type="text" class="input animated fadeInUp animate3" readonly value="주소">
<input type="text" class="input animated fadeInUp animate3" name="memberAddr" value="<%=member.getMemberAddr()%>">
<input type="text" class="input animated fadeInUp animate3" readonly value="휴대폰 번호">
<input type="text" class="input animated fadeInUp animate3" name="memberPhone" value="<%=member.getMemberPhone()%>">

<input type="text" class="input animated fadeInUp animate3" readonly value="로그인 타입">
<input type="text" class="input animated fadeInUp animate3"  readonly value="<%=typename%>">
        <input type="hidden" class="input animated fadeInUp animate3" name="memberId" value="<%=memberId%>">
      
 <input type="text" class="input animated fadeInUp animate3" name="loginNum" readonly value="<%=loginNum%>">
  
      
          
          <input type="submit" class="input_form button animated fadeInUp animate4" action="/BomBom/manager/productProcess/memberUpdate_Pro.jsp"  value="수정완료">
      </fieldset>
      
      
        
</form>  

</div>
</div>
  
  <% }else {%>
  

   
   
  <input type="text" class="input animated fadeInUp animate3" readonly value="이름">
<input type="text" class="input animated fadeInUp animate3" name="memberName" value="<%=member.getMemberName()%>">
  <input type="text" class="input animated fadeInUp animate3" readonly value="패스워드">
<input type="text" class="input animated fadeInUp animate3"   name="memberPw" value="<%=member.getMemberPw()%>">
 <input type="text" class="input animated fadeInUp animate3" readonly value="이메일">
<input type="text" class="input animated fadeInUp animate3" name="memberEmail" value="<%=member.getMemberEmail()%>">
<input type="text" class="input animated fadeInUp animate3" readonly value="주소">
<input type="text" class="input animated fadeInUp animate3" name="memberAddr" value="<%=member.getMemberAddr()%>">
<input type="text" class="input animated fadeInUp animate3" readonly value="휴대폰 번호">
<input type="text" class="input animated fadeInUp animate3" name="memberPhone" value="<%=member.getMemberPhone()%>">

<input type="text" class="input animated fadeInUp animate3" readonly value="로그인 타입">
<input type="text" class="input animated fadeInUp animate3"  readonly value="<%=typename%>">
        <input type="hidden" class="input animated fadeInUp animate3" name="memberId" value="<%=memberId%>">
      
 <input type="text" class="input animated fadeInUp animate3" name="loginNum" readonly value="<%=loginNum%>">
  
      
          
          <input type="submit" class="input_form button animated fadeInUp animate4" action="/BomBom/manager/productProcess/memberUpdate_Pro.jsp"  value="수정완료">
      </fieldset>
      
      
        
</form>  

</div>
</div>
<% }%>

<%
}catch(Exception e){
	e.printStackTrace();
}%>         
</body>
</html>

