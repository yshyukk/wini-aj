<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<title>장비 사용 현황 통계</title>
</head>
<style>
	table {
		width : 600px;
		border : 1px solid black;
		text-align : center;
	}
	table td {
		border : 1px solid black;
	}
	#pchart {
		width:500px;
		height:600px;
	}
</style>
<body>
	<h2>장비 사용 현황 통계</h2>
	<div id="tableStc"></div>
	<div id="pchart">
		<canvas id="myChart"></canvas>
	</div>
<script>
$(function(){
	staticTable();
});

function staticTable() {
	var text = "";
	$.ajax({
		type : "post",
		url : "./equipStc.do",
		dataType : "json",
		success:function(data){
				console.log(data);
				text += "<table>";
				text +=		"<tr>";
				text +=			"<th>종류명</th>";
				text +=			"<th>전체</th>";
				text +=			"<th>배부 수</th>";
				text +=			"<th>수리 입고수</th>";
				text +=			"<th>잔여개수</th>";
				text +=		"</tr>";
				
				for (var i = 0; i<data.length; i++){
					text += "<tr onclick='chart()'>";
					text += "<td>"+data[i].eqpType+"</td>";
					text += "<td>"+data[i].ceqpSn+"</td>";
					text += "<td>"+data[i].cdstYn+"</td>";
					text += "<td>"+data[i].crepairYn+"</td>";
					text += "<td>"+data[i].call+"</td>";
					text += "</tr>";
				}
				text += "</table>";
				
				$("#tableStc").html(text);
			}
		});
}

function chart() {
	var xValues = ["전체", "사용중", "수리입고", "잔여 개수"];
	var yValues = [10, 5, 2, 3];
	var barColors = [
	  "#b91d47",
	  "#00aba9",
	  "#2b5797",
	  "#e8c3b9"
	];

	new Chart("myChart", {
	  type: "pie",
	  data: {
	    labels: xValues,
	    datasets: [{
	      backgroundColor: barColors,
	      data: yValues
	    }]
	  },
	  options: {
	    title: {
	      display: true,
	      text: "장비 사용 현황"
	    }
	  }
	});
}

</script>
</body>
</html>