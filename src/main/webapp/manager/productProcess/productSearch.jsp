
<%@ page import="Manager.ShopProductDataBean"%>
<%@ page import="Manager.ShopProductDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%
request.setCharacterEncoding("utf-8");
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

List<ShopProductDataBean> ProductList = null;

String ProCate = "";

String ProCode = "";
String ProName = "";
ProCode = request.getParameter("ProCode");
ProCate = request.getParameter("ProCate");
ProName = request.getParameter("ProName");

ShopProductDBBean ProductProcess = ShopProductDBBean.getInstance();
count = ProductProcess.searchcount(ProCate, ProName);

if (count > 0) {
	ProductList = ProductProcess.search(ProCate, ProName, startRow, endRow);
	if (ProductList == null || ProductList.size() == 0) {
		ProCate = "all";
		ProductList = ProductProcess.search(ProCate, ProName, startRow, endRow);
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
		String Product_kindName = "";
		if (ProCate.equals("100")) {
			Product_kindName = "피아노";
		} else if (ProCate.equals("200")) {
			Product_kindName = "바이올린";
		} else if (ProCate.equals("210")) {
			Product_kindName = "비올라";
		} else if (ProCate.equals("220")) {
			Product_kindName = "첼로";
		} else if (ProCate.equals("230")) {
			Product_kindName = "더블베이스";
		} else if (ProCate.equals("300")) {
			Product_kindName = "플룻";
		} else if (ProCate.equals("310")) {
			Product_kindName = "오보에";
		} else if (ProCate.equals("320")) {
			Product_kindName = "바순";
		} else if (ProCate.equals("330")) {
			Product_kindName = "클라리넷";
		} else if (ProCate.equals("400")) {
			Product_kindName = "호른";
		} else if (ProCate.equals("410")) {
			Product_kindName = "트럼펫";
		} else if (ProCate.equals("420")) {
			Product_kindName = "트럼본";
		} else if (ProCate.equals("430")) {
			Product_kindName = "튜바";
		} else if (ProCate.equals("500")) {
			Product_kindName = "심벌즈";
		} else if (ProCate.equals("510")) {
			Product_kindName = "팀파니";
		} else if (ProCate.equals("520")) {
			Product_kindName = "마림바";
		} else {
			Product_kindName = "전체";
		}

		String prCate = "";
		%>
		<div>
			<div class="container-fluid">
				<a href="../managerMain.jsp">관리자 메인으로</a>
				<p><%=Product_kindName%>
					분류의 목록:
					<%
				if (ProCate.equals("all")) {
				%>
					<%=count%>개

					<%
					} else if (ProductList == null || ProductList.size() == 0) {
					ProCate = "all";
					} else {
					%>
					<%=ProductList.size()%>개
					<%
					}
					%>
				</p>
				<a href="./ProductProcess/ProductList.jsp?ProCate=all"
					class="btn btn-success">직접수정</a>
			</div>
		</div>

		<form name="search" action="productSearch.jsp" method="post">
			<select name="ProCate">
				<option value="all">전체</option>
				<option value="100">피아노</option>
				<option value="200">현악기</option>
				<option value="300">목관악기</option>
				<option value="400">금관악기</option>

			</select> <input type='search' name="ProName" required /> <input type='submit'
				value='검색' />
		</form>

		<%
		if (count == 0) {
		%>
		<div class="alert alert-danger" role="alert">검색된 상품이 없습니다</div>

		<%
		} else {
		%>
		<table class="table table-striped">
			<thead>
				<tr class="table-secondary">
					<th scope="col">번호</th>
					<th scope="col">상품분류</th>
					<th scope="col">상품이름</th>
					<th scope="col">가격</th>
					<th scope="col">상품이미지1</th>
					<th scope="col">상품이미지2</th>
					<th scope="col">상품이미지3</th>
					<th scope="col">상품정보</th>
					<th scope="col">상품재고</th>
					<th scope="col">등록날짜</th>

					<th scope="col">수정/삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (int i = 0; i < ProductList.size(); i++) {
					ShopProductDataBean Product = (ShopProductDataBean) ProductList.get(i);
				%>


				<%
				String procateName = "";
				if (Product.getProCate().equals("100")) {
				    procateName = "피아노";
				} else if (Product.getProCate().equals("200")) {
				    procateName = "바이올린";
				} else if (Product.getProCate().equals("210")) {
				    procateName = "비올라";
				} else if (Product.getProCate().equals("220")) {
				    procateName = "첼로";
				} else if (Product.getProCate().equals("230")) {
				    procateName = "더블베이스";
				} else if (Product.getProCate().equals("300")) {
				    procateName = "플룻";
				} else if (Product.getProCate().equals("310")) {
				    procateName = "오보에";
				} else if (Product.getProCate().equals("320")) {
				    procateName = "바순";
				} else if (Product.getProCate().equals("330")) {
				    procateName = "클라리넷";
				} else if (Product.getProCate().equals("400")) {
				    procateName = "호른";
				} else if (Product.getProCate().equals("410")) {
				    procateName = "트럼펫";
				} else if (Product.getProCate().equals("420")) {
				    procateName = "트럼본";
				} else if (Product.getProCate().equals("430")) {
				    procateName = "튜바";
				} else if (Product.getProCate().equals("500")) {
				    procateName = "심벌즈";
				} else if (Product.getProCate().equals("510")) {
				    procateName = "팀파니";
				} else if (Product.getProCate().equals("520")) {
				    procateName = "마림바";
				} 
				%>


				<tr>

					<td><%=++number%></td>
					<td><%=procateName%></td>
					<td><%=Product.getProName()%></td>
					<td><%=Product.getPrice()%></td>

					<td><img src="/BomBom/imageFile/<%=Product.getProImg1()%>"></td>

					<td><img src="/BomBom/imageFile/<%=Product.getProImg2()%>"></td>
					<td><img src="/BomBom/imageFile/<%=Product.getProImg3()%>"></td>
					<td><%=Product.getProInfo()%></td>
					<td><%=Product.getProStock()%></td>










					<td><%=sdf.format(Product.getRegdate())%></td>
					<td>

						<div class="btn-group" role="group" aria-label="Basic example">
							<button
								onclick="window.open('/BomBom/manager/ProductProcess/ProductUpdate_Form.jsp?ProCode=<%=Product.getProCode()%>&ProCate=<%=Product.getProCate()%>')"
								class="btn7">수정</button>
								<button onclick="delete_pro(<%=Product.getProCode()%>, <%=Product.getProCate()%>)" class="btn8">삭제</button>
<script>
function delete_pro(proCode, proCate) {
    if (confirm("삭제하시려면 확인 삭제를 원치 않으시면 취소 선택해주세요.")) {
        location.href='/BomBom/manager/productProcess/productDeletePro.jsp?proCode=' + proCode + '&proCate=' + proCate;
    } else {
        alert('원래 화면으로 돌아갑니다');
        location.href = "/BomBom/manager/productProcess/productList.jsp?proCate=all";
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
			href="productSearch.jsp?ProCate=<%=ProCate%>&ProName=<%=ProName%>&pageNum=<%=startPage - pageBlock%>"
			aria-label="Previous">
			<span aria-hidden="true">&laquo;</span>
		</a>
		<%
		} else {
		%>
		<a class="page-link"
			href="productSearch.jsp?ProCate=<%=ProCate%>&ProName=<%=ProName%>&pageNum=<%=startPage - pageBlock%>"
			aria-label="Previous">
			<span aria-hidden="true">&laquo;</span>
		</a>
		<%
		}
		%>

		<%
		for (int i = startPage; i <= endPage; i++) {
		%>
		<li class="page-item">
			<a class="page-link"
				href="productSearch.jsp?ProCate=<%=ProCate%>&ProName=<%=ProName%>&pageNum=<%=i%>">
				<%=i%>
			</a>
		</li>
		<%
		}
		%>

		<%
		if (endPage >= pageCount) {
		%>
		<a class="page-link-disable"
			href="productSearch.jsp?ProCate=<%=ProCate%>&ProName=<%=ProName%>&pageNum=<%=startPage + pageBlock%>"
			aria-label="Next">
			<span aria-hidden="true">&raquo;</span>
		</a>
		<%
		} else {
		%>
		<a class="page-link"
			href="productSearch.jsp?ProCate=<%=ProCate%>&ProName=<%=ProName%>&pageNum=<%=startPage + pageBlock%>"
			aria-label="Next">
			<span aria-hidden="true">&raquo;</span>
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
