<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>wini-aj</title>
</head>
<body>
	<button onclick="location.href='equipmain.do'">장비관리</button>
	<button onclick="location.href='equipMgrmain.do'">장비점검관리</button>
	<button onclick="location.href='equipStatics.do'">장비사용현황 통계</button>
	<button id="user" onclick="location.href='mbrAuthority.do'">사용자 권한 관리</button>
	<button onclick="location.href='myPage.do'">마이페이지</button>
	<button onclick="location.href='mbrLogout.do'">로그아웃</button>
</body>

<script>
	/* 일반 사용자일 경우 사용자 권한 관리 버튼 숨김 */
	$(function(){
		if(${mbr_type} == 2){
			$("#user").hide();
		}else{
			$("#user").show();
		}
	})
</script>
</html>