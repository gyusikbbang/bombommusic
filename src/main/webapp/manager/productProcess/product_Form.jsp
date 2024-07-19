<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Font online-->
<link href="https://fonts.googleapis.com/css?family=Open+Sans"
	rel="stylesheet">

<!--        Animate.css-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">

<link rel="stylesheet" href="../css/form.css">
<link rel="stylesheet" href="./css/form.css">

<!-- Google JQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script src="form.js"></script>
<style>
</style>
</head>
<body>
	<div id="inputform">
		<div class="panel shadow1  animate1">
			<form class="input-form " method="post"
				action="../manager/productProcess/product_Pro.jsp"
				enctype="multipart/form-data" name="writeform" target="_blank">
				<h1 id="title-input">상품 추가</h1>
				<h5>추가하실 상품을 등록해주세요</h5>
				<br>

				<h1 class=" animate1 hidden" id="title-signup"></h1>
				<fieldset id="input-fieldset">



					<input class="input " name="ProName" type="text" required
						placeholder="상품 이름" value=""> <select class="select"
						name="ProCate">

						<option value="100">피아노</option>
						<option value="200">바이올린</option>
						<option value="210">비올라</option>
						<option value="220">첼로</option>
						<option value="230">더블베이스</option>
						<option value="300">플룻</option>
						<option value="310">오보에</option>
						<option value="320">바순</option>
						<option value="330">클라리넷</option>
						<option value="400">호른</option>
						<option value="410">트럼펫</option>
						<option value="420">트럼본</option>
						<option value="430">튜바</option>
						<option value="500">심벌즈</option>
						<option value="510">팀파니</option>
						<option value="520">마림바</option> 
					</select>
					 <select class="select" name="ProLabel">

						<option value="위너 클래식">위너 클래식</option>
						<option value="유니버셜 클래식">유니버셜 클래식</option>
						<option value="소니 클래식">소니 클래식</option>
						<option value="낙소스">낙소스</option>

					</select> <select class="select" name="Concerto">
						<option value="true">협주곡 O</option>
						<option value="false">협주곡 X</option>


					</select> <input class="input " name="discount_rate" type="text" required
						placeholder="할인율" value="">



					<script src="/BomBom/manager/js/file.js"></script>


					<input class="input" name="Price" type="text" required
						placeholder="가격" value=""> <input class="input "
						onchange="fileCheck(this)"
						accept="image/gif, image/jpeg, image/png" name="ProImg1"
						type="file" required placeholder="상품 이미지1" value=""> <input
						class="input  animate3" onchange="fileCheck(this)"
						accept="image/gif, image/jpeg, image/png" name="ProImg2"
						type="file" required placeholder="상품 이미지2" value=""> <input
						class="input  animate3" onchange="fileCheck(this)"
						accept="image/gif, image/jpeg, image/png" name="ProImg3"
						type="file" required placeholder="상품 이미지3" value=""> <input
						class="input  animate3" name="ProInfo" type="text" required
						placeholder="상품 정보" value=""> <input
						class="input  animate3" name="ProStock" type="text" required
						placeholder="상품 재고" value=""> <input
						class="input  animate3" onchange="fileCheckaudio(this)"
						accept="audio/*" name="audio" type="file" required
						placeholder="오디오" value="">

				</fieldset>
				<input type="submit" class="input_form button  animate4"
					action="../manager/productProcess/product_Pro.jsp" value="입력완료">

			</form>
		</div>
	</div>

	<script src="form.js"></script>
</body>
</html>
