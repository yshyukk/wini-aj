<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<style>
	input{width:200px}
	select{width:200px}
</style>
</head>
<body>
<h3>메뉴관리</h3>
<div id="wrapepr" style="display:inline-flex; justify-content:space-between; width:100%">
	
	<div id="menu-nav-wrap" style="width:30%;">
	</div>
	
	<div id="mu-frm-wrap" style="width:60%;">
		<form id="mu-frm">
			<div id="mu-info" style="display:flex; flex-direction:column">
				<div>
					<label for="mu_nm">메뉴 이름</label>
					<input id="mu_nm" name="muNm">
				</div>
				<div>
				<label for="mu_order">메뉴 순서</label>
					<input id="mu_order" name="muOrder">
				</div>
				<div>
				<label for="mu_desc">메뉴 설명</label>
					<input id="mu_desc" name="muDesc">
				</div>
				<div>
				<label for="mu_ref">상위 메뉴</label>
					<input id="mu_ref" name="muRef" placeholder="최상위메뉴 추가 시 입력금지">
				</div>
				<div>
					<label for="mu_role">접근 권한</label>
					<select id="mu_role" name="muRole">
						<option value="-1" selected>권한을 지정해주세요</option>
						<option value="0">관리자</option>
						<option value="1">시스템 관리자</option>
						<option value="2">일반 회원</option>
					</select>
				</div>
				<div>
				<label for="use_yn">사용 여부</label>
					<input type="hidden" id="use_yn" name="useYn">
					<input type="checkbox" id="chk_useYn">
				</div>
				<div>
				<label for="mu_url">메뉴 주소</label>
					<input id="mu_url" name="muUrl">
				</div>
				<div>
					<input type="hidden" id="mu_seq" name="muSeq">
				</div>
				
			</div>
		</form>
		<div>
			<input type="hidden" id="mu_level" name="mu_level">
		</div>
		<div id="btn-wrap">
			<button type="button" id="reset_btn" onclick="frm_reset()">초기화</button>
			<button type="button" id="show_insBtn">등록</button>
			<button type="button" id="ins_btn" onclick="iudFnuction('I')">완료</button>
			<button type="button" id="upd_btn" onclick="iudFnuction('U')">수정</button>
			<button type="button" id="del_btn" onclick="iudFnuction('D')">삭제</button>
		</div>	
	
	</div>
</div>


</body>
<script>
	
	$(function(){
		listGrid();
		
		$('#ins_btn').hide();
		$('#upd_btn').hide();
		$('#del_btn').hide();
		
	})
	
	function listGrid(){
		$.ajax({
			url : "menuInfo.do",
			method:"POST",
			dataType:"json",
			success:function(result){
				console.log(result)
				menuAjax_result_fn(result);
			}
		})
	}
	
	/************** 메뉴 리스트 조회 ************/
	function menuAjax_result_fn(menuInfo){
		var menuList = menuInfo.menuList;
		
		//var appendTag = '<ul id="menuWrap_ul">';		
		var appendTag = '<div id="menu_wrap">';		
		for(var i=0; i < menuList.length; i++){
			
			// i+1번째가 없을 경우 (마지막 데이터 출력하는 조건)
			if( menuList.length-1 == i){
				
				//level이 1이 아니면
				if(menuList[i].level == menuList[i-1].level){ // 이전 레벨과 같은 레벨이면
					appendTag += '<li class="menu_li">'+menuList[i].muNm
									+'<button class="li_toggle"></button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq 
									+'"><input type="hidden" name="m_level" value="'+ menuList[i].level +'"></li>';
				}else if(menuList[i].level < menuList[i-1].level){ //이전 레벨보다 작으면(부모)
					appendTag += '<ul><li class="menu_li">'+menuList[i].muNm
							  +'<button class="li_toggle">a</button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'
							  + menuList[i].level +'"></li>';
				}else if(menuList[i].level > menuList[i-1].level){ // 이전 레벨보다 크면(자식)
					
					appendTag += '<li class="menu_li">'+menuList[i].muNm
							   +'<button class="li_toggle"></button><input type="hidden" name="m_muSeq" value="'
							   + menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'
							   + menuList[i].level +'"></li>';
				}

				for(var j=1; j<=menuList[i].level; j++){
					appendTag += '</ul>'
				}
				break;
			}
			// 다음에 올 값과 비교해서 그리기
			if(menuList[i].level == 1){
				//레벨을 시작할 때 <ul>태그 시작
				appendTag += '<ul><li class="menu_li">'+menuList[i].muNm 
						   +'<button class="li_toggle" value="b"></button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'+ menuList[i].level +'"></li>';
				if(menuList[i+1].level > 1){
					appendTag += '<ul>';
				}
			}else if(menuList[i].level > menuList[i+1].level){ //다음에 올 애가 부모면
				appendTag += '<li class="menu_li">'+menuList[i].muNm
					       +'<button class="li_toggle"></button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'+ menuList[i].level +'"></li>';
				
				//LEVEL만큼 <ul>태그 닫아주기
				for(var j=1; j<=menuList[i].level; j++){
					appendTag += '</ul>'
				}
				
			}else if(menuList[i].level < menuList[i+1].level){ //다음에 올 애가 자식이면
				
				//자식 <ul>태그 열어주기
				appendTag += '<li class="menu_li">'+menuList[i].muNm
						   +'<button class="li_toggle"></button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'+ menuList[i].level +'"></li><ul>';
				
			}else if(menuList[i].level == menuList[i+1].level ){
			
				appendTag += '<li class="menu_li">'+menuList[i].muNm
						   +'<button class="li_toggle"></button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'+ menuList[i].level +'"></li>';
				
			}
			
		}
		//appendTag += '</ul>';
		appendTag += '</div>';
	
		$('#menu-nav-wrap').html(appendTag);
		
		$('.li_toggle').append('<img class="btn_img" src="images/egovframework/menu/down_arrow.png">');	
		
		
// 		listGrid();
		
	}
	let cnt=1;

	$(document).on("click",".li_toggle",function(){
		
		cnt++;
		
		let img = $(this).find('.btn_img');
		
		console.log("imgbtn",img)
		
		let target = $(this).parent();
		let targetP = target.parent();
		let hideTarget = targetP.find('ul');
		console.log("count",cnt)
		
		console.log("cntCal", cnt%2)
		if(cnt%2 == 0){
			img.attr("src","images/egovframework/menu/up_arrow.png");
		}else{
			img.attr("src","images/egovframework/menu/down_arrow.png");
		}

		hideTarget.toggle();
		
	})
	
	//등록할때 form에 상위 메뉴를 제외하고 나머지 초기화하기 위해 전역으로 선언하고 form을 초기화하는 btn이벤트 후에 이 값을 이용해 상위메뉴 유지	
	let muRef;

	//하위 메뉴 toggle 이벤트 + 상세조회
	$(document).on("click",".menu_li",function(){
		/**/
		muRef = '';
		/*상세정보 조회 후에는 수정, 삭제만 가능하도록*/
		$('#upd_btn').show();
		$('#del_btn').show();
		
	 	let target = $(this);
		
		//상세조회
		let muSeq = target.find('input[name="m_muSeq"]').val();
		let level = target.find('input[name="m_level"]').val();
		
		if(level != 1){
			muRef = target.parent().prev().text();	
		}
		
		//수정,삭제할때 사용하기 위해 form안에 hidden값으로 넣어줌
		$('#mu_seq').val(muSeq);
		
			$.ajax({
				type: "POST" ,//데이터 전송 타입,
				url : "muDetailInfo.do" ,//데이터를 주고받을 파일 주소 입력,
				data: {
					"muSeq" : muSeq
					},
				dataType:"json",
				success: function(result){
					
					$('#mu_nm').val(result.muNm);
					$('#mu_order').val(result.muOrder);
					$('#mu_desc').val(result.muDesc);
					$('#mu_ref').val(muRef);
					//사용여부 checkBox
					if(result.useYn == 'Y'){
						$('#chk_useYn').attr("checked",true);
						$('#use_yn').val(result.useYn);
					}else{
						$('#chk_useYn').attr("checked",false);
					};
					//메뉴권한(select)
					$('#mu_role').val(result.muRole).prop("selected",true);
					
					//url추가해야됨
					$('#mu_url').val(result.muUrl);
					$('#mu_level').val(result.level)
				}
			})
			
			console.log($('#mu_level').val())
			
			$('#ins_btn').hide();
			$('#show_insBtn').show();
		
	})
	
	//초기화 버튼 이벤트
	function frm_reset(){
		$('#ins_btn').hide();
		$('#upd_btn').hide();
		$('#del_btn').hide();
		$('#show_insBtn').show();
		
		$('#mu-frm')[0].reset();
		
		// 체크박스 값 false로 초기화
		$('#chk_useYn').attr("checked",false);

		//selectbox값도 초기화
		
		
	}

	//등록버튼 -> 완료버튼으로
	$('#show_insBtn').click(function(){
		 
		$('#ins_btn').show();
		$('#show_insBtn').hide();
		$('#upd_btn').hide();
		$('#del_btn').hide();
		
		let muNm = $('#mu_nm').val();
		$('#mu-frm')[0].reset();
		
		//단건조회할때 hidden으로 level값 저장
		var level = $('#mu_level').val();
	
		$('#mu_ref').val(muNm);	
	
		
	})

	/**********************************************************
	 *******************  menuIUD  ****************************
	 ***********************************************************/
	
	function iudFnuction(iud){
		
	  let conf_word;
	  if(iud == "I")conf_word="등록";
	  if(iud == "U")conf_word="수정";
	  if(iud == "D")conf_word="삭제";
	  
	  /***등록버튼을 누르면 ***/
	  if(confirm(conf_word +" 하시겠습니까?")){
		//체크박스 체크 여부에 따라 저장할 데이터 변경하기 
		  let checkStat = $('#chk_useYn').is(":checked")?"Y":"N";
		  $('#use_yn').val(checkStat)
		  
		  let data = $('#mu-frm').serialize();
		  
		  //IUD값 같이 보내기
		  data += "&IUD="+iud;
		  
		  //iud ajax함수 실행
		  iud_ajax(data)
		  
	 	}
	  }
	 
	// iud_ajax 함수
	function iud_ajax(data){
		console.log(data);
		
		 $.ajax({
			type: "POST" ,//데이터 전송 타입,
			url : "./menuIUD.do" ,//데이터를 주고받을 파일 주소 입력,
			data: data,//보내는 데이터,
			dataType:"json",
			success: function(result){				
				console.log(result)
				if(result.msg == "success"){
					
					if(result.IUD == "I"){
						alert('등록이 완료되었습니다.')
					}else if(result.IUD == "U"){
						alert('수정이 완료되었습니다.')
					}else if(result.IUD == "D"){
						alert('삭제가 완료되었습니다.')
					}
					
				}else if(result.msg == "fail"){
					
					if(result.IUD=="I"){
						alert("이미 등록된 메뉴이름 입니다.")
					}else if(result.IUD=="D"){
						alert("하위메뉴가 존재합니다. \n 하위메뉴 삭제 후 메뉴를 삭제할 수 있습니다.")
					}
				}else if(result.msg == "levelCheck"){
						alert("더 이상 메뉴를 추가할 수 없습니다.")	
				}else{
					alert("등록 중 오류가 발생했습니다.")
				}
				
				listGrid();	

				//등록, 삭제일때는 form 리셋
				if(result.IUD != "U"){
					frm_reset();
				}
			}
		}) 
	}
	

	
</script>
</html>