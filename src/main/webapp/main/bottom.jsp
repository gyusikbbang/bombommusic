<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>BomBom</title>
<link href="css/style.css" rel="stylesheet">
<link href="css/bottom.css?after" rel="stylesheet">
</head>
<body>
    <!--footer-->
    <div class="footer">
        <div class="footer-inner">
            <h1><a href="main.html">BomBom</a></h1>
            <div class="inner-contents">
            	<div style="margin-top: 10px;">
                	<h4>(주)봄봄클래식 | 서울특별시 oo시 oooo로 oo | 대표: 홍길동 | 사업자등록번호: ooo-oo-oooooo</h4>
                	<h4>대표전화: 1111-2222 | Fax:02-111-2222 | 대표이메일: bombom99@ooomail.com</h4> 
                </div>
            </div>
        </div>
    </div>
<!-- 폰트어썸 불러오기 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<script>
    function fnSearch(proCate,proLabel) {
        /* if ($("#searchText").val() == '') {
            alert("검색어를 입력해 주세요.");
            $("#searchText").focus();
            return;
        } */
        
        document.location.href = "/BomBom/proList/proList.jsp?proName=" + $("#searchText").val() + "&proCate=" + proCate + "&proLabel=" + proLabel;
    }

    function enterkey() {
    	if (window.event.keyCode == 13) {
        	fnSearch('all', 'all');
        }
    }
</script>
<script src="js/side.js"></script>
<link rel="stylesheet" href="js/mic.js">
</body>
</html>