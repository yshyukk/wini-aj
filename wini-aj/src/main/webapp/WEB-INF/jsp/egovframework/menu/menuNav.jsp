<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

</head>
<body>
	<div id="nav-wrap" style="width:30%;">
	</div>

</body>
<style>
	#nav_container{display:flex};
</style>
<script>

$(function(){
	navGrid();		
})

function navGrid(){
	$.ajax({
		url : "menuInfo.do",
		method:"POST",
		dataType:"json",
		success:function(result){
			console.log(result)
			menuNavAjax_result_fn(result);
		}
	})
}
// 메뉴 리스트 조회
function menuNavAjax_result_fn(menuInfo){
	var menuList = menuInfo.menuList;
	
	//var appendTag = '<ul id="menuWrap_ul">';		
	var appendTag = '<div id="nav_container">';		
	for(var i=0; i < menuList.length; i++){
		console.log("!!!", menuList[i].muUrl)
		// i+1번째가 없을 경우 (마지막 데이터 출력하는 조건)
		if( menuList.length-1 == i){
			
			//level이 1이 아니면
			if(menuList[i].level == menuList[i-1].level){ // 이전 레벨과 같은 레벨이면
				appendTag += '<li class="nav_li" onclick="move_page('+ menuList[i].muUrl +')">'+ menuList[i].muNm+'</li>';
			}else if(menuList[i].level < menuList[i-1].level){ //이전 레벨보다 작으면(부모)
				appendTag += '<ul><li class="nav_li" onclick="move_page('+menuList[i].muUrl +')">'+menuList[i].muNm +'"</li>';
			}else if(menuList[i].level > menuList[i-1].level){ // 이전 레벨보다 크면(자식)
				//레벨 별로 태그를 닫아야 하기 때문에 
				/* for(var j=1; j<=menuList[i].level; j++){
					appendTag += '</ul>'
				}  */
				
				appendTag += '<li class="nav_li" onclick="move_page('+menuList[i].muUrl +')">'+menuList[i].muNm+'</li>';
			}

			for(var j=1; j<=menuList[i].level; j++){
				appendTag += '</ul>'
			}
			break;
		}
		// 다음에 올 값과 비교해서 그리기
		if(menuList[i].level == 1){
			//레벨을 시작할 때 <ul>태그 시작
			appendTag += '<ul><li class="nav_li" onclick="move_page('+menuList[i].muUrl +')">'+menuList[i].muNm+'</li>';
			if(menuList[i+1].level > 1){
				appendTag += '<ul>';
			}
		}else if(menuList[i].level > menuList[i+1].level){ //다음에 올 애가 부모면
			appendTag += '<li class="nav_li" onclick="move_page('+menuList[i].muUrl +')">'+menuList[i].muNm+'</li>';
			
			//LEVEL만큼 <ul>태그 닫아주기
			for(var j=1; j<=menuList[i].level; j++){
				appendTag += '</ul>'
			}
			
		}else if(menuList[i].level < menuList[i+1].level){ //다음에 올 애가 자식이면
			
			//자식 <ul>태그 열어주기
			appendTag += '<li class="nav_li" onclick="move_page('+menuList[i].muUrl +')">'+menuList[i].muNm+'</li><ul>';
			
			
		}else if(menuList[i].level == menuList[i+1].level ){
		
			appendTag += '<li class="nav_li" onclick="move_page('+menuList[i].muUrl +')">'+menuList[i].muNm+'</li>';
			
		}
		
	}
	appendTag += '</div>';

	$('#nav-wrap').html(appendTag);
	}

$(document).on("click",".nav_li",function(){
	let target = $(this).parent();
// 	console.log(target)
	let targetP = target.parent();
	let hideTarget = target.find('ul');
	
	hideTarget.toggle();
	
})

function move_page(url){
	var test = "'";
// 	if(url == null){
// 		alert("주소없음");		
// 	}else{
		
		location.href =  url;
	
}




</script>
</html>