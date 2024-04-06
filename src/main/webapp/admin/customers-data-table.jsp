<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<link rel="stylesheet" type="text/css" media="all"
	href='../styles/bootstrap.css'>
<link rel="stylesheet" type="text/css" href="../styles/base.css">
<link rel="stylesheet" type="text/css" href="../styles/main.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="styles/admin.css?đsdsd">
</head>
<style>
.btn-order-detail i {
	color: #fffff;
}
</style>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="row">
		<jsp:include page="left-menu.jsp"></jsp:include>
		<div class="col-9 pt-3">
			<div
				class="container title d-flex justify-content-between bg-white rounded">
				<h5>Quản lý khách hàng</h5>
				<span class="date">Thứ 2, ngày 30/10/2023 - 11 giờ 25 phút</span>
			</div>
			<div class="container-fluid">
				<div class="row w-100">
					<div class="col-12">
						<div class="list-orders mt-3 bg-white">
							<div class="sub-title">
								<h4>Danh sách khách hàng</h4>
							</div>
							<table class="table" id="orders">
								<thead>
									<tr>
										<th scope="col">ID</th>
										<th scope="col">Tên khách hàng</th>
										<th scope="col">Số điện thoại</th>
										<th scope="col">Email</th>
										<th scope="col">Trạng thái</th>
										<th scope="col">Chức năng</th>
									</tr>
								</thead>
								<c:forEach items="${users}" var="user">
									<tbody>
										<c:if test="${user.roleId != 1 }">
											<tr>
												<td>${user.id}</td>
												<td>${user.fullName}</td>
												<td>${user.phone}</td>
												<td>${user.email}</td>
												<td>${user.status.description}</td>
												<td><a
													href="UserController?action=detail&userId=${user.id}">
														<button
															class="btn btn-secondary btn-sm me-1 btn-order-detail"
															data-target=${item.id}>
															<i class="fa-solid fa-circle-info"></i>
														</button>
												</a></td>
											</tr>
										</c:if>
									</tbody>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="../javascripts/jquery-3.7.1.js"></script>
<script type="text/javascript">
    $(".nav-link").removeClass("active");
    $("#customers-nav-link").addClass("active");
</script>

</html>