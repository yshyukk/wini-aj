<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<body>
<h4>ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ열렸다구요...ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ</h4>
<div id="wrapepr" style="display:inline-flex; justify-content:space-between; width:100%">
	
	<div id="menu-nav-wrap" style="width:30%;">
	</div>
	
	<div id="mu-frm-wrap" style="width:50%;">
		<form id="mu-frm">
			<div id="mu-info" style="display:flex; flex-direction:column">
				<div>
					<label for="mu_nm">메뉴 이름</label>
					<input id="mu_nm" name="mu_nm">
				</div>
				<div>
				<label for="mu_order">메뉴 순서</label>
					<input id="mu_order" name="mu_order">
				</div>
				<div>
				<label for="mu_desc">메뉴 설명</label>
					<input id="mu_desc" name="mu_desc">
				</div>
				<div>
				<label for="mu_ref">상위 메뉴</label>
					<input id="mu_ref" name="mu_ref">
				</div>
				<div>
					<label for="mu_role">접근 권한</label>
					<select id="mu_role" name="mu_role">
						<option value="-1" selected>권한을 지정해주세요</option>
						<option value="0">관리자</option>
						<option value="1">시스템 관리자</option>
						<option value="2">일반 회원</option>
					</select>
				</div>
				<div>
				<label for="use_yn">사용 여부</label>
					<input type="hidden" id="use_yn" name="use_yn">
					<input type="checkbox" id="chk_useYn">
				</div>
				<div>
				<label for="mu_id">메뉴 id</label>
					<input id="mu_id" name="mu_id">
				</div>
				<div>
				<label for="mu_url">메뉴 주소</label>
					<input id="mu_url" name="mu_url">
				</div>	
			</div>
			<div id="btn-wrap">
				<button type="button" id="reset_btn" onclick="reset('I')">초기화</button>
				<button type="button" id="show_insBtn" onclick="show_insBtn()">등록</button>
				<button type="button" id="ins_btn" onclick="iudFnuction('I')">완료</button>
				<button type="button" id="upd_btn" onclick="iudFnuction('U')">수정</button>
				<button type="button" id="del_btn" onclick="iudFnuction('D')">삭제</button>
			</div>
		</form>
	
	</div>
</div>

<%-- <nav>
	<ul>
		<c:forEach items="${menuInfo.menuList }" var="menuList">
			<c:choose>
				<c:when test="${empty munuList.muRef && menuList.level eq '1'}">
					<li>${menuList.muNm }</li>
					empty
				</c:when>
				<c:otherwise>
				<ul>
					<li>${menuList.muNm }3</li>				
				</ul>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
	</ul>

</nav> --%>
</body>
<script>
	
	$(function(){
		listGrid();
		
		$('#ins_btn').hide();
		
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
	// 메뉴 리스트 조회
	function menuAjax_result_fn(menuInfo){
		var menuList = menuInfo.menuList;
		
		//var appendTag = '<ul id="menuWrap_ul">';		
		var appendTag = '<div id="menu_wrap">';		
		for(var i=0; i < menuList.length; i++){
			
			// i+1번째가 없을 경우 (마지막 데이터 출력하는 조건)
			if( menuList.length-1 == i){
				
				//level이 1이 아니면
				if(menuList[i].level == menuList[i-1].level){ // 이전 레벨과 같은 레벨이면
					appendTag += '<li class="'+menuList[i].level+'">'+menuList[i].muNm+menuList[i].level+'<input type="hidden" value="'+ menuList[i].muSeq +'"></li>';
				}else if(menuList[i].level < menuList[i-1].level){ //이전 레벨보다 작으면(부모)
					appendTag += '<ul><li class="'+menuList[i].level+'">'+menuList[i].muNm+menuList[i].level+'<input type="hidden" value="'+ menuList[i].muSeq +'"></li>';
				}else if(menuList[i].level > menuList[i-1].level){ // 이전 레벨보다 크면(자식)
					//레벨 별로 태그를 닫아야 하기 때문에 
					for(var j=1; j<=menuList[i].level; j++){
						appendTag += '</ul>'
					} 
					
					appendTag += '<ul><li class="'+menuList[i].level+'">'+menuList[i].muNm+menuList[i].level+'<input type="hidden" value="'+ menuList[i].muSeq +'"></li>';
				}

				for(var j=1; j<=menuList[i].level; j++){
					appendTag += '</ul>'
				}
				break;
			}
			// 다음에 올 값과 비교해서 그리기
			if(menuList[i].level == 1){
				//레벨을 시작할 때 <ul>태그 시작
				appendTag += '<ul><li class="'+menuList[i].level+'">'+menuList[i].muNm + menuList[i].level+'<input type="hidden" value="'+ menuList[i].muSeq +'">';
				if(menuList[i+1].level > 1){
					appendTag += '<ul>';
				}
			}else if(menuList[i].level > menuList[i+1].level){ //다음에 올 애가 부모면
				appendTag += '<li class="'+menuList[i].level+'">'+menuList[i].muNm+menuList[i].level+'<input type="hidden" value="'+ menuList[i].muSeq +'"></li>';
				
				//LEVEL만큼 <ul>태그 닫아주기
				for(var j=1; j<=menuList[i].level; j++){
					appendTag += '</ul>'
				}
				
			}else if(menuList[i].level < menuList[i+1].level){ //다음에 올 애가 자식이면
				
				//자식 <ul>태그 열어주기
				appendTag += '<li class="'+menuList[i].level+'">'+menuList[i].muNm+menuList[i].level+'<input type="hidden" value="'+ menuList[i].muSeq +'"></li><ul>';
				
				
			}else if(menuList[i].level == menuList[i+1].level ){
			
				appendTag += '<li class="'+menuList[i].level+'">'+menuList[i].muNm+menuList[i].level+'<input type="hidden" value="'+ menuList[i].muSeq +'"></li>';
				
			}
			
		}
		//appendTag += '</ul>';
		appendTag += '</div>';
	
		$('#menu-nav-wrap').html(appendTag);
		
	}
	
	let muId;
	
	//하위 메뉴 toggle 이벤트
	$(document).on("click","li",function(){
		
		//li를 클릭했을때 하위 해당 최상위 ul태그 아래에 ul태그(자식 level)를 숨기도록
		let target = $(this);
		let TParent = target.parent();
		
		let PclassNm = TParent.attr('class');
		let hideTarget = TParent.find('ul');
		hideTarget.toggle();
		
		//상세조회
		let muSeq = target.find('input[type="hidden"]').val();
		let level = target.attr('class');
		let muRef = target.parent().prev().text();
		console.log(muRef);
		
			$.ajax({
				type: "POST" ,//데이터 전송 타입,
				url : "muDetailInfo.do" ,//데이터를 주고받을 파일 주소 입력,
				data: {
					"muSeq" : muSeq
					},
				dataType:"json",
				success: function(result){
					console.log(result)
					
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
					
					muId = result.muId;
					$('#mu_id').val(muId);
					
					//url추가해야됨
				}
			})
		
	})
	
	//초기화 버튼 이벤트
	function reset(){
		$('#mu-frm')[0].reset();
		
		// 체크박스 값 false로 초기화
		$('#chk_useYn').attr("checked",false);

		//selectbox값도 초기화
		$('#mu_role').val('-1').prop("selected",true);
		
	}
	
	//등록버튼 -> 완료버튼으로
	$('#show_insBtn').click(function(){
		$('#ins_btn').show();
		$('#show_insBtn').hide();
		
		$('#mu-frm')[0].reset();
		$('#mu_id').val(muId);
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
		
		/*$.ajax({
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
						alert("이미 등록된 회사입니다.")
					}else if(result.IUD=="D"){
						alert("해당 회사에 소속된 사원이 있습니다. \n사원 삭제 후 회사를 삭제할 수 있습니다.")
					}
				}else{
					alert("등록 중 오류가 발생했습니다.")
				}
				
				//등록, 삭제일때는 form 리셋
				if(result.IUD != "U"){
					reset();
					listGrid();	
				}
			}
		})*/
	}
	
</script>
</html>