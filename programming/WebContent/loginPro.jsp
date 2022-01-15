<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 확인</title>
</head>
<body>
	<h1>로그인 확인</h1>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	if(id.equals(password)){//로그인 성공
		session.setAttribute("userId", id);
%>
		<%=id %>님이 로그인했습니다.<br>
		
<%	
	}else{//로그인 실패
%>
		<script type="text/javascript">
			alert('로그인에 실패했습니다.');
			history.go(-1);
		</script>
<%		
	}
%>
</body>
</html>