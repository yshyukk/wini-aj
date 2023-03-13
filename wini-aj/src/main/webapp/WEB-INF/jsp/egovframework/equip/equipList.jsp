<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<title>장비 목록</title>
<style>
	table, td{
		border : 1px solid black;
	}
	#typeTable{
		width : 500px;
	}
	
	tr:hover{
		background-color : lightgrey;
	}
	table .toptr{
		background-color : white;
	}
</style>
</head>
<body>

<c:import url="../menu/menuNav.jsp"></c:import>

	<h1>장비목록 페이지</h1>
	<div id="eqpType"></div>
	<div id="eqpList"></div>


<script>
$(function(){
	equipType();
	equipList();
})

/* 장비 종류 조회 */
	function equipType(){
	var text = "";
		$.ajax({
			type : "post",
			dataType : "json",
			url : "./equipType.do",
			success:function(data){
				text +="<table id='typeTable'>";
				text +=	"<tr class='toptr'>";
				text +=		"<th>장비코드</th>";
				text +=		"<th>장비종류</th>";
				text +=		"<th>등록일</th>";
				text +=	"</tr>";
				for(var i = 0 ; i < data.length; i++){
					text +=	"<tr onclick='equipList("+(i+1)+")'>";
					text += "<td>"+data[i].eqpCode+"</td>";
					text += "<td>"+data[i].eqpType+"</td>";
					text += "<td>"+data[i].regDt+"</td>";
					text +=	"</tr>";
				}
				for(var j=0; j<(10-data.length); j++){
					text +=	"<tr>";
					text += "<td>-</td>";
					text += "<td>-</td>";
					text += "<td>-</td>";
					text +=	"</tr>";
				}
				text += "<tr id='addTypeCol'></tr>";
				text +="</table>";
				text += "<button onclick='addType()'>추가</button>";
				
				
				$("#eqpType").html(text);
			}, 
			error : function(){
				alert("실패");
			}
		});
	}
	
/* 장비 종류 추가 */
	function addType(){
	var text ="";
	text += 	"<td><input value='번호(자동부여)' readonly/></td>";
	text += 	"<td><input id='addTypeNm'/></td>";
	text += 	"<td><button onclick='submitType()'>생성</button>";
	text += 	"<button onclick='cacelType()'>취소</button></td>";
	$("#addTypeCol").html(text);
}

/* 장비 종류 추가 확인 */
	function submitType(){
		var sendData = {
				addTypeNm : $("#addTypeNm").val()
		}
		if(confirm("등록하시겠습니까?")){
			$.ajax({
				type : "post",
				url : "./addEquipType.do",
				data : sendData,
				success:function(){
						alert("등록되었습니다.");
						equipType();
					}
				});
		}
	}
	
/* 장비 종류 추가 취소 */
	function cacelType(){
		var cancel ="";
		$("#addTypeCol").html(cancel);
	}
	
/* 장비 목록 조회 */
	function equipList(typeNum){
		var sendData = {
				typeNum : typeNum
		}
		var text = "";
		$.ajax({
			type : "post",
			dataType : "json",
			url : "./equipList.do",
			data : sendData,
			success:function(data){
				text +="<table>";
				if(data.length == 0){
					text += "<tr><td colspan='4'>조회된 데이터가 없습니다.</td></tr>";
				} else if (data.length != 0){
					text +=	"<tr class='toptr'>";
					text +=		"<th>번호</th>";
					text +=		"<th>장비명</th>";
					text +=		"<th>장비 S/N</th>";
					text +=		"<th>배부여부</th>";
					text +=		"<th>수리여부</th>";
					text +=	"</tr>";
					
					for(var i = 0 ; i < data.length; i++){
						text +=	"<tr>";
						text += "<td>"+data[i].eqpSn+"</td>";
						text += "<td>"+data[i].eqpNm+"</td>";
						text += "<td>"+data[i].eqpNo+"</td>";
						text += "<td>"+data[i].dstYn+"</td>";
						text += "<td>"+data[i].repairYn+"</td>";
						text +=	"</tr>";
					}
					for(var j=0; j<(10-data.length); j++){
						text +=	"<tr>";
						text += "<td>-</td>";
						text += "<td>-</td>";
						text += "<td>-</td>";
						text += "<td>-</td>";
						text += "<td>-</td>";
						text +=	"</tr>";
					}
					text +="</table>";
				}
				$("#eqpList").html(text);
			}, 
			error : function(){
				alert("실패");
			}
		});
	}
	

	
	
</script>
</body>
</html>