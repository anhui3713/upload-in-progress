<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<iframe name="uploadFrame" style="width: 1px;height: 1px;position:absolute;left: -10px;"></iframe>
<%
	pageContext.setAttribute("token", UUID.randomUUID().toString());
%>
<div style="height: 200px;"></div>
	<form action="UploadServlet?token=${token }" method="post" enctype="multipart/form-data" target="uploadFrame">
		<input style="width: 1px;height: 1px;position:absolute;left: -10px;" id="fileText" type="file" name="file" />
		<a id="uploadButton" href="javascript: void(0);" onclick="document.getElementById('fileText').click();">upload</a>
	</form>
	<div id="progressBar" style="display: none;border:1px solid red;height: 5px;width: 200px;margin-top: 10px;">
		<div id="progress" style="width: 0%;background-color: red;height: 27px;margin-top: -10px;">
			<div id="progressText" style="margin-left: 100%;width: 50px;"></div>
		</div>
	</div>
	<div id='msg'></div>
</body>
<script src="jquery-1.11.1.js"></script>
<script type="text/javascript">
	jQuery(function ($) {
		$("#fileText").change(function () {
			
			if(this.value) {
				// onchange="document.forms[0].submit();"
				document.forms[0].submit();
				var uploadInterval =  setInterval(function () {
					$.get("LoadProgressServlet", {token: "${token}"}, function (data) {
						var progress = parseInt(data || 0) + "%";
						$("#progress").css({
							"width": progress
						});
						$("#progressText").html(progress);
						if(data>=100) {
							clearInterval(uploadInterval);
						}
					});
				}, 100);
				
				$("#uploadButton").hide();
				$("#progressBar").show();
			}
		});
	});
</script>
</html>