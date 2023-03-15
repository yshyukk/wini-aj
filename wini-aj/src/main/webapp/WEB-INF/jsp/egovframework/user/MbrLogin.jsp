<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset=UTF-8>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<title>로그인</title>
<style>
	#loginCol {
		border: 1px solid black;
	    padding: 10px;
	    width: 300px;
	    text-align: center;
	}
	#loginCol button {
		margin: 15px;
	    width: 70px;
	    height: 30px;
	}
</style>
</head>

<body>
	<h3>wini-aj</h3>
	<div id="loginCol">
		<div>아이디 <input autocomplete="one-time-code" type="text" id="mbr_id" name="mbr_id"></div>
		<div>비밀번호 <input autocomplete="one-time-code" type="password" id="password" name="password"></div>
		
		<button type="submit" id="insert" onclick="mbrLogin()">로그인</button>
		<button type="submit" id="back" onclick="location.href='/wini-aj/join.do'">회원가입</button>
	</div>
	<script>
	/* 로그인 */
	function mbrLogin() {	
		
		var mbr_id = $("#mbr_id").val();			// 아이디
		var password = $("#password").val();		// 비밀번호
		
		if(mbr_id.trim() == ''){
			alert("아이디를 입력해주세요.");
		}else if(password.trim() == ''){
			alert("비밀번호를 입력해주세요.");
		}else{
			var login = {mbr_id : mbr_id
				       , password : password}
			
			$.ajax({
				type: 'POST',
				url: "./mbrLogin.do",
				data: login,
				dataType: 'json',
				success: function(result){
					// 회원가입 승인 확인
					if(result.mbr_type == 3){
						alert("회원가입 승인 대기중입니다.")
						location.href='/wini-aj/login.do';
					}else if(result.use_yn == "N"){
						alert("탈퇴한 회원입니다.")
						location.href='/wini-aj/login.do';
					}
					else{
						location.href='/wini-aj/main.do';
					}
	           
				}, 
				error: function(){
					alert("아이디 또는 비밀번호를 확인해주세요.");
				}
			});
		}
	}
	</script>
</body>
</html>