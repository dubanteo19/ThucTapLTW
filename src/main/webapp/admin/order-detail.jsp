<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html></html>

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

.status-bar {
	width: 300px !important;
}
</style>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container-fluid"></div>
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
								<h4>Chi tiết đơn hàng</h4>
							</div>
							<c:set var="order" scope="request" value="${requestScope.order}" />
							<div class="order-detail mt-3 row">
								<div class="col-6">
									<div>
										<h5>ID đơn hàng: ${order.id}</h5>
									</div>
									<div>
										<h5>Tên khách hàng: ${order.user.getFullName()}</h5>
									</div>
									<div>
										<h5>Phương thức thanh toán: ${order.paymentMethod}</h5>
									</div>
								</div>
								<div class="col-6">
									<div>
										<h5>
											Phí vận chuyển:
											<fmt:formatNumber type="currency"
												value="${order.shippingFee}" />
										</h5>
									</div>
									<div>
										<h5>Phiếu giảm giá:</h5>
									</div>
									<div>
										<h5>
											Tổng đơn hàng:
											<fmt:formatNumber type="currency" value="${order.totalPrice}" />
										</h5>
									</div>
								</div>
								<div class="status-bar">
									<h5>Trạng thái</h5>
									<form action="OrderController" id="statusForm">
										<input type="hidden" name="action" value="put"> <input
											type="hidden" name="orderId" value="${order.id}"> <select
											class="form-select" name="statusId">
											<option id="status6" value="6">Đã hoàn thành</option>
											<option id="status7" value="7">Đã hủy</option>
											<option id="status4" value="4">Đang xử lý</option>
											<option id="status5" value="5">Đang vận chuyển</option>
										</select>
									</form>
								</div>
							</div>
							<table class="table" id="orders">
								<thead>
									<tr>
										<th scope="col">STT</th>
										<th scope="col">Tên sản phẩm</th>
										<th scope="col">Hình ảnh</th>
										<th scope="col">Số lượng</th>
										<th scope="col">Đơn giá</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${order.details}" var="item" varStatus="i">
										<tr>
											<td>${i.count}</td>
											<td>${item.product.getName()}</td>
											<td><img src='../${item.product.getThumb()}'
												width="100px" height="150px"></td>
											<td>${item.quantity}</td>
											<td><fmt:formatNumber type="currency"
													value="${item.price}" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="../javascripts/jquery-3.7.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript" src="../javascripts/main.js"></script>
<script type="text/javascript">
    let re = ' ${requestScope.result}';
    if (re != ' ') {
	showNotification();
    }
    function showNotification() {
	notify2("Thông báo", re, "success", 1000);
    }
    $(".form-select").on("change", function() {
	$("#statusForm").submit();
    })

    let statusId = "status" + '${order.status.getId()}';
    $("#" + statusId).attr("selected", "selected");

    $(".nav-link").removeClass("active");
    $("#orders-nav-link").addClass("active");
</script>