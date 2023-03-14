<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset=UTF-8>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<title>마이페이지</title>
</head>

<body>	
	<div>회원 번호 <input autocomplete="one-time-code" type="text" id="mbr_sn" name="mbr_sn" disabled></div>
	<div>아이디 <input autocomplete="one-time-code" type="text" id="mbr_id" name="mbr_id" disabled></div>
	<div>이름 <input autocomplete="one-time-code" type="text" id="mbr_nm" name="mbr_nm" disabled></div>
	<div>성별 <input autocomplete="one-time-code" type="text" id="mbr_gen" name="mbr_gen" disabled></div>
	<div>전화번호 <input autocomplete="one-time-code" type="text" id="mbr_tel" name="mbr_tel"></div>
	<div>이메일 <input autocomplete="one-time-code" type="text" id="mbr_email" name="mbr_email"></div>	
	<button type="submit" onclick="mbrUpdate()">정보 수정</button>
	<button type="submit" onclick="mbrDelete()">회원 탈퇴</button>
	
	<script>
	$(document).ready(function () {
		mbrPage();
	});
	
	/* 회원 조회 */
	function mbrPage() {	
		var mbr_sn = ${sessionScope.mbr_sn};		// 회원 번호
		
		$.ajax({
			url: "./mbrPage.do",
			type: 'post',
			data: {'mbr_sn' : mbr_sn},
			dataType: 'json',
			success: function(result){
				$("#mbr_sn").val(result.mbr_sn);
				$("#mbr_id").val(result.mbr_id);
	            $("#password").val(result.password);
	            $("#mbr_nm").val(result.mbr_nm);
	            $("#mbr_tel").val(result.mbr_tel);
	            $("#mbr_email").val(result.mbr_email);   
	          
	            if(result.mbr_gen == 'F'){
	            	$("#mbr_gen").val('여자');
	            } else {	
	            	$("#mbr_gen").val('남자');
	            }     
			}, 
			error: function(){
				alert("error");
			}
		});
	}
	
	/* 회원 수정 */
	function mbrUpdate(){
		var mbr_tel = $("#mbr_tel").val(); 			// 전화번호
		var mbr_email = $("#mbr_email").val(); 		// 이메일
		
		var mbrUpdate = {mbr_tel : mbr_tel, 
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
	
	/* 회원 탈퇴 */
	function mbrDelete(){
		if (confirm("탈퇴하시겠습니까?")){
			location.href="/wini-aj/mbrDelete.do";
		}
	}
	</script>
</body>
</html>