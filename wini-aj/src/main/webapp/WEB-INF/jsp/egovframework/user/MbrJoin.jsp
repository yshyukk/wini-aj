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
	<div>아이디* 
		<input autocomplete="one-time-code" type="text" id="mbr_id" name="mbr_id">
		<button type="submit" onclick="idCheck()">중복확인</button>
	</div>
	<div>비밀번호* <input autocomplete="one-time-code" type="password" id="password" name="password"> 비밀번호는 공백 없이 8~16자로 영문, 숫자, 특수문자를 포함해 주세요.</div>
	<div>비밀번호 확인* <input autocomplete="one-time-code" type="password" id="confirm_password" name="password"></div>
	<div>이름* <input autocomplete="one-time-code" type="text" id="mbr_nm" name="mbr_nm"></div>
	<div>성별 
		<input type="radio" value="F" id="mbr_gen" name="mbr_gen">여자
		<input type="radio" value="M" id="mbr_gen" name="mbr_gen">남자
	</div>
	<div>전화번호 <input autocomplete="one-time-code" type="text" id="mbr_tel" name="mbr_tel"> '-'없이 숫자만 입력해 주세요.</div>
	<div>이메일 <input autocomplete="one-time-code" type="text" id="mbr_email" name="mbr_email"></div>
	<button type="submit" id="insert" onclick="mbrJoin()">등록</button>
	<button type="submit" id="back" onclick="">취소</button>
	
	<script>
	/* 회원가입 */
	function mbrJoin(){
		var mbr_id = $("#mbr_id").val(); 							// 아이디
		var password = $("#password").val(); 						// 비밀번호
		var confirm_password = $("#confirm_password").val();		// 비밀번호 확인
		var mbr_nm = $("#mbr_nm").val(); 							// 이름
		var mbr_gen = $('input[name=mbr_gen]:checked').val(); 		// 성별
		var mbr_tel = $("#mbr_tel").val(); 							// 전화번호
		var mbr_email = $("#mbr_email").val(); 						// 이메일	
			
		if(mbr_id.trim() == ''){
   			alert("아이디를 입력해주세요.");
   		}else if(password.trim() == ''){
   			alert("비밀번호를 입력해주세요.");
   		}else if(!passwordCheck(password)){
   			alert("비밀번호의 형식이 맞지 않습니다.");
   		}else if(password != confirm_password){
   			alert("비밀번호가 일치하지 않습니다.");
   		}else if(mbr_nm.trim() == ''){
   			alert("이름을 입력해주세요.");
   		}else {
   			if (confirm("회원가입을 신청하시겠습니까?")) {
	 			var mbr = {mbr_id : mbr_id
	 				     , password : password
	 				     , mbr_nm : mbr_nm
	 				     , mbr_gen : mbr_gen
	 				     , mbr_tel : mbr_tel
	 				     , mbr_email : mbr_email}
	 			
	 			$.ajax({
	 				type:'POST',
	 				url:"./mbrJoin.do",
	 				data: mbr,
	 				success : function(data) {
	 					alert("신청 완료");
	 					location.href='/wini-aj'  
	 				},
	 				error: function(){
	 					alert("error");
	 				}
	 			});
   			}
   		}
	}
	
	/* 아이디 중복체크 */
	function idCheck() {
		var mbr_id = $("#mbr_id").val();	// 아이디
		
		$.ajax({
			url: "./idCheck.do",
			type: 'post',
			data: {'mbr_id' : mbr_id},
			dataType: 'json',
			success: function(result){
	            if(result == 1){
	            	alert("중복된 아이디입니다.")
	            } else {
	            	alert("사용 가능한 아이디입니다.")
	            }          
			}, 
			error: function(){
				alert("error");
			}
		});
	}
	
	/* 비밀번호 형식(공백 없이 영문, 숫자, 특수문자 포함 8~13자) */
	function passwordCheck(password){
		var num = password.search(/[0-9]/g);
		var eng = password.search(/[a-z]/ig);
		var spe = password.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

	 	if(password.length < 8 || password.length > 20){
		    return false;
		}else if(password.search(/\s/) != -1){
		    return false;
		}else if(num < 0 || eng < 0 || spe < 0 ){
		    return false;
		}else {
		    return true;
		}
	}
	
	/* 전화번호 형식 */
/* 	function telCheck(mbr_tel){
		var num = mbr_tel.search(/[0-9]/g);

	 	if(password.length < 10 || mbr_tel.length > 11){
		    return false;
		}else if(!reg.test(mbr_tel)){
		    return false;
		}else {
		    return true;
		}
	} */
	</script>
</body>
</html>