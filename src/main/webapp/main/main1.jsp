%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>BomBom</title>
<link href="css/style.css" rel="stylesheet">
<link href="css/imageBanner.css" rel="stylesheet">
<link href="css/chart.css" rel="stylesheet">
<link href="css/md-pick.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <!--인포-->
        <div class="header-info">     
            <a href="#">고객센터</a>
        </div>
        <!--메인 헤더-->
        <div class="header">
            <h1><a href="main.html">BomBom</a></h1>
            <div class="search">
                <input type="text" placeholder="검색어 입력">
                <img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
            </div>
            <div class="nav">
                <ul>
                    <li><a href="#">로그인</a></li>
                    <li><a href="#">장바구니</a></li>
                </ul>
            </div>
        </div>
        <!--카테고리-->
        <div class="header-category">
            <div type="button" class="category-btn">
                <span class="hidden">전체메뉴</span>
            </div>
            <div class="nav">
                <ul>
                    <li><a href="#">악기별</a></li>
                    <li><a href="#">협주곡</a></li>
                    <li><a href="#">교향곡</a></li>
                    <li><a href="#">실내악</a></li>
                    <li><a href="#">커뮤니티</a></li>
                </ul>
            </div>
        </div>
        <!--이미지 슬라이드-->
        <div class="carousel-1" data-carousel-1-autoplay-status="Y">
            <ul class="owl-carousel owl-theme">
                <li class="item"><img src="images\room.jpg"></li>
                <li class="item"><img src="images\room.jpg"></li>
                <li class="item"><img src="images\room.jpg"></li>
                <li class="item"><img src="images\room.jpg"></li>
            </ul>
            <!-- <div class="play">시작</div>
            <div class="stop">정지</div> -->
        </div>
        <!--앨범 순위-->
        <div class="chart-section">
            <div class="chart-text">
                <h1>BomBom 인기앨범 순위<img src="images\thumb-up.png"><!--제작자: Dooder - Flaticon--></h1>
                <h2>순위설명</h2>
            </div>
            <ul class="chart">
                <!--1위-->
                <li>
                    <div class="chart-img">
                        <img src="images\Beethoven.png">
                    </div>
                    <div class="contents1">1위 앨범</div>
                    <div class="contents2">루트비히 판 베토벤 루트비히 판 베토벤 루트비히 판 베토벤</div>
                    <div type="button" class="more">더보기</div>
                </li>
                <!--2위-->
                <li>
                    <div class="chart-img">
                        <img src="images\Chopin.png">
                    </div>
                    <div class="contents1">2위 앨범</div>
                    <div class="contents2">프리데리크 쇼팽 프리데리크 쇼팽 프리데리크 쇼팽 프리데리크 쇼팽</div>
                    <div type="button" class="more">더보기</div>
                </li>
                <!--3위-->
                <li>
                    <div class="chart-img">
                        <a><img src="images\Beethoven.png"></a>
                    </div>
                    <div class="chart-detail">
                        <div class="contents1">3위 앨범</div>
                        <div class="contents2">루트비히 판 베토벤 루트비히 판 베토벤 루트비히 판 베토벤</div>
                        <div type="button" class="more">더보기</div>
                    </div>
                </li>
                <!--4위-->
                <li>
                    <div class="chart-img">
                        <img src="images\Chopin.png">
                    </div>
                    <div class="contents1">4위 앨범</div>
                    <div class="contents2">프리데리크 쇼팽 프리데리크 쇼팽 프리데리크 쇼팽 프리데리크 쇼팽</div>
                    <div class="more">더보기</div>
                </li>
            </ul>
        </div>
        <!--md-pick-->
        <div class="recommand-section">
            <div class="md-image">
                <img src=
                    "//image.kyobobook.co.kr/newimages/giftshop_new/resources/images/pc/main/tit_wel_md_pick.svg" 
                        alt="MD PICK">
            </div>
            <div class="md-pick">
                <ul class="slides">
                    <li>slide 01</li>
                    <li>slide 02</li>
                    <li>slide 03</li>
                    <li>slide 04</li>
                    <li>slide 05</li>
                </ul>
            </div>
            <p class="controls">
                <span class="prev">prev</span>
                <span class="next">next</span>
            </p>
        </div>
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
</body>
</html>