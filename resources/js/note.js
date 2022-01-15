$(document).ready(function(){
	var pageBlock = 10;
	var currentPage;
	var count;
	var rowCount;
	//댓글 목록
	function selectData(pageNum,mode){
		currentPage = pageNum;
		
		$('#output').empty();

		//로딩 이미지 노출
		$('#loading').show();
		
		$.ajax({
			type:'post',
			data:{pageNum:pageNum,mode:mode},
			url:'listAjax.do',
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(data){
				//로딩 이미지 감추기
				$('#loading').hide();
				
				if(data.result && data.result == 'logout'){
					alert('쪽지는 로그인해야 볼 수 있습니다.');
					location.href='../member/login.do';
				}
				
				count = data.count;
				rowCount = data.rowCount;
				var list = data.list;
				
				if(count == 0){
					$('#output').append('<span>등록된 쪽지가 없습니다.</span>');
				}else{
					var output = '<table>';
					    output += '<tr>';
					    output += '<th><input type="checkbox" id="chk_all"></th>';
					    if(data.mode == 'recv'){
					    	output += '<th>보낸 사람</th>';
					    }else{
					    	output += '<th>받는 사람</th>';
					    }
					    output += '<th>내용</th>';
					    output += '<th>날짜</th>';
					    output += '<th>읽기여부</th>';
					    output += '</tr>';
					//목록 작업
					$(list).each(function(index,item){
						    output += '<tr>';
						    output += '<td><input type="checkbox" class="del-chk" name="note_num" value="' + item.note_num + '"></td>';
							if(data.mode == 'recv'){
								output += '<td>' + item.send_id + '</td>';
							}else{
								output += '<td>' + item.recv_id + '</td>';
							}
							if(item.message.length > 35){
								item.message = item.message.substring(0,35) + " ...";
							}
						    output += '<td align="left"><a href="detail.do?note_num=' + item.note_num + '&mode=' + data.mode +'">' + item.message + '</a></td>';
							output += '<td>' + item.note_date + '</td>';
							if(item.recv_check == 0){
								output += '<td>읽지 않음</td>';
							}else{
								output += '<td>읽음</td>';
							}
							output += '</tr>';
					});
					$('#output').append(output);
					$('#output').append('</table>');
					setPage();
				}
			},
			error:function(){
				//로딩 이미지 감추기
				$('#loading').hide();
				alert('네트워크 오류');
			}
		});
	}
	
	function setPage(){
		//ul 태그 초기화
		$('.paging-button').empty();
		if(count == 0){
			return;
		}
		
		var totalPage = Math.ceil(count/rowCount);
		
		if(currentPage == undefined || currentPage == ''){
			currentPage = 1;
		}
		//현재 페이지가 전체 페이지 수보다 크면 전체 페이지수로 설정
		if(currentPage > totalPage){
			currentPage = totalPage;
		}
		
		//시작 페이지와 마지막 페이지 값을 구하기
		var startPage = 
			Math.floor((currentPage-1)/pageBlock)*pageBlock + 1;
		var endPage = startPage + pageBlock - 1;
		
		//마지막 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		var add='';
		if(startPage>pageBlock){
			add += '<li class="paging-num" data-page='+(startPage-1)+'>[이전]</li>';
		}
		
		for(var i=startPage;i<=endPage;i++){
			if(currentPage == i){
				add += '<li class="paging-current" data-page='+i+'>'+i+'</li>';
			}else{
				add += '<li class="paging-num" data-page='+i+'>'+i+'</li>';
			}
		}
		if(endPage < totalPage){
			add += '<li class="paging-num" data-page='+(startPage+pageBlock)+'>[다음]</li>';;
		}
		//ul 태그에 생성한 li를 추가
		$('.paging-button').append(add);
	}
	
	//페이지 버튼 이벤트 연결
	$(document).on('click','.paging-button li.paging-num',function(){
		//페이지 번호를 읽어들임
		currentPage = $(this).attr('data-page');
		//목록 호출
		selectData(currentPage,$('#list_note').attr('data-mode'));
	});
	
	//목록 삭제 체크박스 전체 선택/해제
	$(document).on('click','#chk_all',function(){
		if($('#chk_all').is(':checked')){
			$('.del-chk').prop('checked',true);
			$('#del_btn').prop('disabled',false);
		}else{
			$('.del-chk').prop('checked',false);
			$('#del_btn').prop('disabled',true);
		}
	});
	//전체 체크박스를 다 선택하면 #chk_all 선택, 하나라도 해제하면  #chk_all 해제
	$(document).on('click','.del-chk',function(){
		if($('input[class=del-chk]:checked').length==$('.del-chk').length){
			$('#chk_all').prop('checked',true);
		}else{
			$('#chk_all').prop('checked',false);
		}
		if($('input[class=del-chk]:checked').length==0){
			$('#del_btn').prop('disabled',true);
		}else if($('input[class=del-chk]:checked').length>0){
			$('#del_btn').prop('disabled',false);
		}
	});
	
	//쪽지 삭제 버튼을 클릭하면 삭제할 note_num 전송
	$('#del_btn').click(function(){
		var note_num = '';
		$(".del-chk:checked").each(function(index,item) {
			if(index>0) note_num += ","
            note_num += $(this).val();
        });
		var list_note = $('#list_note').attr('data-mode');
		$.ajax({
			type:'post',
			url:'deleteNote.do',
			data:{note_mode:list_note,note_num:note_num},
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(data){
				if(data.result == 'logout'){
					alert('로그인해야 삭제할 수 있습니다.');
				}else if(data.result == 'success'){
					alert('삭제 완료!');
					$('#del_btn').prop('disabled',true);
					selectData(1,$('#list_note').attr('data-mode'));
				}else{
					alert('댓글 삭제시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
		});
	});
	
	//초기 데이터(목록) 호출
	selectData(1,$('#list_note').attr('data-mode'));
});