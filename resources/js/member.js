$(document).ready(function(){
	//검색 유효성 체크
	$('#search_form').submit(function(){
		if($('#keyword').val()==''){
			alert('검색어를 입력하세요!');
			$('#keyword').focus();
			return false;
		}
	});
	//비밀번호 변경 체크
	$('#passwd').keyup(function(){
		if($('#confirm_passwd').val()!='' && $('#confirm_passwd').val()!=$(this).val()){
			$('#message_id').text('비밀번호 불일치').css('color','red');
		}else if($('#confirm_passwd').val()!='' && $('#confirm_passwd').val()==$(this).val()){
			$('#message_id').text('비밀번호 일치').css('color','#000');
		}
	});
	$('#confirm_passwd').keyup(function(){
		if($('#passwd').val()!='' && $('#passwd').val()!=$(this).val()){
			$('#message_id').text('비밀번호 불일치').css('color','red');
		}else if($('#passwd').val()!='' && $('#passwd').val()==$(this).val()){
			$('#message_id').text('비밀번호 일치').css('color','#000');
		}
	});
	$('#change_form').submit(function(){
		if($('#now_passwd').val()==''){
			alert('현재 비밀번호를 입력하세요!');
			$('#now_passwd').focus();
			return false;
		}
		if($('#passwd').val()==''){
			alert('변경할 비밀번호를 입력하세요!');
			$('#passwd').focus();
			return false;
		}
		if($('#confirm_passwd').val()==''){
			alert('변경할 비밀번호 확인을 입력하세요!');
			$('#confirm_passwd').focus();
			return false;
		}
		if($('#passwd').val()!=$('#confirm_passwd').val()){
			$('#message_id').html('<b>비밀번호 불일치</b>').css('color','red');
			return false;
		}
	});
	//MYPage 프로필사진 등록 및 수정
	$('#photo_btn').click(function(){
		$('#photo_choice').show();
		$(this).hide();
	});
	
	var photo_path;
	var my_photo;
	$('#upload').change(function(){
		var upload = document.getElementById('upload');
        my_photo = upload.files[0];
		if (my_photo) {
            var reader = new FileReader(); 
            
            reader.readAsDataURL(upload.files[0]);
            
            reader.onload = function(){ 
            	photo_path = $('.my-photo').attr('src');
            	//my_photo = reader.result;
            	$('.my-photo').attr('src',reader.result);
            };  
        }
	});
	$('#photo_submit').click(function(){
		if($('#upload').val()==''){
			alert('파일을 선택하세요');
			$('#upload').focus();
			return;
		}
		//파일 전송
		var form_data = new FormData();
      	form_data.append('upload', my_photo);
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: 'updateMyPhoto.do',
        	dataType:'json',
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(data) {
        		if(data.result == 'logout'){
        			alert('로그인 후 사용하세요');
        		}else if(data.result == 'success'){
        			alert('프로필 사진이 수정되었습니다.');
        			$('#upload').val('');
        			$('#photo_choice').hide();
        			$('#photo_btn').show();
        		}else{
        			alert('파일 전송 오류 발생');
        		}
        	},
        	error:function(){
        		alert('네트워크 오류 발생');
        	}
      	});
	});
	$('#photo_reset').click(function(){
		$('.my-photo').attr('src',photo_path);
		$('#upload').val('');
		$('#photo_choice').hide();
		$('#photo_btn').show();
	});
	//비밀번호 보기
	$('#showPasswd').click(function(){
		$('#passwd').attr('type','text');
		window.setTimeout(function(){
			$('#passwd').attr('type','password');
		},1000);
	});
});