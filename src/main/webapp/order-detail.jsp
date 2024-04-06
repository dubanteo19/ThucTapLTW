<%@page import="Model.Carousel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css?version=1">

<link rel="stylesheet" type="text/css"
	href="styles/bootstrap.css?version=1">
<link rel="stylesheet" type="text/css" href="styles/base.css?version=1">
<link rel="stylesheet" type="text/css" href="styles/main.css?version=1">
<link rel="stylesheet" type="text/css" href="styles/tai-khoan.css?d">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css?version=1">
<link rel="stylesheet" type="text/css"
	href="styles/footer.css?version=1">
<title>Chi tiết đơn hàng</title>
</head>
<body>
	<div class="container mt-5">
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
									<fmt:formatNumber type="currency" value="${order.shippingFee}" />
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
							<h5>Trạng thái: ${order.status.getDescription()}</h5>
							
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
									<td><img src='${item.product.getThumb()}' width="100px"
										height="150px"></td>
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
</body>
</html>
