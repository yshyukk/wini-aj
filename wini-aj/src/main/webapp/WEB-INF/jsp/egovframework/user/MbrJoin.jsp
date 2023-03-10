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

<title>회원가입</title>
</head>

<body>	
	<div>아이디<input autocomplete="one-time-code" type="text" id="mbr_id" name="mbr_id"></div>
	<div>비밀번호<input autocomplete="one-time-code" type="text" id="password" name="password"></div>
	<div>이름<input autocomplete="one-time-code" type="text" id="mbr_nm" name="mbr_nm"></div>
	<div>직급<input autocomplete="one-time-code" type="text" id="mbr_pos" name="mbr_pos"></div>
	<div>성별<input autocomplete="one-time-code" type="text" id="mbr_gen" name="mbr_gen"></div>
	<div>전화번호<input autocomplete="one-time-code" type="text" id="mbr_tel" name="mbr_tel"></div>
	<div>이메일<input autocomplete="one-time-code" type="text" id="mbr_email" name="mbr_email"></div>
	<button type="submit" id="insert" onclick="mbrJoin()">등록</button>
	<button type="submit" id="back" onclick="">취소</button>
	
	<script>
	/* 회원가입 */
	function mbrJoin(){
		var mbr_id = $("#mbr_id").val();
		var password = $("#password").val();
		var mbr_nm = $("#mbr_nm").val();
		var mbr_pos = $("#mbr_pos").val();
		var mbr_gen = $("#mbr_gen").val();
		var mbr_tel = $("#mbr_tel").val();
		var mbr_email = $("#mbr_email").val();
				
		if (confirm("등록하시겠습니까?")) {
			if (mbr_id.trim() == ''){
    			alert("아이디를 입력해주세요.");
    		}else if(password.trim() == ''){
    			alert("비밀번호를 입력해주세요.");
    		}else if(mbr_nm.trim() == ''){
    			alert("이름을 입력해주세요.");
    		}else if(mbr_gen.trim() == ''){
    			alert("성별을 입력해주세요.");
    		}else if(mbr_tel.trim() == ''){
    			alert("전화번호를 입력해주세요.");
    		} else {
    			var mbr = {mbr_id : mbr_id
    				     , password : password
    				     , mbr_nm : mbr_nm
    				     , mbr_pos : mbr_pos
    				     , mbr_gen : mbr_gen
    				     , mbr_tel : mbr_tel
    				     , mbr_email : mbr_email}
    			
    			$.ajax({
    				type:'POST', // HTTP 요청 메소드
    				url:"./mbrJoin.do", // URL
    				data: mbr, // 데이터 전달
    				success : function(data) {
    					alert("등록 완료");
    				},
    				error: function(){
    					alert("error");
    				}
    			});
    		}
        } 
	}
	</script>
</body>
</html>