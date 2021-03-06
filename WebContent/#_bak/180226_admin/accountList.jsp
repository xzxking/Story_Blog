<%@page import="com.db.UserDataBean"%>
<%@page import="java.util.List"%>
<%@page import="com.db.UserDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<% String listid = request.getParameter("listid");
	if (listid==null) listid = "1"; %>
<%
	int pageSize= 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum =="") {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;  
	//사칙연산은 곱셈먼저.. +1은 맨나중에! 왼쪽에서부터 오른쪽으로 차례대로 계산
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	List usList = null;
	UserDBBean dbPro = UserDBBean.getInstance();
	/* 에러나서 주석처리 */
	/* count = dbPro.getUserCount(listid);
	//게시판에 있는 글 수 count
	if (count > 0) {
		usList = dbPro.getUsers(startRow, endRow, listid); 
	}
	number = count - (currentPage - 1) * pageSize; */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<title>Story Blog - Userlist</title>
	<style type="text/css">
	.bgimg {
		    background-image: url("/Story_Blog/Project/img/back2_babypink.jpg");
		    min-height: 100%;
		    background-position: center;
		    background-size: cover;		
		}
	</style>
	
	<script type="text/javascript">
	        // 어드민 로그아웃 JSP로 이동
	        function adLogoutPro(){
	            location.href="/Story_Blog/admin/adLogoutPro.jsp";
	       	 }
	</script>
</head>
<body class="bgimg">
<div class="w3-container"> 
       <%
       if(count==0){
       %>
       <div class="w3-container w3-white w3-round w3-margin">
       		
          	<h3 class="w3-center"><%=listid%>(전체 회원 수:<%=count %>)</h3>
    
       		 <p class="w3-left w3-padding-left-large w3-text-pink">
       		 <!-- 돌아가기 (회원 X)-->
       		 <input class="w3-blue w3-button w3-small" type="button" value="Admin Logout" onclick="adLogoutPro()">
       		 </p>
        <div class="w3-center w3-container">
       		<p class="w3-pink">회원이 없습니다....</p>
       	</div>	
       
       
       </div>
       
       <% }else{ %>
       <div class="w3-container w3-margin w3-white w3-round">
       		<label class="w3-right w3-border" style="color: black; margin:5px 5px 0px 0px;"> <%=session.getAttribute("sessionID") %> 님 로그인되었습니다.</label>
       		<h3 class="w3-center"><%=listid%>(전체 회원 수:<%=count %>)</h3>
       
       		<p class="w3-left w3-padding-left-large w3-text-pink">
       		<!-- 돌아가기 (회원 O)-->
       		<input class="w3-blue w3-button w3-small" type="button" value="Admin Logout" onclick="adLogoutPro()">
       		</p>
       
       <table class="w3-table w3-bordered" width="900">
       <tr class="w3-pink w3-center">
       <td align="center" width="50">번호</td>
       <td align="center" width="100">회원 이메일</td>
       <td align="center" width="100">회원 비번</td>
       <td align="center" width="100">회원 이름</td>
       <td align="center" width="100">회원 Tel</td>
       <td align="center" width="100">회원 생일</td>
       <td align="center" width="100">가입일</td>
       <td align="center" width="100">IP</td>
       <td align="center" width="100">수정/삭제</td>
       </tr>
 
       
       <% for (int i=0;i<usList.size();i++){
          UserDataBean user=(UserDataBean) usList.get(i);%>
          <tr height="30">
          <td align="center" width="50"><%=number-- %></td>
        	    <td align="center" width="100"><%=user.getEmail() %></td>
        	    <td align="center" width="100"><%=user.getPwd() %></td>
          		<td align="center" width="100"><%=user.getName() %></td>
             	<td align="center" width="100"><%=user.getTel() %></td>
             	<td align="center" width="100"><%=user.getBirth() %></td>
                <td align="center" width="100"><%=sdf.format(user.getCdate()) %></td>
                <td align="center" width="100"><%=user.getIp() %></td>
               	<td align="center" width="100">
               		<!-- 수정 삭제 만들기  -->
               		<form method="post" action="<%=request.getContextPath() %>/admin/updateUserForm.jsp">
	  					<input type="submit" class="w3-button w3-white w3-hover-white" value="수정">
	  					<!-- onclick="location.href='/Story_Blog/admin/updateUserForm.jsp'"> -->
	  					<input type="hidden" name="email" value="<%= user.getEmail() %>">
						<input type="hidden" name="pwd" value="<%= user.getPwd() %>">
					</form>
  					
					
					<form method="post" action="<%=request.getContextPath() %>/admin/deleteUserPro.jsp">
						<input type="submit" class="w3-button w3-pink w3-hover-pink" value="삭제">
						<!-- hidden으로 email, pwd가져오기!!!  -->
	               		<input type="hidden" name="email" value="<%=user.getEmail() %>">
	               		<input type="hidden" name="pwd" value="<%=user.getPwd() %>">
	               		<!--  -->
               		</form>
               	</td>
          </tr>
          <%} %>
           
       </table>
       
       <div class = "w3-center w3-white w3-margin">
			<% int bottomLine = 3; 
				if(count > 0) {
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine; //곱셈, 나눗셈먼저.
					int endPage = startPage + bottomLine -1;
					if (endPage > pageCount) endPage = pageCount;
					if (startPage > bottomLine) { %>
					<a href="accountList.jsp?pageNum=<%= startPage - bottomLine %>">[이전]</a>
					<% } %>
					<% for (int i = startPage; i <= endPage; i++) { %>
					<a href="accountList.jsp?pageNum=<%=i%>"> <%
					if (i != currentPage) out.print("["+i+"]");
					else out.print("<font color='red'>["+i+"]</font>");%></a>
					<% }
						if(endPage < pageCount) {	%>
						<a href="accountList.jsp?pageNum=<%=startPage + bottomLine %>">[다음]</a>
						<% 
					}
				}
				
			%>
		</div>
		
     </div>
     <%} %>
           
</div>

</body>
</html>
