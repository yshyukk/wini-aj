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
	#tables{
		display : flex;
		margin : 10px;
	}
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
	#eqpType {
		margin-right: 10px;
	}
	#equipTable{
		width:800px;
	}
</style>
</head>
<body>

	<h1>장비목록 페이지</h1>
	<div id="tables">
		<div>
			<div id="eqpType"></div>
			<div id="paging1"></div>
		</div>
		<div>
			<div id="eqpList"></div>
			<div id="paging2"></div>
		</div>

	</div>
	


<script>
$(function(){
	equipType(1);
	equipList();
})

/* 장비 종류 조회 */
	function equipType(pageNo){
	var text = "";
	var sendData = {
			page : pageNo
	}
		$.ajax({
			type : "post",
			dataType : "json",
			data : sendData,
			url : "./equipType.do",
			success:function(data){
				console.log(data);
				text +="<table id='typeTable'>";
				text +=	"<tr class='toptr'>";
				text +=		"<th>장비코드</th>";
				text +=		"<th>장비종류</th>";
				text +=		"<th>등록일</th>";
				text +=	"</tr>";
				for(var i = 0 ; i < data.result.length; i++){
					text +=	"<tr onclick='equipList("+(i+1)+",1)'>";
					text += "<td>"+data.result[i].eqpCode+"</td>";
					text += "<td>"+data.result[i].eqpType+"</td>";
					text += "<td>"+data.result[i].regDt+"</td>";
					text +=	"</tr>";
				}
				for(var j=0; j<(10-data.result.length); j++){
					text +=	"<tr>";
					text += "<td>-</td>";
					text += "<td>-</td>";
					text += "<td>-</td>";
					text +=	"</tr>";
				}
				text += "<tr id='addTypeCol'></tr>";
				text +="</table>";
				text += "<button onclick='addType()'>추가</button>";
				
// 				//페이징
// 				var lastpg = Math.ceil(data.totalCnt / 10);
// 				var pagebtn ="";
// 				pagebtn += "<button onclick='equipList("+pageNo+"-1)'>이전</button>";
// 				pagebtn += "<button onclick='equipList("+pageNo+"+1)'>다음</button>";
// 				$("#paging1").html(pagebtn);
// 				if(pageNo == 0) {
// 					alert("첫 페이지 입니다.");
// 					equipList(1);
// 				} else if (pageNo >= lastpg+1){
// 					alert("마지막 페이지 입니다.");
// 					equipList( lastpg);
// 				}
				
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
	text += 	"<td><input id='addTypeNm' placeholder='종류명'/></td>";
	text += 	"<td colspan='2'><button onclick='submitType()'>생성</button>";
	text += 	"<button onclick='addCancel(1)'>취소</button></td>";
	$("#addTypeCol").html(text);
}

/* 장비 종류 추가 확인 */
	function submitType(){
		if($.trim($("#addTypeNm").val()) == ""){
			alert("종류명을 입력해주세요");
		}else{
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
							equipType(1);
						}
					});
			}
		}
		
	}
	
/* 장비 종류 추가 취소 */
	function addCancel(num){
		var cancel ="";
		if(num == 1){
			$("#addTypeCol").html(cancel);
		} else if (num == 2){
			$("#addEquipCol").html(cancel);
		} else if (num == 3){
			$("#eqpDetail").html(cancel);
		}
		
	}


// 	############## 장비관련 JS ############ 

	
/* 장비 목록 조회 */
	function equipList(typeNum, pageNo){
		var sendData = {
				typeNum : typeNum,
				page : pageNo
		}
		var text = "";
		$.ajax({
			type : "post",
			dataType : "json",
			url : "./equipList.do",
			data : sendData,
			success:function(data){
				text +="<table id='equipTable'>";
				if(data.result.length == 0){
					text += "<tr><td colspan='4'>조회된 데이터가 없습니다.</td></tr>";
					text += "<tr id='addEquipCol'></tr></table>";
					text += "<button onclick='addEquip("+typeNum+")'>추가</button>";
				} else if (data.result.length != 0){
					text +=	"<tr class='toptr'>";
					text +=		"<th>장비 식별 번호</th>";
					text +=		"<th>장비명</th>";
					text +=		"<th>장비 S/N</th>";
					text +=		"<th>배부여부</th>";
					text +=		"<th>수리여부</th>";
					text +=	"</tr>";
					
					for(var i = 0 ; i < data.result.length; i++){
						text +=	"<tr>";
						text += "<td>"+data.result[i].eqpSn+"</td>";
						text += "<td>"+data.result[i].eqpNm+"</td>";
						text += "<td>"+data.result[i].eqpNo+"</td>";
						text += "<td>"+data.result[i].dstYn+"</td>";
						text += "<td>"+data.result[i].repairYn+"</td>";
						text +=	"</tr>";
					}
					for(var j=0; j<(10-data.result.length); j++){
						text +=	"<tr>";
						text += "<td>-</td>";
						text += "<td>-</td>";
						text += "<td>-</td>";
						text += "<td>-</td>";
						text += "<td>-</td>";
						text +=	"</tr>";
					}
					text += "<tr id='addEquipCol'></tr>";
					text +="</table>";
					text += "<button onclick='addEquip("+typeNum+")'>추가</button>";
					
					var pagebtn ="";
					pagebtn += "<button onclick='equipList("+typeNum+","+pageNo+"-1)'>이전</button>";
					pagebtn += "<button onclick='equipList("+typeNum+","+pageNo+"+1)'>다음</button>";
					$("#paging2").html(pagebtn);
				}
				
				//페이징
				var lastpg = 0;
				if(Math.ceil(data.totalCnt / 10) == 3){
					lastpg = Math.ceil(data.totalCnt / 10);
				}else{
					lastpg = 3;
				}
				console.log(lastpg, pageNo);
				
				if(pageNo == 0) {
					alert("첫 페이지 입니다.");
					equipList(typeNum, 1);
				} else if (pageNo > lastpg){
					alert("마지막 페이지 입니다.");
					equipList(typeNum, lastpg);
				}
				
				$("#eqpList").html(text);
			}, 
			error : function(){
				alert("실패");
			}
		});
	}

/* 장비 추가 */
	function addEquip(typeNum){
		if(typeNum == undefined){
			alert("장비분류 선택 후 장비를 추가해주세요.")
		} else {
			var text ="";
			text += 	"<td><input id='addEquipNm' placeholder='장비명'/></td>";
			text += 	"<td><input id='addEquipNo' placeholder='장비 S/N'/></td>";
			text += 	"<td><input id='addEquipRegNm' placeholder='등록자'/></td>";
			text += 	"<td><input id='addEquipWhere' placeholder='사용장소'/></td>";
			text += 	"<td><button onclick='submitEquip("+typeNum+")'>생성</button>";
			text += 	"<button onclick='addCancel(2)'>취소</button></td>";
			$("#addEquipCol").html(text);
		}
	}
	
/* 장비 추가 확인 */
	function submitEquip(typeNum){
		if($.trim($("#addEquipNm").val()) == ""){
			alert("장비명을 입력해주세요");
		} else if($.trim($("#addEquipNo").val()) == ""){
			alert("장비 S/N 을 입력해주세요");
		} else if($.trim($("#addEquipRegNm").val()) == ""){
			alert("등록자를 입력해주세요");
		}  else {
			if(confirm("추가하시겠습니까? 추가 후 수정, 삭제는 관리자에게 문의하세요.")){
				if($.trim($("#addEquipWhere").val()) == ""){
					var dstYn = "N"
				} else {
					var dstYn = "Y"
					}
				var sendData = {
						typeNum : typeNum
						, addEquipNm : $("#addEquipNm").val()
						, addEquipNo : $("#addEquipNo").val()
						, addEquipRegNm : $("#addEquipRegNm").val()
						, addEquipWhere : $("#addEquipWhere").val()
						, dstYn : dstYn
				}
				$.ajax({
					type : "post",
					url : "./addEquip.do",
					data : sendData,
					success:function(){
						equipList(typeNum);
						addCancel(2);
						alert("추가되었습니다.");
						},error:function(){
							alert("error");
						}
					});
			}else {alert("취소되었습니다.");}
		}
		
	}
</script>
</body>
</html>