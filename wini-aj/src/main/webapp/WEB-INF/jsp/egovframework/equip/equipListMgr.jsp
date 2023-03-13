<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<title>장비 점검 관리</title>
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
	#detailTable {
		width : 800px;
		
	}
	#detailTable tr{
		background-color : white;
		}
	#detailTable td {
		border : 0px;
	}
</style>
</head>
<body>
	<h1>장비 점검 관리 페이지</h1>
	<div id="tables">
		<div id="eqpType"></div>
		<div id="eqpList"></div>
	</div>
	
	<div id="eqpDetail"></div>
	


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
					text += "<td><input id='typeName"+(i+1)+"' type='text' value='"+data[i].eqpType+"' /></td>";
					text += "<td>"+data[i].regDt+"</td>";
					text += "<td><button onclick='deleteType("+(i+1)+")'>삭제</button><button onclick='updateType("+(i+1)+")'>수정</button></td>"
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
/* 장비 종류 삭제 */
	function deleteType(typeNum) {
		var sendData = {
				typeNum : typeNum
		}
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				type : "post",
				url : "./deleteEquipType.do",
				data : sendData,
				success:function(){
						alert("삭제하였습니다.");
						equipType();
					}
			});
		}else{alert("취소되었습니다.");}
	}
/* 장비 종류 수정 */
	function updateType(typeNum){
		var sendData = {
				typeNum : typeNum
				, typeName : $("#typeName"+typeNum).val()
		}
		if(confirm("수정하시겠습니까?")){
			$.ajax({
				type : "post",
				url : "./updateEquipType.do",
				data : sendData,
				success:function(){
						alert("수정하였습니다.");
						equipType();
					}
				});
		}else{alert("취소되었습니다.");}
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
				text +="<table id='equipTable'>";
				if(data.length == 0){
					text += "<tr><td colspan='4'>조회된 데이터가 없습니다.</td></tr></table>";
					text += "<button onclick='addEquip("+typeNum+")'>추가</button>";
				} else if (data.length != 0){
					text +=	"<tr class='toptr'>";
					text +=		"<th>번호</th>";
					text +=		"<th>장비명</th>";
					text +=		"<th>장비 S/N</th>";
					text +=		"<th>배부여부</th>";
					text +=		"<th>수리여부</th>";
					text +=	"</tr>";
					
					for(var i = 0 ; i < data.length; i++){
						text +=	"<tr onclick='equipDetail("+data[i].eqpSn+")'>";
						text += "<td>"+data[i].eqpSn+"</td>";
						text += "<td>"+data[i].eqpNm+"</td>";
						text += "<td>"+data[i].eqpNo+"</td>";
						text += "<td>"+data[i].dstYn+"</td>";
						text += "<td>"+data[i].repairYn+"</td>";
						text +=	"</tr>";
					}
					for(var j=0; j<(10-data.length); j++){
						text +=	"<tr onclick='addCacel(3)'>";
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
	
// ####	장비 상세보기 (관리자용) ####
	function equipDetail(equipNum){
		var text = "";
		var sendData={
				equipNum : equipNum
		}
		$.ajax({
			type : "post",
			url : "./detailEquip.do",
			dataType : "json",
			data : sendData,
			success:function(data){
					text += "<table id='detailTable'>";
					text += 	"<tr>";
					text += 		"<th>장비종류코드</th>";
					text += 		"<td>"+data[0].eqpCode+"</td>";
					text += 	"</tr>";
					text += 	"<tr>";
					text += 		"<th>장비번호</th>";
					text += 		"<td>"+data[0].eqpSn+"</td>";
					text += 	"</tr>";
					text += 	"<tr>";
					text += 		"<th>장비명</th>";
					text += 		"<td><input id='eqpNm' type='text' value='"+data[0].eqpNm+"'/></td>";
					text += 		"<th>장비 S/N</th>";
					text += 		"<td><input id='eqpNo' type='text' value='"+data[0].eqpNo+"'/></td>";
					text += 	"</tr>";
					text += 	"<tr>";
					text += 		"<th>등록자</th>";
					text += 		"<td><input id='regNm' type='text' value='"+data[0].regNm+"'/></td>";
					text += 		"<th>등록일</th>";
					text += 		"<td><input id='regDt' type='date' value='"+data[0].regDt+"' readonly/></td>";
					text += 		"<th>수정일</th>";
					text += 		"<td><input id='modDt' type='date' value='"+data[0].modDt+"' readonly/></td>";
					text += 	"</tr>";
					text += 	"<tr>";
					text += 		"<th>구입일</th>";
					text += 		"<td><input id='buyDt' type='date' value='"+data[0].buyDt+"'/></td>";
					text += 		"<th>구매가격</th>";
					text += 		"<td><input id='buyPrice' type='text' value='"+data[0].buyPrice+"'/></td>";
					text += 	"</tr>";
					text += 	"<tr>";
					text += 		"<th>배부여부</th>";
					text += 		"<td>";
					text +=				"<input type='radio' name='dstyn' id='dstY' value='Y'> Y";
					text +=				"<input type='radio' name='dstyn' id='dstN' value='N'> N";
					text += 		"</td>";
					text += 		"<th>사용 장소</th>";
					text += 		"<td><input id='whereUse' type='text' value='"+data[0].whereUse+"'/></td>";
					text += 	"</tr>";
					text += 	"<tr>";
					text += 		"<th>수리여부</th>";
					text += 		"<td>";
					text +=				"<input type='radio' name='repairyn' id='repairY' value='Y'> Y";
					text +=				"<input type='radio' name='repairyn' id='repairN' value='N'> N";
					text += 		"</td>";
					text += 		"<th>수리 입고일</th>";
					text += 		"<td><input id='repairDt' type='date' value='"+data[0].repairDt+"' /></td>";
					text += 		"<th>수리 완료일</th>";
					text += 		"<td><input id='repairComDt' type='date' value='"+data[0].repairComDt+"'/></td>";
					text += 	"</tr>";
					text += "</table>";
					text += "<button onclick='updateEquip("+data[0].eqpCode+","+data[0].eqpSn+")'>수정</button>";
					text += "<button onclick='deleteEquip("+data[0].eqpCode+","+data[0].eqpSn+")'>삭제</button>";
					
					$("#eqpDetail").html(text);
					
					if(data[0].dstYn == "Y"){
						$('#dstY').prop('checked',true);
					} else if(data[0].dstYn == "N"){
						$('#dstN').prop('checked',true);
					}
					if(data[0].repairYn == "Y"){
						$('#repairY').prop('checked',true);
					} else if(data[0].repairYn == "N"){
						$('#repairN').prop('checked',true);
					}
				},error:function(){
					alert("error");
				}
			});
}
// 장비 수정(관리자용)
	function updateEquip(eqpCode, equipNum) {
		var sendData = {
				equipNum : equipNum
				, eqpCode : eqpCode
				, eqpNm : $("#eqpNm").val()
				, eqpNo : $("#eqpNo").val()
				, regNm : $("#regNm").val()
				, buyDt : $("#buyDt").val()
				, buyPrice : $("#buyPrice").val()
				, dstYn : $('input[name=dstyn]:checked').val()
				, whereUse : $("#whereUse").val()
				, repairYn : $('input[name=repairyn]:checked').val()
				, repairDt : $("#repairDt").val()
				, repairComDt : $("#repairComDt").val()
		}
		console.log(sendData);
		$.ajax({
			type : "post",
			url : "./updateEquip.do",
			data : sendData,
			success:function(){
				equipDetail(equipNum);
				equipList(eqpCode);
				alert("수정되었습니다.");
			}
		});
	}

// 장비 삭제 (관리자용)
	function deleteEquip(eqpCode, equipNum) {
		var sendData = {
				equipNum : equipNum
		}
		$.ajax({
			type : "post",
			url : "./deleteEquip.do",
			data : sendData,
			success:function(){
				equipList(eqpCode);
				addCancel(3);
				alert("삭제되었습니다.");
			}
		});
	}
	</script>
</body>
</html>