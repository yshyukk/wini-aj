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
		<div>
			<div id="eqpType"></div>
			<div id="paging1"></div>
		</div>
		<div>
			<div id="eqpList"></div>
			<div id="paging2"></div>
		</div>

	</div>
	
	<div id="eqpDetail"></div>
	


<script>
$(function(){
	equipType(1);
	equipList();
})

//* 장비 종류 조회 */
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
					text +=	"<tr onclick='equipList("+(i+1)+", 1)'>";
					text += "<td>"+data.result[i].eqpCode+"</td>";
					text += "<td><input id='typeName"+(i+1)+"' type='text' value='"+data.result[i].eqpType+"' /></td>";
					text += "<td>"+data.result[i].regDt+"</td>";
					text += "<td><button onclick='deleteType("+(i+1)+")'>삭제</button><button onclick='updateType("+(i+1)+")'>수정</button></td>"
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
						equipType(1);
					}
			});
		}else{alert("취소되었습니다.");}
	}
/* 장비 종류 수정 */
	function updateType(typeNum){
		if($.trim($("#typeName"+typeNum).val()) == ""){
			alert("종류명을 입력해주세요");
		}else{
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
							equipType(1);
						}
					});
			}else{alert("취소되었습니다.");}
		}
		
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
						text +=	"<tr onclick='equipDetail("+data.result[i].eqpSn+")'>";
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
		if($.trim($("#eqpNm").val()) == ""){
			alert("장비명을 입력해주세요");
		} else if($.trim($("#eqpNo").val()) == ""){
			alert("장비 S/N을 입력해주세요");
		} else if($.trim($("#regNm").val()) == ""){
			alert("등록자를 입력해주세요");
		}   else{
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
					equipList(eqpCode, 1);
					alert("수정되었습니다.");
				}
			});
		}
		
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
				equipList(eqpCode, 1);
				addCancel(3);
				alert("삭제되었습니다.");
			}
		});
	}
	</script>
</body>
</html>