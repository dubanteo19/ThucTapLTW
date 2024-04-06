<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<link rel="stylesheet" href="styles/admin.css?aa">
<script src="javascripts/chart.js"></script>
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
				<h5>Quản lý đơn hàng</h5>
				<span class="date">Thứ 2, ngày 30/10/2023 - 11 giờ 25 phút</span>
			</div>
			<div class="container-fluid">
				<div class="row w-100">
					<div class="col-12">
						<div class="list-orders mt-3 bg-white">
							<div class="sub-title">
								<h4>Danh sách đơn hàng</h4>
							</div>
							<table class="table" id="orders">
								<thead>
									<tr>
										<th scope="col">ID đơn hàng</th>
										<th scope="col">Tên khách hàng</th>
										<th scope="col">Tổng tiền</th>
										<th scope="col">Trạng thái</th>
										<th scope="col">Ngày tạo đơn hàng</th>
										<th scope="col">Chức năng</th>
									</tr>
								</thead>
								<c:forEach items="${orders}" var="item">
									<tbody id="${item.id}">
										<tr>
											<td>${item.id}</td>
											<td>${item.user.fullName}</td>
											<td><fmt:formatNumber value="${item.totalPrice}"
													type="currency" /></td>
											<td>${item.status.description}</td>
											<td>${item.getDateCreated()}</td>
											<td class="text-center"><div class="btn-group">
													<a href="OrderController?action=detail&orderId=${item.id}">
														<button
															class="btn btn-secondary btn-sm me-1 btn-order-detail"
															data-target=${item.id}>
															<i class="fa-solid fa-circle-info"></i>
														</button>
													</a>
												</div></td>
										</tr>
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
<script type="text/javascript" src="javascripts/FakeDataBase.js"></script>
<script type="text/javascript" src="javascripts/Utils.js"></script>
<script type="text/javascript" src="../javascripts/jquery-3.7.1.js"></script>
<script type="text/javascript">
    $(".nav-link").removeClass("active");
    $("#orders-nav-link").addClass("active");
</script>

</html>