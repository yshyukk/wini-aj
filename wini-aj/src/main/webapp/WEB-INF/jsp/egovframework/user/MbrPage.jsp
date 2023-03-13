<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset=UTF-8>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<title>마이페이지</title>
</head>

<body>	
	<div>아이디 <input autocomplete="one-time-code" type="text" id="mbr_id" name="mbr_id"></div>
	<div>비밀번호 <input autocomplete="one-time-code" type="password" id="password" name="password"></div>
	<div>이름 <input autocomplete="one-time-code" type="text" id="mbr_nm" name="mbr_nm"></div>
	<div>
		성별
		<input type="radio" value="F" id="mbr_f" name="mbr_f">여자
		<input type="radio" value="M" id="mbr_m" name="mbr_m">남자
	</div>
	<div>전화번호 <input autocomplete="one-time-code" type="text" id="mbr_tel" name="mbr_tel"></div>
	<div>이메일 <input autocomplete="one-time-code" type="text" id="mbr_email" name="mbr_email"></div>	
	
	<button type="submit" onclick="mbrUpdate()">정보 수정</button>
	<button type="submit" onclick="location.href='/wini-aj/mbrDelete.do'">회원 탈퇴</button>
	
	<script>
	$(document).ready(function () {
		mbrPage();
	});
	
	/* 회원 조회 */
	function mbrPage() {	
		var mbr_sn = ${sessionScope.mbr_sn};	// 회원 번호
		
		$.ajax({
			url: "./mbrPage.do",
			type: 'post',
			data: {'mbr_sn' : mbr_sn},
			dataType: 'json',
			success: function(result){
				$("#mbr_id").val(result.mbr_id);
	            $("#password").val(result.password);
	            $("#mbr_nm").val(result.mbr_nm);
	            $("#mbr_tel").val(result.mbr_tel);
	            $("#mbr_email").val(result.mbr_email);        
	          
	            if(result.mbr_gen == 'F'){
	            	$("#mbr_f").prop("checked", true);
	            } else {	
	            	$("#mbr_m").prop("checked", true);
	            }     
			}, 
			error: function(){
				alert("error"); // 요청 실패했을 때 실행할 함수
			}
		});
	}
	
	/* 회원 수정 */
	function mbrUpdate(){
		var mbr_nm = $("#mbr_nm").val(); 			// 이름
		var mbr_tel = $("#mbr_tel").val(); 			// 전화번호
		var mbr_email = $("#mbr_email").val(); 		// 이메일
		
		var mbrUpdate = {mbr_nm : mbr_nm,
						 mbr_tel : mbr_tel, 
						 mbr_email : mbr_email}
		
		if (confirm("수정하시겠습니까?")) {
        	$.ajax({
       			type:'POST',
       			url:"./mbrUpdate.do",
       			data: mbrUpdate,
       			dataType : 'text',
       			success : function(data) {
       				alert("수정 완료");
       				mbrPage();
       			},
       			error: function(){
       				alert("error");
       			}
       		});
        }   
    }	
	</script>
</body>
</html>