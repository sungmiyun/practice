<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
</head>
<body>

<form id = "login_form" action = "loginPro.jsp" method = "post">
	<fieldset>
		<legend>로그인</legend>
		<ul>
			<li>
				<label for = "id">아이디</label>
				<input type = "text" name = "id" size = "20" id = "id">
			</li>
			<li>
				<label for = "password">비밀번호</label>
				<input type = "password" name = "password" size = "20" id = "password">
			</li>
		</ul>
		<div><input type = "submit" value = "로그인"></div>
	</fieldset>

</form>
</body>
</html>