<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript">
	        // 로그아웃 담당 JSP로 이동
	        function logoutPro(){
	            location.href="LogoutPro.jsp";
	       	 }
	 </script>
</head>
<body>
	<b><font size="5" color="skyblue">메인화면입니다.</font></b><br><br>
    <%
        if(session.getAttribute("sessionID") == null) // 로그인이 안되었을 때
        { 
            // 로그인 화면으로 이동
            response.sendRedirect("LoginForm.jsp");
        }
        else // 로그인 했을 경우
        {
    %>
    <h2>
        <font color="red"><%=session.getAttribute("sessionID") %></font>
       	님 로그인되었습니다.
    </h2>
    <br><br>
    <input type="button" value="로그아웃" onclick="logoutPro()" />
    
    <%} %>    
</body>
</html>