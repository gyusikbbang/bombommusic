<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="LoginDB.LoginDataBean"%>
<%@ page import="LoginDB.LoginDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>



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

List<LoginDataBean> memberList = null;

String loginNum = "";



LoginDBBean memberProcess = LoginDBBean.getInstance();
count = memberProcess.getmemberCount();

if (count > 0) {
	memberList = memberProcess.getTypeMember(loginNum, startRow, endRow);
	if (memberList == null || memberList.size() == 0) {
		loginNum = "all";
		memberList = memberProcess.getTypeMember(loginNum, startRow, endRow);
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
		String login_name = "";
		if (loginNum.equals("1")) {
			login_name = "일반";
		} else if (loginNum.equals("2")) {
			login_name = "카카오";
		} else if (loginNum.equals("3")) {
			login_name = "구글";
		} else if (loginNum.equals("all")) {
			login_name = "전체";
		}

		String prCate = "";
		%>
		<div>
			<div class="container-fluid">
				<a href="../managerMain.jsp">관리자 메인으로</a>
				<p><%=login_name%>
					분류의 목록:
					<%
				if (loginNum.equals("all")) {
				%>
					<%=count%>개

					<%
					} else if (memberList == null || memberList.size() == 0) {
					loginNum = "all";
					} else {
					%>
					<%=memberList.size()%>개
					<%
					}
					%>
				</p>
				<a href="./productProcess/memberList.jsp?loginNum=all"
					class="btn btn-success">직접수정</a>
			</div>
		</div>



		<%
		if (count == 0) {
		%>
		<div class="alert alert-danger" role="alert">등록된 회원이 없습니다.</div>

		<%
		} else {
		%>
		<table class="table table-striped">
			<thead>
				<tr class="table-secondary">
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">이메일</th>
					<th scope="col">주소</th>
					<th scope="col">로그인</th>
					<th scope="col">전화번호</th>
					<th scope="col">등록일자</th>
					<th scope="col">수정/삭제</th>



				</tr>
			</thead>
			<tbody>
				<%
				for (int i = 0; i < memberList.size(); i++) {
					LoginDataBean member = (LoginDataBean) memberList.get(i);
				%>



				<tr>

					<td><%=member.getMemberId()%></td>
					<td><%=member.getMemberName()%></td>
					<td><%=member.getMemberEmail()%></td>
					<td><%=member.getMemberAddr()%></td>
					<td><%=member.getTypename()%></td>
					<td><%=member.getMemberPhone()%></td>








					<td><%=sdf.format(member.getMember_reg())%></td>
					<td> 
						<div class="btn-group" role="group" aria-label="Basic example">
							<button
								onclick="window.open('/BomBom/manager/productProcess/memberUpdate_Form.jsp?memberId=<%=member.getMemberId()%>&typename=<%=member.getTypename()%>&loginNum=<%=member.getLoginNum()%>')"
								class="btn7">수정</button>
							
<button onclick="delete_member('<%=member.getMemberId()%>', '<%=member.getLoginNum()%>')" class="btn8">삭제</button>
<script>
function delete_member(memberId, loginNum) {
    if (confirm("삭제하시려면 확인 삭제를 원치 않으시면 취소 선택해주세요.")) {
        location.href = '/BomBom/manager/productProcess/memberDeletePro.jsp?memberId=' + memberId + '&loginNum=' + loginNum;
    } else {
        alert('원래 화면으로 돌아갑니다');
        location.href = '/BomBom/manager/productProcess/memberList.jsp?loginNum=all';
    }
}
</script>
  
						</div></td>
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
					href="memberList.jsp?pageNum=<%=startPage - pageBlock%>"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a>

				<%
				} else {
				%>
				<a class="page-link"
					href="memberList.jsp?pageNum=<%=startPage - pageBlock%>"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a>




				<%
				}
				%>

				<%
				for (int i = startPage; i <= endPage; i++) {
				%>

				<li class="page-item"><a class="page-link"
					href="memberList.jsp?proCate=all&pageNum=<%=i%>"><%=i%></a></li>


				<%
				}
				%>




				<%
				if (endPage >= pageCount) {
				%>
				<a class="page-link-disable"
					href="memberList.jsp?pageNum=<%=startPage + pageBlock%>"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a>

				<%
				} else {
				%>
				<a class="page-link"
					href="memberList.jsp?pageNum=<%=startPage + pageBlock%>"
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
