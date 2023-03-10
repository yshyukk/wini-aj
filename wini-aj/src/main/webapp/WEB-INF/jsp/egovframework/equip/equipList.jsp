<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<title>Insert title here</title>
</head>
<body>
	<h1>장비목록 페이지</h1>
	<div id="eqpList"></div>

<script>
$(function(){
	equipType();
})
	function equipType(){
	var text = "";
		$.ajax({
			type : "post",
			dataType : "json",
			url : "./equipList.do",
			success:function(data){
				console.log(data);
				text +="<table>";
				text +=	"<tr>";
				text +=		"<th>장비코드</th>";
				text +=		"<th>장비명</th>";
				text +=	"</tr>";
				for(var i = 0 ; i < data.length; i++){
					text +=	"<tr>";
					text += "<td>"+data[i].eqpCode+"</td>";
					text += "<td>"+data[i].eqpType+"</td>";
					text +=	"</tr>";
				}
				text +="</table>";
				
				$("#eqpList").html(text);
			}, 
			error : function(a,b,c){
				alert("실패");
			}
		});
	}
	

</script>
</body>
</html>