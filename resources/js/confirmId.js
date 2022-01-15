$(document).ready(function(){
	var checkId = 0;
	
	//아이디 중복 체크
	$('#confirmId').click(function(){
		if($('#id').val().trim()==''){
			$('#message_id').css('color','red').text('아이디를 입력하세요');
			$('#id').focus();
			return;
		}
		
		//var regMsg = new RegExp('^[A-Za-z0-9+]{4,12}$');
		/*var regMsg = /^[A-Za-z0-9+]{4,12}$/;
		if(!regMsg.test($('#id').val())){
			alert('영문,숫자 4자이상 12자 이하 입력');
			$('#id').focus();
			return;
		}*/
		
		$('#message_id').text(''); //메시지 초기화
		$('#loading').show(); //로딩 이미지 노출
		
		$.ajax({
			url:'confirmId.do',
			type:'post',
			data:{id:$('#id').val()},
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(param){
				$('#loading').hide();//로딩 이미지 감추기
				
				if(param.result == 'idNotFound'){
					$('#message_id').css('color','#000')
					                .text('등록가능ID');
					checkId = 1;
				}else if(param.result == 'idDuplicated'){
					$('#message_id').css('color','red')
	                                .text('중복된 ID');
					$('#id').val('').focus();
	                checkId = 0;
				}else if(param.result == 'notMatchPattern'){
					$('#message_id').css('color','red')
                                    .text('영문,숫자 4자이상 12자이하 입력!!!');
					$('#id').val('').focus();
					checkId = 0;
				}else{
					checkId = 0;
					alert('ID중복체크 오류');
				}
			},
			error:function(){
				checkId = 0;
				$('#loading').hide();//로딩 이미지 감추기
				alert('네트워크 오류 발생');
			}
		});
	});
	
	//아이디 중복 안내 메시지 초기화 및 아이디 중복 값 초기화
	$('#register_form #id').keydown(function(){
		checkId=0;
		$('#message_id').text('');
	});
	
	//submit 이벤트 발생시 아이디 중복 체크 여부 확인
	$('#register_form').submit(function(){
		if(checkId==0){
			$('#message_id').css('color','red').text('아이디 중복 체크 필수!');
			if($('#id').val().trim()==''){
				$('#id').focus();
			}
			return false;
		}
	});
});



