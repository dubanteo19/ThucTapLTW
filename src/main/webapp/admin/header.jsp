<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="d-flex justify-content-between bg-primary-green">
		<i class="menu-icon fa-solid fa-bars"></i> <i id="logoutBtn"
			class="fa-solid fa-right-from-bracket sign-out-icon"></i>
	</div>
</body>
<script type="text/javascript" src="../javascripts/jquery-3.7.1.js"></script>
<script>
	$(document).ready(function() {
		function toggleMenu() {
			$("#left").slideToggle(1000);
			$(".menu-icon").toggleClass("move-left");
		}
		$(".menu-icon").click(toggleMenu);
	});
</script>
</html>
