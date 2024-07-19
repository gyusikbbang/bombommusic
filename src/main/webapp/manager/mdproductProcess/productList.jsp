<%@ page import="Manager.mdPickDBBean"%>
<%@ page import="Manager.mdPickDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
request.setCharacterEncoding("UTF-8");
%>


<%!int pageSize = 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>


<%
String pageNum = request.getParameter("pageNum");

if (pageNum == null) {
	pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
int count = 0;
int number = 0;
String  select = "buycount";


out.print(startRow);


List<mdPickDataBean> productList = null;

String proCate = "";

String proCode = "";
String prCate= "";
proCode = request.getParameter("proCode");
proCate = request.getParameter("proCate");

mdPickDBBean productProcess = mdPickDBBean.getInstance();
count = productProcess.getProductCount();

if (count > 0) {
	productList = productProcess.getrankingProducts(proCate, startRow, endRow, select);
	if (productList == null || productList.size() == 0) {
		proCate = "all";
		productList = productProcess.getrankingProducts(proCate, startRow, endRow, select);
	}

}
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="../css/page.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/table.css">
<link rel="stylesheet" href="../css/page.css">
<style>
td img {
	width: 90px;
	height: 90px;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<%
		String product_kindName = "";
		if (proCate.equals("100")) {
		    product_kindName = "피아노";
		} else if (proCate.equals("200")) {
		    product_kindName = "바이올린";
		} else if (proCate.equals("210")) {
		    product_kindName = "비올라";
		} else if (proCate.equals("220")) {
		    product_kindName = "첼로";
		} else if (proCate.equals("230")) {
		    product_kindName = "더블베이스";
		} else if (proCate.equals("300")) {
		    product_kindName = "플룻";
		} else if (proCate.equals("310")) {
		    product_kindName = "오보에";
		} else if (proCate.equals("320")) {
		    product_kindName = "바순";
		} else if (proCate.equals("330")) {
		    product_kindName = "클라리넷";
		} else if (proCate.equals("400")) {
		    product_kindName = "호른";
		} else if (proCate.equals("410")) {
		    product_kindName = "트럼펫";
		} else if (proCate.equals("420")) {
		    product_kindName = "트럼본";
		} else if (proCate.equals("430")) {
		    product_kindName = "튜바";
		} else if (proCate.equals("500")) {
		    product_kindName = "심벌즈";
		} else if (proCate.equals("510")) {
		    product_kindName = "팀파니";
		} else if (proCate.equals("520")) {
		    product_kindName = "마림바";
		} else {
		    product_kindName = "전체";
		}
		
		
		
		
		
		
	
		%>
		<div>
			<div class="container-fluid">
				<a href="../MdmanagerMain.jsp">관리자 메인으로</a>
				
				
				<p><%=product_kindName%>의 분류 검색 목록:
				
					<%
				if (proCate.equals("all")) {
				%>
					<%=count%>개

					<%
					} else if (productList == null || productList.size() == 0) {
					proCate = "all";
					} else {
					%>
					<%=productList.size()%>개
					<%
					}
					%>
					
				
				</p>
				<a href="./mdproductProcess/productList.jsp?proCate=all"
					class="btn btn-success">직접수정</a>
			</div>
		</div>

		<form name="search"
			action="/BomBom/manager/mdproductProcess/productSearch.jsp"
			method="post">
			<select name="ProCate">
				<option value="all">전체</option>
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
			</select> <input type='search' name="ProName" required /> <input
				type='submit' value='검색' />
		</form>

		<%
		if (count == 0) {
		%>
		<div class="alert alert-danger" role="alert">등록된 상품이 없습니다.</div>

		<%
		} else {
		%>

		<table class="table table-striped">
			<thead>
				<tr class="table-secondary">
					<th scope="col">번호</th>
					<th scope="col">상품분류</th>
					<th scope="col">상품라벨</th>
					<th scope="col">상품이름</th>
					<th scope="col">가격</th>
					<th scope="col">상품이미지1</th>
					<th scope="col">상품이미지2</th>
					<th scope="col">상품이미지3</th>
					<th scope="col">노래듣기</th>
					<th scope="col">상품정보</th>
					<th scope="col">상품재고</th>
					<th scope="col">구매량</th>
					<th scope="col">추천수</th>
					<th scope="col">할인율</th>
					<th scope="col">등록날짜</th>
					<th scope="col">수정/삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (int i = 0; i < productList.size(); i++) {
					mdPickDataBean product = (mdPickDataBean) productList.get(i);
					String audioId = "customPlayButton_" + i;
					String audioElementId = "audio_" + i;
					
					
					
					
					String procateName = "";
					if (product.getProCate().equals("100")) {
					    procateName = "피아노";
					} else if (product.getProCate().equals("200")) {
					    procateName = "바이올린";
					} else if (product.getProCate().equals("210")) {
					    procateName = "비올라";
					} else if (product.getProCate().equals("220")) {
					    procateName = "첼로";
					} else if (product.getProCate().equals("230")) {
					    procateName = "더블베이스";
					} else if (product.getProCate().equals("300")) {
					    procateName = "플룻";
					} else if (product.getProCate().equals("310")) {
					    procateName = "오보에";
					} else if (product.getProCate().equals("320")) {
					    procateName = "바순";
					} else if (product.getProCate().equals("330")) {
					    procateName = "클라리넷";
					} else if (product.getProCate().equals("400")) {
					    procateName = "호른";
					} else if (product.getProCate().equals("410")) {
					    procateName = "트럼펫";
					} else if (product.getProCate().equals("420")) {
					    procateName = "트럼본";
					} else if (product.getProCate().equals("430")) {
					    procateName = "튜바";
					} else if (product.getProCate().equals("500")) {
					    procateName = "심벌즈";
					} else if (product.getProCate().equals("510")) {
					    procateName = "팀파니";
					} else if (product.getProCate().equals("520")) {
					    procateName = "마림바";
					} 
				%>





				<tr>

					<td><%=++number%></td>
					<td><%=procateName%></td>
					<td><%=product.getProLabel()%></td>
					<td><%=product.getProName()%></td>
					<td><%=product.getPrice()%></td>

					<td><img src="/BomBom/imageFile/<%=product.getProImg1()%>"></td>

					<td><img src="/BomBom/imageFile/<%=product.getProImg2()%>"></td>
					<td><img src="/BomBom/imageFile/<%=product.getProImg3()%>"></td>
					<td><button id="<%=audioId%>" class="btn btn-primary">노래듣기</button></td>
					<td><%=product.getProInfo()%></td>
					<td><%=product.getProStock()%></td>
					<td><%=product.getBuycount()%></td>
					<td><%=product.getRecommend()%></td>

					<td><%=product.getDiscount_rate()%> %</td>





					<script>
var track_<%=i%> = new Audio();
track_<%=i%>.src = "/BomBom/imageFile/<%=product.getAudio()%>";
var customPlayButton_<%=i%> = document.getElementById("<%=audioId%>");
var audioElement_<%=i%> = document.getElementById("<%=audioElementId%>");
var isPlaying_<%=i%> = false;

customPlayButton_<%=i%>.addEventListener("click", function() {
  if (!isPlaying_<%=i%>) {
    track_<%=i%>.play();
    isPlaying_<%=i%> = true;
  } else {
    track_<%=i%>.pause();
    isPlaying_<%=i%> = false;
  }
});

track_<%=i%>.addEventListener("ended", function() {
  isPlaying_<%=i%> = false;
});
</script>





					<td><%=sdf.format(product.getRegdate())%></td>
					<td>

						<div class="btn-group" role="group" aria-label="Basic example">
							<button
								onclick="window.open('/BomBom/manager/mdproductProcess/productUpdate_Form.jsp?ProCode=<%=product.getProCode()%>&proCate=<%=product.getProCate()%>')"
								class="btn7">수정</button>
														
<button onclick="delete_pro(<%=product.getProCode()%>, <%=product.getProCate()%>)" class="btn8">삭제</button>
<script>
function delete_pro(proCode, proCate) {
    if (confirm("삭제하시려면 확인 삭제를 원치 않으시면 취소 선택해주세요.")) {
        location.href='/BomBom/manager/mdproductProcess/productDeletePro.jsp?proCode=' + proCode + '&proCate=' + proCate;
    } else {
        alert('원래 화면으로 돌아갑니다');
        location.href = "/BomBom/manager/mdproductProcess/productList.jsp?proCate=all";
    }
}
</script>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<div class="pagination">

			<ul class="page">
				<%
				if (count > 0) {
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					int startPage = 1;
					int pageBlock = 5;

					if (currentPage % pageBlock != 0)
						startPage = (int) (currentPage / pageBlock) * pageBlock + 1;
					else
						startPage = ((int) (currentPage / pageBlock) - 1) * pageBlock + 1;

					int endPage = startPage + pageBlock - 1;
					if (endPage > pageCount)
						endPage = pageCount;
				%>











				<%
				if (startPage < pageBlock) {
				%>
				<a class="page-link-disable"
					href="productList.jsp?pageNum=<%=startPage - pageBlock%>"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a>

				<%
				} else {
				%>
				<a class="page-link"
					href="productList.jsp?pageNum=<%=startPage - pageBlock%>"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a>




				<%
				}
				%>

				<%
				for (int i = startPage; i <= endPage; i++) {
				%>

				<li class="page-item"><a class="page-link"
					href="productList.jsp?proCate=all&pageNum=<%=i%>"><%=i%></a></li>


				<%
				}
				%>




				<%
				if (endPage >= pageCount) {
				%>
				<a class="page-link-disable"
					href="productList.jsp?pageNum=<%=startPage + pageBlock%>"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a>

				<%
				} else {
				%>
				<a class="page-link"
					href="productList.jsp?pageNum=<%=startPage + pageBlock%>"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a>




				<%
				}
				%>



				<%
				}
				%>
			</ul>

			<%
			}
			%>

		</div>
	</div>


</body>
</html>
