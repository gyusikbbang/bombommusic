<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="LoginDB.LoginDBBean" %>
<% 
	String id = "";
	id = (String)session.getAttribute("memberId");
	String proName = "";
	if (request.getParameter("proName") != null) proName = request.getParameter("proName");
	
	LoginDBBean loginProcess = LoginDBBean.getInstance();
    String name = loginProcess.userName(id);
%>
<!DOCTYPE html>
<html>	
<head>
<meta charset="UTF-8">
<title>BomBom</title>
<link href="css/style.css" rel="stylesheet">
<link href="css/mic.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
    <div class="page-top">
        <!--메인 헤더-->
        <div class="header">
            <h1><a href="/BomBom/main/main.jsp">
              BomBom</a></h1>
            <div class="search">
                <input type="text" id="searchText" value="<%=proName%>" placeholder="검색어 입력" onkeyup="enterkey();">
                <a href="#" onclick="fnSearch('all','all');"><img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></a>
            </div>
            <div class="mic-menu">
                <span id ="mic"class="material-symbols-outlined" style="position: relative;" onclick = "speechsearch(); splay();">mic</span> 
            </div>
            <div class="micmodal">
                <div class="micmodal_bg"></div>
                <div class="micmodal_wrap">
                    <div class="micmodal_x">x</div>
                    <div class="hi">
                        <p id ="micstatus" ></p>
                    </div>
                    <div class="img">
                        <div class="ig" id="micstart" style="display:block" onclick="stop(); mplay();">
                            <img src="../imageFile/mic s.png" >
                        </div>   
                        <div class="igg"  id ="micnone" style="display:none" onclick="speechsearch(); splay();">
                            <img src="../imageFile/mic n.png"  >
                        </div>   
                    </div>
                </div>
            </div>
            <div class="nav">
                <ul style="margin-top: 10px;">
                <%  
                    try{ 
                        
                        if(id == null || id.equals("")){%>                    
                    <li><a href="../login/login.jsp">
                      <img src="../imageFile/free-icon-person-2815428.png" style="width: 35px; position: relative; top: -7px;">
                    </a></li>
                    <li><a href="../login/login.jsp">
                      <img src="../imageFile/free-icon-cart-726496.png" style="width: 35px; position: relative; top: -7px;">
                    </a></li>
                <%}else{%> 
                    <li><b ><%=name%></b></li>
                    <li><a  href="../login/logout.jsp">로그아웃</a></li>
                    <li><a href="../mypage/mypage2.jsp">
                      <img src="../imageFile/free-icon-user-account-8344923.png" style="width: 35px; position: relative; top: -7px;">
                    </a></li>
                    <li><a href="../mypage/mypage_.jsp">
                      <img src="../imageFile/free-icon-cart-726496.png" style="width: 35px; position: relative; top: -7px;">
                    </a></li>
                <%}
                }catch(NullPointerException e){
                    e.printStackTrace();
                }%>                  
                    
                </ul>
            </div>
        </div>
        <!--카테고리-->
        <div class="header-category">
            <div class="nav">
                <ul>
                    <div class="category-dropdown">
                    <input id="category-check" type="checkbox"/>
                        <label for="category-check" class="category-btn">
                        	<span class="material-symbols-outlined" style="font-size: 45px; cursor: pointer;">menu</span>
                        </label>
                        <div class="all-category">
                            <div class="category-title">
                                <h2 style="font-size:30px; font:revert; margin-top:30px">
                                  카테고리 전체보기</h2>
                            </div>
                            <ul class="all-content1">
                                <li class="content-title">
                                  <img src="../imageFile/piano.png" style="width: 35px; position: relative; top: -7px;">
                                  건반악기
                                </li>
                                <li><a href="../proList/proList.jsp?proCate=100">피아노</a></li>
                                <li><a href="../proList/proList.jsp?proCate=110">오르간</a></li>
                                <li><a href="../proList/proList.jsp?proCate=120">하프시코드</a></li>
                            </ul>
                            <ul class="all-content1">
                                <li class="content-title">
                                  <img src="../imageFile/violin.png" style="width: 35px; position: relative; top: -7px;">
                                  현악기</li>
                                <li><a href="../proList/proList.jsp?proCate=200">바이올린</a></li>
                                <li><a href="../proList/proList.jsp?proCate=210">비올라</a></li>
                                <li><a href="../proList/proList.jsp?proCate=220">첼로</a></li>
                                <li><a href="../proList/proList.jsp?proCate=230">더블베이스</a></li>
								<li><a href="../proList/proList.jsp?proCate=240">하프</a></li>
                            </ul>
                            <ul class="all-content1">
                                <li class="content-title">
                                  <img src="../imageFile/1639359.png" style="width: 35px; position: relative; top: -7px;">
                                  목관악기</li>
                                <li><a href="../proList/proList.jsp?proCate=300">플루트</a></li>
                                <li><a href="../proList/proList.jsp?proCate=310">오보에</a></li>
                                <li><a href="../proList/proList.jsp?proCate=320">바순</a></li>
                                <li><a href="../proList/proList.jsp?proCate=330">클라리넷</a></li>
                            </ul>
                            <ul class="all-content1">
                                <li class="content-title"><img src="../imageFile/1969354.png" style="width: 35px; position: relative; top: -7px;">
                                  금관악기</li>
                                <li><a href="../proList/proList.jsp?proCate=400">호른</a></li>
                                <li><a href="../proList/proList.jsp?proCate=410">트럼펫</a></li>
                                <li><a href="../proList/proList.jsp?proCate=420">트럼본</a></li>
                                <li><a href="../proList/proList.jsp?proCate=430">튜바</a></li>
                            </ul>
                            <ul class="all-content1">
                                <li class="content-title"><img src="../imageFile/836938.png" style="width: 35px; position: relative; top: -7px;">
                                  타악기</li>
                                <li><a href="../proList/proList.jsp?proCate=500">심벌즈</a></li>
                                <li><a href="../proList/proList.jsp?proCate=510">팀파니</a></li>
                                <li><a href="../proList/proList.jsp?proCate=520">마림바</a></li>
                            </ul>
                            <ul class="all-content2">
                                <li class="content-title"><img src="../imageFile/1844064.png" style="width: 35px; position: relative; top: -7px;">
                                  작곡가</li>
                                <li><a href="../proList/proList.jsp?proName=바흐">바흐</a></li>
                                <li><a href="../proList/proList.jsp?proName=헨델">헨델</a></li>
                                <li><a href="../proList/proList.jsp?proName=비발디">비발디</a></li>
                                <li><a href="../proList/proList.jsp?proName=모차르트">모차르트</a></li>
                                <li><a href="../proList/proList.jsp?proName=하이든">하이든</a></li>
                            </ul>
                            <ul class="all-content2" style="margin-top:40px; margin-left: -50px;">
                                <li><a href="../proList/proList.jsp?proName=베토벤">베토벤</a></li>
                                <li><a href="../proList/proList.jsp?proName=체르니">체르니</a></li>
                                <li><a href="../proList/proList.jsp?proName=클레멘티">클레멘티</a></li>
                                <li><a href="../proList/proList.jsp?proName=쇼팽">쇼팽</a></li>
                                <li><a href="../proList/proList.jsp?proName=리스트">리스트</a></li>
                                <li><a href="../proList/proList.jsp?proName=브람스">브람스</a></li>
                            </ul>
                            <ul class="all-content2" style="margin-top:40px; margin-left: -50px;">
                                <li><a href="../proList/proList.jsp?proName=슈베르트">슈베르트</a></li>
                                <li><a href="../proList/proList.jsp?proName=차이콥스키">차이콥스키</a></li>
                                <li><a href="../proList/proList.jsp?proName=라흐마니노프">라흐마니노프</a></li>
                                <li><a href="../proList/proList.jsp?proName=슈만">슈만</a></li>
                                <li><a href="../proList/proList.jsp?proName=브루크너">브루크너</a></li>
                                <li><a href="../proList/proList.jsp?proName=멘델스존">멘델스존</a></li>
                            </ul>
                            <ul class="all-content2" style="margin-top:40px; margin-left: -50px;">
                                <li><a href="../proList/proList.jsp?proName=생상스">생상스</a></li>
                                <li><a href="../proList/proList.jsp?proName=파가니니">파가니니</a></li>
                                <li><a href="../proList/proList.jsp?proName=시벨리우스">시벨리우스</a></li>
                                <li><a href="../proList/proList.jsp?proName=드뷔시">드뷔시</a></li>
                               	<li><a href="../proList/proList.jsp?proName=말러">말러</a></li>
                                <li><a href="../proList/proList.jsp?proName=루빈스타인">루빈스타인</a></li>
                            </ul>
                            <ul class="all-content2">
                                <li class="content-title"><img src="../imageFile/123511.png" style="width: 30px; position: relative; top: -7px;">
                                  MY메뉴</li>
                                <li>회원정보</li>
                                <li>주문내역</li>
                                <li>장바구니</li>
                                <li>내가 쓴 리뷰</li>
                            </ul>
                        </div>
                    </div>
                    <li class="menu"><a href="../proList/proList.jsp">
                    <img style="width:27px; margin-right:6px; top:-6px; position:relative"
                    src="//image.kyobobook.co.kr/newimages/giftshop_new/resources/images/pc/layout/ico_main_menu_music.svg">
                    	LP/음반</a>
                    </li>
                    <li class="menu"><a href="../proChart/proChart.jsp">
                    <img style="width:35px; margin-right:6px; top:-6px; position: relative;"
                    src="../imageFile/icons8-heart.gif">
                    인기앨범</a></li>
                    <li class="menu"><a href="../discount/discount.jsp; position: relative">
                      <img style="width:35px; top:-6px; position: relative"
                    src="../imageFile/animat-rocket-color.gif">
                      이벤트특가</a></li>
                    <li class="menu"><a href="../mdPick/mdPick.jsp">
                      <img style="width:35px; top:-6px; position: relative"
                    src="../imageFile/animat-pencil-color.gif">
                      MD추천</a></li>
                    <li class="menu"><a href="../recommend/recommend.jsp">
                      <img style="width:35px;  top:-6px; position: relative"
                    src="../imageFile/animat-search-color.gif">
                      취향의발견</a></li>
                </ul>
            </div>
        </div>
    </div>
</body>
<!-- 폰트어썸 불러오기 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link rel="stylesheet" href="js/mic.js">
<script>
    
let micastart = new Audio();
micastart.src = '켜지는효과음.mp3';

let micastop = new Audio();
micastop.src = '꺼지는효과음.mp3';

let micout = new Audio(); 
micout.src = '나가는효과.mp3';

micout.volume = 0.5;

const micmodal_wrap = document.querySelector('.micmodal_wrap')
const micmodal_bg = document.querySelector('.micmodal_bg')

//Show micmodal
document.querySelector('#mic').addEventListener('click', () => {
  open()
})

//Hide micmodal
document.querySelector('.micmodal_x').addEventListener('click', () => {
  close()
})

//Hide micmodal
window.addEventListener('click', (e) => {
  e.target === micmodal_bg ?  close() : false
})
function close(){
  micmodal_wrap.classList.remove('show-micmodal');
  micmodal_bg.classList.remove('show-micmodal');
  stop();
  outplay();

}

function mplay() {
  if (micout.playing) 
    micout.pause();


  if (micastart.playing) 
    micastart.pause();  

  if (micastop.playing) 
    micastop.pause();
  else 
    micastop.play();
}

function outplay() {
  if (micastop.playing) 
    micastop.pause();

  if (micastart.playing) 
    micastart.pause();

  if (micout.playing) 
    micout.pause();
  else 
    micout.play();
}

function splay() {
  if (micastop.playing) 
    micastop.pause();

  if (micastop.playing) 
    micastop.pause();

  if (micastart.playing) 
    micastart.pause();
  else 
    micastart.play();

}

function open(){
  micmodal_wrap.classList.add('show-micmodal')
  micmodal_bg.classList.add('show-micmodal')
}

      var micstatus = document.querySelector("#micstatus");
      const micstart = document.getElementById('micstart');
      const micnone = document.getElementById('micnone');
        var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition;
        var SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList;
        var SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent;
        var isRecognizing = false;

      if ('SpeechRecognition' in window) {
         // Speech recognition support. Talk to your apps!
          console.log("음성인식을 지원하는 브라우저입니다.")
      }

      try {
            var speech = new (window.SpeechRecognition || window.webkitSpeechRecognition || window.mozSpeechRecognition || window.msSpeechRecognition)();
        } catch(e){
            console.error(e);
        }
        var result;
        var proCate = "all";

        var speechRecognitionList = new SpeechGrammarList();
        speech.lang = 'ko-KR'; //선택하게 해줘야 할듯 .
        speech.grammars = speechRecognitionList;

        speech.interimResults = false; // true: 중간 결과를 반환, false: 최종 결과만 반환
        speech.continious = true; // true: 음성인식을 계속해서 수행, false: 음성인식을 한번만 수행
        speech.maxAlternatives = 20000;


        function stop(){
          speech.stop();
            micstatus.innerHTML = "음성이 종료되었습니다 마이크를 다시 활성화 해주세요";

            isRecognizing = false;
            if (micstart.style.display === 'block') {
              micstart.style.display = 'none';
              }


            if (micnone.style.display === 'none') {
              micnone.style.display = 'block';
          } 
            
        }
          
    

       function speechsearch(){
          if (micnone.style.display === 'block') {
             micnone.style.display = 'none';
              }
         
     
          if (micstart.style.display === 'none') {
             micstart.style.display = 'block';
          }



          speech.start();
          setTimeout(function() {
              stop();
           }, 13000);
           isRecognizing = true;

           speech.onstart = function(){
              
               micstatus.innerHTML = "듣는 중 입니다...";
               
           };
        

           speech.onresult = function(event) {
             result = event.results[0][0].transcript.toLowerCase();            
             if (result == null) {
               speech.stop();
             } 
    
          
            micstatus.innerHTML = result + " 을 검색합니다.";
            speech.stop();
         

          setTimeout(function() {
           location.replace("../proList/proList.jsp?proName="+result+"&&proCate="+proCate);
         }, 3000);
             
         
            
         };
   

       
            speech.onspeechstart =function(event){
            micstatus.innerHTML = "소리감지...";
         };
  
         
         


       }
</script>
</html>