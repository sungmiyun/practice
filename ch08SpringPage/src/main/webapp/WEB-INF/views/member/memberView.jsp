<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main-style"> 
	<h2>회원 상세 정보</h2>
	<ul>
		<li>이름 : ${member.name}</li>
		<li>전화번호 : ${member.phone}</li>
		<li>이메일 : ${member.email}</li>
		<li>우편번호 : ${member.zipcode}</li>
		<li>주소 : ${member.address1} ${member.address2}</li>
		<li>가입 날짜 : ${member.reg_date}</li>
		<li>정보 수정 날짜 : ${member.modify_date}</li>
	</ul>
	<hr size="1" width="100%">
	<p class="align-right">
		<input type="button" value="수정" onclick="location.href='update.do'">
		<input type="button" value="비밀번호 변경" onclick="location.href='changePassword.do'">
		<input type="button" value="회원 탈퇴" onclick="location.href='delete.do'">
	</p>
</div>
<!-- 중앙 컨텐츠 끝 -->