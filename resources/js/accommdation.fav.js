$(document).ready(function(){
	var status;
	//좋아요 수 
	function selectData(board_num){
		$.ajax({
			type:'post',
			data:{board_num:board_num},
			url:'getFav.do',
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(data){
				if(data.result=='success'){
					displayFav(data);
				}else{
					alert('좋아요 읽기 오류');
				}
			},
			error:function(){
				alert('네트워크 오류');
			}
		});
	}
	
	//좋아요 등록
	$('#output_fav').click(function(){	
		$.ajax({
			type:'post',
			data:{board_num:$('#board_num').val()},
			url:'writeFav.do',
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(data){
				if(data.result=='logout'){
					alert('로그인 후 좋아요를 눌러주세요!');
				}else if(data.result=='success'){
					displayFav(data);
				}else{
					alert('등록시 오류 발생!');
				}
			},
			error:function(){
				alert('네트워크 오류!');
			}
		});
	});
	
	//좋아요 표시
	function displayFav(data){
		status = data.status;
		var count = data.count;
		var output;
		if(status=='noFav'){
			output = '../resources/images/heart01.png';
		}else{
			output = '../resources/images/heart02.png';
		}			
		//문서 객체에 추가
		$('#output_fav').attr('src',output);
		$('#output_fcount').text(count);
	}
	
	
	//초기 데이터(목록) 호출
	selectData($('#board_num').val());
});