<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="wrap">
	    <div id="nav"><tiles:insertAttribute name="header"/></div>
	    <div id="body"><tiles:insertAttribute name="body"/></div>
	</div>
</body>
</html>