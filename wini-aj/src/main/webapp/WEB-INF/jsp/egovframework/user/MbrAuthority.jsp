<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<title>사용자 권한 관리</title>
<style>
	table, td{
		border : 1px solid black;
	}
	#typeTable{
		width : 500px;
	}
</style>
</head>

<body>
	<h1>사용자 권한 관리</h1>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>권한</th>
			</tr>
		</thead>
		<tbody id="list">
			
		</tbody> 
	</table>
	
	<h1>회원가입 승인 대기</h1>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>승인</th>
			</tr>
		</thead>
		<tbody id="waitList">
		</tbody> 
	</table>
	
	<script>
		$(document).ready(function () { 
			mbrList(); 
			mbrWaitList();
		});
		
		var type;
		/* 회원 리스트 */
		function mbrList() {
			$.ajax({
		        url : "./mbrList.do",
		        type : "POST",
		        datatype : "json",
		        success : function (list) {
		        	var html = "";
		            for (var i = 0; i < list.length; i++) {
		            	
		            	type = 'mbr_type'+i;
		            	
		            	html+="<tr>";
		                html+="<td>"+list[i].mbr_sn+"</td>";
		                html+="<td>"+list[i].mbr_id+"</td>";
		                html+="<td>"+list[i].mbr_nm+"</td>";
		                html+="<td><input type='radio' value='0' id='mbr_type_admin"+i+"' name='mbr_type"+i+"'>admin ";
		                html+="<input type='radio' value='1' id='mbr_type_system"+i+"' name='mbr_type"+i+"'>시스템 관리자 ";
		                html+="<input type='radio' value='2' id='mbr_type_general"+i+"' name='mbr_type"+i+"'>일반 사용자   ";
		                html+="<button type='submit' onclick='mbrAuthority("+list[i].mbr_sn+", "+i+")'>변경</button></td>"
		                html+="</tr>";	
		            }
		            $("#list").html(html) 
		            
		            for (var i = 0; i < list.length; i++) {
			            if(list[i].mbr_type == 0){
			            	$("#mbr_type_admin"+i).prop("checked", true);
			            } else if (list[i].mbr_type == 1){
			            	$("#mbr_type_system"+i).prop("checked", true);
			            } else if (list[i].mbr_type == 2){
			            	$("#mbr_type_general"+i).prop("checked", true);
			            }
		            }
		        },
		        error : function (result) {
		            alert("error");
		        }
		    });
		}
		
		/* 회원 권한 변경 */
		function mbrAuthority(mbr_sn, type){
			
			var authority = <%=(int)session.getAttribute("mbr_type")%>; 		// 세션에 저장된 권한
			var mbr_type = $('input[name=mbr_type'+type+']:checked').val();		// 변경할 회원의 권한
			
			if (authority > mbr_type){
				alert("권한이 없습니다.");
				mbrList();
			} else{
				var mbrUpdate = {mbr_sn : mbr_sn
						   	   , mbr_type : mbr_type}
			
				if (confirm("권한을 변경하시겠습니까?")) {		        
		        	$.ajax({
		       			type:'POST',
		       			url:"./mbrAuthorityUpdate.do",
		       			data: mbrUpdate,
		       			dataType : 'text',
		       			success : function(data) {
		       				mbrList();
		       			},
		       			error: function(){
		       				alert("error");
		       			}
		       		});
		        }				
			}			
		}
		
		/* 회원가입 승인 대기 리스트 */
		function mbrWaitList() {
			$.ajax({
		        url : "./mbrWaitList.do",
		        type : "POST",
		        datatype : "json",
		        success : function (waitList) {
		        	var html = "";
		        	
		        	if(waitList.length == 0){ // 등록된 사원이 없을 때
						html+="<td colspan='4'>대기중인 회원이 없습니다.</td>";
		        		$("#waitList").html(html) // 생성한 테이블 삽입
		        	}else{
		        		for (var i = 0; i < waitList.length; i++) {
			            	html+="<tr>";
			                html+="<td>"+waitList[i].mbr_sn+"</td>";
			                html+="<td>"+waitList[i].mbr_id+"</td>";
			                html+="<td>"+waitList[i].mbr_nm+"</td>";
			                html+="<td><button type='submit' onclick='mbrWait("+waitList[i].mbr_sn+")'>회원가입 승인</button></td>"
			                html+="</tr>";		                
			            }
			            $("#waitList").html(html)
		        	}
		        },
		        error : function (waitList) {
		            alert("error");
		        }
		    });
		}
		
		/* 회원가입 승인 */
		function mbrWait(mbr_sn){			
			var mbrUpdate = {mbr_sn : mbr_sn}
			
			if (confirm("회원가입을 승인하시겠습니까?")) {	     
	        	$.ajax({
	       			type:'POST',
	       			url:"./mbrWait.do",
	       			data: mbrUpdate,
	       			dataType : 'text',
	       			success : function(data) {
	       				mbrList();
	       				mbrWaitList();
	       			},
	       			error: function(){
	       				alert("error");
	       			}
	       		});
	        } 
		}
	</script>
</body>
</html>