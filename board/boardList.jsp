<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css">  
<style>
/*select 태그 대신 span 대그 화면에 노출시켜서 selectmenu 기능을 사용하는데 그 때 부여되는 id*/
 #keyfield-button{
 	width: 80px;
 }
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/board.js"></script>
<script type="text/javascript">
	var result = '${result}';
	if(result == 'success'){
		alert('처리가 완료되었습니다.');
		//백버튼을 누른 후 다시 돌아오면 alert창이 뜨는 것을 방지하기 위해서 
		location.reload();
	}
	
    $(document).ready(function(){
    	$('#keyfield').selectmenu({
    		change:function(event,ui){
    			console.log('선택한 값 : ' + $(this).val());
    		}
    	});
    });
</script>
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main-style">
	<h2>게시판 목록</h2>
	<form action="list.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1">제목</option>
					<option value="2">ID</option>
					<option value="3">내용</option>
					<option value="4">전체</option>
				</select>
			</li>
			<li>
				<input type="text" name="keyword" id="keyword">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='list.do'">
			</li>
		</ul>
	</form>
	<div class="align-right">
		<c:if test="${!empty user}">
		<input type="button" value="글쓰기"
		       onclick="location.href='write.do'">
		</c:if>
	</div>
	<c:if test="${count == 0}">
	<div class="align-center">등록된 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table>
		<tr>
			<th>번호</th>
			<th width="400">제목</th>
			<th>작성자</th>
			<th>최근수정일</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="board" items="${list}">
		<tr>
			<td>${board.board_num}</td>
			<td><a href="detail.do?board_num=${board.board_num}">${board.title}(${board.re_cnt})</a></td>
			<td>${board.id}</td>
			<td>${board.modify_date}</td>
			<td>${board.hit}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${pagingHtml}</div>
	</c:if>
</div>







