<%@page import="Controller.cart.Cart"%>
<%@page import="Model.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Formatter"%>
<%@page import="java.util.logging.SimpleFormatter"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giỏ hàng</title>
<link rel="stylesheet" type="text/css" href="styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="styles/base.css">
<link rel="stylesheet" type="text/css" href="styles/main.css">
<link rel="stylesheet" type="text/css" href="styles/voucher.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="styles/footer.css">
<link rel="stylesheet" href="styles/nav.css">
<link rel="stylesheet" type="text/css" href="styles/lightslider.css">
<link rel="stylesheet" href="styles/gio-hang.css">
<style type="text/css">

.cart-header-info {
    padding: 10px 0;
    font-weight: bold;
    border-bottom: 1px solid #ebebeb; /* Viền dưới */
}

.cart-header-info-item {
    text-align: left;
}

.cart_item_row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
    border-bottom: 1px solid #ebebeb; 
    padding-bottom: 10px;
}

.cart_product img {
    max-width: 80px;
    max-height: 80px; 
    object-fit: contain;
}

.cart-header-info-item.col-xl-7 {
    max-width: 50%;
}

.cart-header-info-item.col-xl-2 {
    text-align: center;
}

.cart-footer {
    margin-top: 20px;
}

.cart_subtotal {
    font-weight: bold;
}

.cart_left {
    padding-right: 20px;
}

.cart_total_price {
    font-size: 1.2em;
    color: #e44d26;
}

#btn-proceed-checkout {
    width: 100%;
    background-color: #28a745; 
    color: #fff;
    text-align: center;
    line-height: 30px;
    border: 1px solid #28a745;
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

#btn-proceed-checkout:hover {
    background-color: #218838;
}

</style>
</head>

<%
Cart cart = (Cart) session.getAttribute("cart");
if (cart == null)
	cart = new Cart();
%>

<body>
	<jsp:include page="Components/header.jsp" />

	<jsp:include page="top-title.jsp">
		<jsp:param name="title" value="Giỏ hàng" />
	</jsp:include>

	<jsp:include page="Components/voucher-component.jsp"></jsp:include>
	<div class="row container d-flex justify-content-center" >
		<div class="col-xl-9 col-lg-8 col-12 col-cart-left">
			<div class="cart-page d-xl-block d-none">
				<div class="drawer__inner">
					<div class="CartPageContainer">
						<form action="PayController" method="get" novalidate="" class="cart">
							<div class="cart-header-info d-flex">
								<div class="cart-header-info-item col-xl-7 px-5">Thông tin sản
									phẩm</div>
								<div class="cart-header-info-item col-xl-2">Đơn giá</div>
								<div class="cart-header-info-item col-xl-2">Số lượng</div>
								<div class="cart-header-info-item col-xl-2">Thành tiền</div>
							</div>
							<div class="cart_body items">
								<div class="row m-0">
									<c:forEach items="${cart.getCartItems()}" var="item">
										<jsp:include
											page="/templates/cart-item-horizontal-template.jsp">
											<jsp:param name="productId" value="${item.product.id}" />
											<jsp:param name="productName" value="${item.product.name}" />
											<jsp:param name="productThumb" value="${item.product.thumb}" />
											<jsp:param name="quantity" value="${item.quantity}" />
											<jsp:param name="price" value="${item.product.unitPrice}" />
											<jsp:param name="totalPrice" value="${item.calculatePrice()}" />
										</jsp:include>
									</c:forEach>
								</div>
							</div>

							<div class="cart-footer">
								<div class="row">
									<div class="col-lg-4 col-12 offset-md-8">
										<div class="pt-3">
											<div class="cart_subtotal d-flex">
												<div class="cart-left" style="padding-right: 150px">Tổng
													tiền:</div>
												<div class="price-box cart_total_price" style="">
													<fmt:setLocale value='vi-VN' />
													<fmt:formatNumber value="<%=cart.getTotalPrice()%>"
														type="currency" />
												</div>
											</div>
										</div>
										<div class="mt-3">
											<button type="button"
												class="button btn btn-default bg-primary-green mb-3"
												id="btn-proceed-checkout" title="Thanh toán">Thanh
												toán</button>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="cart-mobile-page d-block d-xl-none">
			<div class="CartMobileContainer"></div>
		</div>
	</div>
	
	<footer>
		<jsp:include page="Components/footer.jsp" />
	</footer>
	<script type="text/javascript" src="javascripts/shopping-cart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
	$('#btn-proceed-checkout').click(function() {
		window.location.href = "thanh-toan";
	});
    const checkbox = document.querySelector('#checbkox-bill');
    const billField = document.querySelector('.bill-field');

    checkbox.addEventListener('change', () => {
        if (checkbox.checked) {
            billField.style.display = 'block';
        } else {
            billField.style.display = 'none';
        }
    });

</script>
</body>
<script type="text/javascript" src="javascripts/main.js"></script>

</html>