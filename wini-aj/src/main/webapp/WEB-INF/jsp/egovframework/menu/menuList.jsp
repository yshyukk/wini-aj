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
	li{width:fit-content}
	input{width:200px}
	select{width:200px}
	#menu_wrap{border:1px solid lightgray}
	.li_toggle{background-color:transparent; border:none}
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
					<label for="mu_id">메뉴ID</label>
					<input id="mu_id" name="muId">
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
		
		//페이지 로드 시  등록완료, 수정, 삭제버튼 안보이게 
		$('#ins_btn').hide();
		$('#upd_btn').hide();
		$('#del_btn').hide();
		
	})
	
	/************메뉴 리스트 조회 AJAX************/
	function listGrid(){
		$.ajax({
			url : "menuInfo.do",
			method:"POST",
			dataType:"json",
			success:function(result){
				menuAjax_result_fn(result);
			}
		})
	}
	
	/************** 메뉴 리스트 출력 ************/
	
	function menuAjax_result_fn(menuInfo){
		
		var menuList = menuInfo.menuList;
		var appendTag = '<div id="menu_wrap">';		
		
		for(var i=0; i < menuList.length; i++){
			
			// i+1번째가 없을 경우 (마지막 데이터 출력하는 조건)
			if( menuList.length-1 == i){
				
				//level이 1이 아니면
				if(menuList[i].level == menuList[i-1].level){ // 이전 레벨과 같은 레벨이면
					appendTag += '<li id="'+ menuList[i].muId + '" class="menu_li">'+menuList[i].muNm
									+'<button class="li_toggle"></button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq 
									+'"><input type="hidden" name="m_level" value="'+ menuList[i].level +'"></li>';
				}else if(menuList[i].level < menuList[i-1].level){ //이전 레벨보다 작으면(부모)
					appendTag += '<ul><li id="'+ menuList[i].muId + '" class="menu_li">'+menuList[i].muNm
							  +'<button class="li_toggle">a</button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'
							  + menuList[i].level +'"></li>';
				}else if(menuList[i].level > menuList[i-1].level){ // 이전 레벨보다 크면(자식)
					
					appendTag += '<li id="'+ menuList[i].muId + '" class="menu_li">'+menuList[i].muNm
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
				appendTag += '<ul><li id="'+ menuList[i].muId + '" class="menu_li">'+menuList[i].muNm 
						   +'<button class="li_toggle" value="b"></button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'+ menuList[i].level +'"></li>';
				if(menuList[i+1].level > 1){
					appendTag += '<ul>';
				}else if(menuList[i+1].level == 1){
					appendTag +='</ul>'
				}
			}else if(menuList[i].level > menuList[i+1].level){ //다음에 올 애가 상위LEVEL이면(부모)면
				appendTag += '<li id="'+ menuList[i].muId + '" class="menu_li">'+menuList[i].muNm
					       +'<button class="li_toggle"></button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'+ menuList[i].level +'"></li>';
				
				//LEVEL만큼 <ul>태그 닫아주기
				for(var j=1; j<=menuList[i].level; j++){
					appendTag += '</ul>'
				}
				
			}else if(menuList[i].level < menuList[i+1].level){ //다음에 올 애가 하위LEVEL(자식)이면
				
				//자식 <ul>태그 열어주기
				appendTag += '<li id="'+ menuList[i].muId + '" class="menu_li">'+menuList[i].muNm
						   +'<button class="li_toggle"></button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'+ menuList[i].level +'"></li><ul>';
				
			}else if(menuList[i].level == menuList[i+1].level ){ //다음에 올 애가 동일 LEVEL이면
			
				appendTag += '<li id="'+ menuList[i].muId + '" class="menu_li">'+menuList[i].muNm
						   +'<button class="li_toggle"></button><input type="hidden" name="m_muSeq" value="'+ menuList[i].muSeq +'"><input type="hidden" name="m_level" value="'+ menuList[i].level +'"></li>';
			}
		}
		appendTag += '</div>';
	
		$('#menu-nav-wrap').html(appendTag);
		
		//하위 LEVEL열어줄 버튼에 이미지 추가
		$('.li_toggle').append('<img class="btn_img" src="images/egovframework/menu/down_arrow.png">');	
		
	}
	
	//버튼 이미지를 바꿔주기위해서 전역으로 변수 선언 (짝수: up, 홀수:down)
	let cnt=1;
	
	/************ 하위 메뉴 toggle 이벤트 **************/
	$(document).on("click",".li_toggle",function(){
		
		cnt++;
		
		//클릭한 태그 선택
		let img = $(this).find('.btn_img');
		
		//태그 위치를 이용해 하위 메뉴를 시작하는 ul을 선택해서 toggle
		let target = $(this).parent();
		let targetP = target.parent();
		let hideTarget = targetP.find('ul');
		
		if(cnt%2 == 0){
			img.attr("src","images/egovframework/menu/up_arrow.png");
		}else{
			img.attr("src","images/egovframework/menu/down_arrow.png");
		}

		hideTarget.toggle();
	})
	
	//등록할 때 form에 상위 메뉴를 제외하고 나머지 초기화하기 위해 전역으로 선언하고 form을 초기화하는 btn이벤트 후에 이 값을 이용해 상위메뉴(muRef) 유지	
	var muRef;
	
	/*자식메뉴를 생성할때 자식의 메뉴 id를 자동으로 부여할 때 뒤에 붙여주는 숫자로 사용하기 위해 
	* 클릭 했을 때 정보를 전역으로 저장해놓기 위해서 전역으로 선언	
	*/
	var muIdCnt;
	/******************상세조회******************/
	$(document).on("click",".menu_li",function(){
		
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
				type: "POST" ,
				url : "muDetailInfo.do" ,
				data: {
					"muSeq" : muSeq
					},
				dataType:"json",
				success: function(result){
					
					$('#mu_nm').val(result.muNm);
					$('#mu_order').val(result.muOrder);
					$('#mu_desc').val(result.muDesc);
					$('#mu_ref').val(result.muRef);
					
					//사용여부 checkBox
					if(result.useYn == 'Y'){
						$('#chk_useYn').attr("checked",true);
						$('#use_yn').val(result.useYn);
					}else{
						$('#chk_useYn').attr("checked",false);
					};
					
					//메뉴권한(select태그)
					$('#mu_role').val(result.muRole).prop("selected",true);
					$('#mu_url').val(result.muUrl);
					$('#mu_level').val(result.level)
					
					//muId추가
					$('#mu_id').val(result.muId);
					
				}	
			})
			$('#ins_btn').hide();
			$('#show_insBtn').show();
			
			var targetLi = $(this);
			
			/*해당 메뉴(li)의 자식들을 담은 ul은 바로 아래에 붙기 때문에 next로 선택하고
			* 자식의 갯수만큼 하위메뉴아이디에 숫자를 넣어주기
			*/
			muIdCnt = targetLi.next().children('li').length;
				
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
	}

	//등록버튼 -> 완료버튼으로
	$('#show_insBtn').click(function(){
		 
		$('#ins_btn').show();
		$('#show_insBtn').hide();
		$('#upd_btn').hide();
		$('#del_btn').hide();
		
		//하위 태그의 mu_id를 자동 생성할 때 상위 mu_id에 값을 붙여 사용하기 위해 
		
		let muId = $('#mu_id').val();
		
		$('#mu-frm')[0].reset();
		
	
		//단건조회할때 hidden으로 level값 저장
		var level = $('#mu_level').val();
		
		$('#mu_ref').val(muId);
		
		//만약에 상위태그의 정보가 없어서 cnt를 셀수 없을때 메뉴 ID값 비워주기
		if(muIdCnt == undefined){
			$('#mu_id').val('');	
		}else{
			var plus = muIdCnt +1;
			
			$('#mu_id').val(muId+'_'+plus);
			
		}
	})

	/********* menuIUD *********/

	function iudFnuction(iud){
	
		var muNm = $('#mu_nm');
		var muOrder = $('#mu_order');
		var muDesc = $('#mu_desc');
		var muRef = $('#mu_ref');
		var muRole = $('#mu_role');
		var muId = $('#mu_id');

		if($.trim(muNm.val()) == ''){
			  alert('메뉴 이름을 입력해주세요')
			  muNm.focus();
			  return false;
		};
		if(muNm.val().length > 20){
			  alert('메뉴 이름은 최대 20글자 까지 입력 가능합니다.')
			  muNm.focus();
			  return false;
		};
		if(muDesc.val().length > 20){
			  alert('메뉴 설명은 최대 20글자 까지 입력 가능합니다.')
			  muDesc.focus();
			  return false;
		};
		if($.trim(muOrder.val()) == ''){
			  alert('메뉴 순서를 지정해 주세요')
			  muOrder.focus();
			  return false;
		};
		if($.trim(muRef.val()) == ''){
			  alert('상위메뉴가 없으면 최상위 메뉴로 추가됩니다.')
		};
		if(muRole.val() == -1){
			  alert('접근 권한을 설정해주세요')
			   muRole.focus();
			  return false;
		};
		if($.trim(muId.val()) == ''){
			  alert('메뉴 ID를 입력해주세요')
			  muId.focus();
			  return false;
		};
			
		
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
	 
	// iud를 실행하는 ajax
	function iud_ajax(data){	
			
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
					
				}else if(result.msg == "checkErr"){
					
					if(result.IUD=="I" || result.IUD=="U" ){
						alert("이미 등록된 메뉴이름 입니다.")
					}else if(result.IUD=="D"){
						alert("하위메뉴가 존재합니다. \n 하위메뉴 삭제 후 메뉴를 삭제할 수 있습니다.")
					}
				}else{
					alert("등록 중 오류가 발생했습니다.")
				}
				
				listGrid();
				navGrid();

				//등록, 삭제일때는 완료 후 form 리셋
				if(result.IUD != "U"){
					frm_reset();
				}
			}
		}) 
	}
	
</script>
</html>