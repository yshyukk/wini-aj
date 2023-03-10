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

<title>로그인</title>
</head>

<body>	
	<div>아이디 <input autocomplete="one-time-code" type="text" id="mbr_id" name="mbr_id"></div>
	<div>비밀번호 <input autocomplete="one-time-code" type="password" id="password" name="password"></div>
	
	<button type="submit" id="insert" onclick="mbrLogin()">로그인</button>
	<button type="submit" id="back" onclick="location.href='/wini-aj/join.do'">회원가입</button>
	
	<script>
	function mbrLogin() {	
		
		var mbr_id = $("#mbr_id").val();
		var password = $("#password").val();
		
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
					location.href='/wini-aj/main.do'           
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