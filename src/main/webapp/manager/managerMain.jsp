<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ page import="Manager.ShopProductDBBean"  %>   
<%


request.setCharacterEncoding("euc-kr");


   String name = "";
   String managerId = "";
   try{
	   managerId = (String)session.getAttribute("managerId");
	   name = (String)session.getAttribute("name");
	   if(managerId==null || managerId.equals("")){
        response.sendRedirect("login/managerlogin.html");
	   }else{
%>




<!DOCTYPE html>
<html lang="en">

<style>
  
  td img {
            width: 90px;
            height: 90px;
        }

#demotext {
  color: #FFFFFF;

text-shadow: 0 1px 0 #CCCCCC, 0 2px 0 #c9c9c9, 0 3px 0 #bbb, 0 4px 0 #b9b9b9, 0 5px 0 #aaa, 0 6px 1px rgba(0,0,0,.1), 0 0 5px rgba(0,0,0,.1), 0 1px 3px rgba(0,0,0,.3), 0 3px 5px rgba(0,0,0,.2), 0 5px 10px rgba(0,0,0,.25), 0 10px 10px rgba(0,0,0,.2), 0 20px 20px rgba(0,0,0,.15);

}

  .animate1 , .animate2 , .animate3 , .animate4{
    -webkit-animation-duration: 2s;
    -moz-animation-duration: 2s;
}

.animate1
{
    -webkit-animation-delay: 0.2s;
    -moz-animation-delay: 0.2s;
}

.animate2
{
    -webkit-animation-delay: 0.7s;
    -moz-animation-delay: 0.7s;
}

.animate3
{
    -webkit-animation-delay: 1.1s;
    -moz-animation-delay: 1.1s;
}

.animate4
{
    -webkit-animation-delay: 1.5s;
    -moz-animation-delay: 1.5s;
}

.animate5
{
    -webkit-animation-delay: 2.2s;
    -moz-animation-delay: 2.2s;
}

@-webkit-keyframes fadeInUp {
  from {
    opacity: 0;
    -webkit-transform: translate3d(0, 100%, 0);
    transform: translate3d(0, 100%, 0);
  }

  to {
    opacity: 1;
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
  }
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    -webkit-transform: translate3d(0, 100%, 0);
    transform: translate3d(0, 100%, 0);
  }

  to {
    opacity: 1;
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
  }
}
</style>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관리자 페이지</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

  <link href='https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css' rel='stylesheet'>
  <link rel="stylesheet" href="./css/sidebar.css">
  <link rel="stylesheet" href="./css/table.css">
  <style>

#ic {
  font-variation-settings:
  'FILL' 1
  
}

.page_wrap {
	text-align:center;
	font-size:0;
 }
.page_nation {
	display:inline-block;
}
.page_nation .none {
	display:none;
}
.page_nation a {
	display:block;
	margin:0 3px;
	float:left;
	border:1px solid #e6e6e6;
	width:28px;
	height:28px;
	line-height:28px;
	text-align:center;
	background-color:#fff;
	font-size:13px;
	color:#999999;
	text-decoration:none;
}
.page_nation .arrow {
	border:1px solid #ccc;
}
.page_nation .pprev {
	background:#f8f8f8 url('img/page_pprev.png') no-repeat center center;
	margin-left:0;
}
.page_nation .prev {
	background:#f8f8f8 url('img/page_prev.png') no-repeat center center;
	margin-right:7px;
}
.page_nation .next {
	background:#f8f8f8 url('img/page_next.png') no-repeat center center;
	margin-left:7px;
}
.page_nation .nnext {
	background:#f8f8f8 url('img/page_nnext.png') no-repeat center center;
	margin-right:0;
}
.page_nation a.active {
	background-color:#42454c;
	color:#fff;
	border:1px solid #42454c;
}
</style>


    
</head>

<body>
  <nav class="bar">
    <div class="sidebar-top">
      <span class="shrink-btn">
        <i class='bx bx-chevron-left'></i>
      </span>
      <img src="./img/logo.png" class="logo" alt="">
      <h3 class="hide">관리자</h3>
    </div>

    <div class="search">
      <i class='bx bx-search'></i>
      <input type="text" class="hide" placeholder="Quick Search ...">
    </div>

    <div class="sidebar-links">
      <ul>
        <div class="active-tab"></div>
        <li class="tooltip-element" data-tooltip="0" onclick=Viewhome()>
          <a href="#" class="active" data-active="0"  >
            <div class="icon">
              
              
              <span class="material-symbols-outlined">
                home_work
                </span>
                <span class="material-symbols-outlined" id="ic">
                  home_work
                  </span>
              
            </div>
            <p class="link hide" >관리자 홈</p>
          </a>
        </li>
        <li class="tooltip-element" data-tooltip="1" onclick="ViewinsertForm()">
          <a href="#" data-active="1">
            <div class="icon">
              <span class="material-symbols-outlined">
                edit_square
                </span>
                <span class="material-symbols-outlined" id="ic">
                  edit_square
                  </span>
            </div>
            <p class="link hide">상품 등록</p>
          </a>
        </li>
        <li class="tooltip-element" data-tooltip="2"  onclick="ViewUpdateList();" >
          <a href="#" data-active="2">
            <div class="icon">
              <span class="material-symbols-outlined">
                edit_document
                </span>
                <span class="material-symbols-outlined" id="ic">
                  edit_document
                  </span>
            </div>
            <p class="link hide">상품 수정</p>
          </a>
        </li>
        <li class="tooltip-element" data-tooltip="3" onclick="VieworderList()">
          <a href="#" data-active="3">
            <div class="icon">
              <span class="material-symbols-outlined">
                task
                </span>
                <span class="material-symbols-outlined" id ="ic">
                  task
                  </span>
            </div>
            <p class="link hide">주문 보기</p>
          </a>
        </li>
        <div class="tooltip">
          <span class="show">관리자 홈

          </span>
          <span>상품 등록</span>
          <span>상품 수정</span>
          <span>리뷰 관리</span>
        </div>
      </ul>

      <h4 class="hide">회원 관리</h4>

      <ul>
        <li class="tooltip-element" data-tooltip="0"  onclick=ViewMemberList()>
          <a href="#" data-active="4">
            <div class="icon">
              <span class="material-symbols-outlined">
                manage_accounts
                </span>
                <span class="material-symbols-outlined" id ="ic">
                  manage_accounts
                  </span>
            </div>
            <p class="link hide">회원 관리</p>
          </a>
        </li>
        
        <li class="tooltip-element" data-tooltip="1" >
          <a href="MdmanagerMain.jsp"" data-active="5">
            <div class="icon">
              <span class="material-symbols-outlined">
				person_search
				</span>
             <span class="material-symbols-outlined" id ="ic">
				person_search
				</span>
            </div>
            <p class="link hide">md 관리자 페이지</p>
          </a>
        </li>
        <li class="tooltip-element" data-tooltip="2">
          <a href="#" data-active="6">
            <div class="icon">
              <span class="material-symbols-outlined" >
				settings
				</span>
              <span class="material-symbols-outlined" >
				settings
				</span>
            </div>
            <span class="link hide">설정</span>
          </a>
        </li>
        <div class="tooltip">
          <span class="show">회원 관리</span>
          <span>md 관리자 페이지</span>
          <span>Settings</span>
        </div>
      </ul>
    </div>

    <div class="sidebar-footer">
      <a href="#" class="account tooltip-element" data-tooltip="0">
        <i class='bx bx-user'></i>
      </a>
      <div class="admin-user tooltip-element" data-tooltip="1">
        <div class="admin-profile hide">
          <img src="./img/face-1.png" alt="">
          
          <div class="admin-info">
            <h3><%=name%></h3>
            <h5>Admin</h5>
          </div>
        </div>
        <a href="./login/managerLogout.jsp" class="log-out">
          <i class='bx bx-log-out'></i>
        </a>
      </div>
      <div class="tooltip">
        <span class="show"><%=name%></span>
        <span>Logout</span>
      </div>
    </div>
  </nav>

<div id="info" style="display: block;" >
  <main >
    <h1 class="animated fadeInUp animate1" id="demotext"  >관리자 홈</h1>
    <p class="text animated fadeInUp animate1"  id="demotext">
      관리자 페이지 입니다 왼쪽 사이드 바를 이용하여 상품 등록 , 상품 수정 , 상품 보기를 눌러주세요 
      회원정보를 관리 하시려면 회원 관리 칸을 사용해주세요
    </p>
    
    
  </main>
</div>
<script src="./js/sidebar.js"></script>



<div class="productinsert" id="productinsert" style="display:none" >
  
  <%@ include file="./productProcess/product_Form.jsp" %>
</div>
 <div class="productupdate" id="productupdate" style="display:none">
 
   <jsp:include page="./productProcess/productList.jsp?proCate=all"/>
  </div>
  
   <div class="memberList" id="memberList" style="display:none">
 
   <jsp:include page="./productProcess/memberList.jsp?loginNum=all"/>
  </div>
  
  <div class="orderList" id="orderList" style="display:none">
 
   <jsp:include page="./orderedProduct/orderedList.jsp"/>
  </div>
</body>

</html>
<% 
	   }
    }catch(Exception e){
		e.printStackTrace();
	}
%>