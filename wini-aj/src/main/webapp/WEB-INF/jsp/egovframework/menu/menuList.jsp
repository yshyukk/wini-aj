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
<div id="menu-nav-wrap">
	

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
	
	function menuAjax_result_fn(menuInfo){
		var menuList = menuInfo.menuList;
		
		var appendTag = '<ul id="menuWrap_ul">';		
		
		for(var i=0; i <= menuList.length; i++){
		
			if(i == menuList.length){
				break;
			}
			
			if(menuList[i].level == 1){
				appendTag += '<ul><li>' + menuList[i].muNm + menuList[i].level +'<input type="hidden" class="hid_muId" value="'+menuList[i].muId+'"></li>'
			}else if(menuList[i].level == menuList[i+1].level){
				appendTag += '<li>' + menuList[i].muNm + menuList[i].level +'<input type="hidden" class="hid_muId" value="'+menuList[i].muId+'"></li>
			}else if(menuList[i].level > menuList[i+1].level){ // 현재 값이 자식이면
				
			}
			
		
		
			
			
			/* if(menuList[i].level == 1){
			
				appendTag += '<ul><li>' + menuList[i].muNm + menuList[i].level +'</li>'
			
			} else if(menuList[i].level = menuList[i+1].level){ //출력할 애가 자식라면
			
				appendTag += '<li>' + menuList[i].muNm + menuList[i].level +'</li>'
			
			} else if(menuList[i].level > menuList[i+1].level){ //출력할 애가 자식라면}
			
				appendTag += '<li>' + menuList[i].muNm + menuList[i].level +'</li><ul>'
				for(var j=1; j<menuList[i].level - menuList[i+1].level; j++){
					appendTag += '</ul>'
				}
			
			} else if(menuList[i].level < menuList[i+1].level){ //출력할 애가 부모라면}
				appendTag += '<li>' + menuList[i].muNm + menuList[i].level +'</li><ul>'
			}
		 */
			
			
			/* if(i+1 != menuList.length){
				if(menuList[i].level == 1){
					appendTag += '<ul><li>' + menuList[i].muNm + menuList[i].level +'</li>'
				}else if(menuList[i].level > menuList[i+1].level){ //출력할 애가 자식라면
					
					appendTag += '<ul><li>'+ menuList[i].muNm + menuList[i].level + '</li>'
					//appendTag += '</ul><li onclick="showMenu();">' + menuList[i].muNm + '</li>'
				}else if(menuList[i].level < menuList[i+1].level){ //출력할 애가 부모이라면
					appendTag += '<ul><li>' + menuList[i].muNm + menuList[i].level + '</li>'
				}else{ //출력할 애가 같다면
					appendTag += '<li>' + menuList[i].muNm + menuList[i].level +'</li>'
				}
			}  */
					
		}		
		appendTag += '</ul>';
		
		$('#menu-nav-wrap').html(appendTag);
		

	}
	
	
	function showMenu(){
		
		var target = $(this).children('ul');
		target.children('.child-ul').toggle();
		console.log("123",target.children('.child-ul'))
		console.log("::",target)
	}	
	
</script>
</html>