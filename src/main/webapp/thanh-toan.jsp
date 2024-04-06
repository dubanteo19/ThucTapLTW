<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="Controller.cart.Cart"%>
<%@page import="Model.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Thanh Toan</title>
<link rel="stylesheet" type="text/css" href="styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="styles/base.css">
<link rel="stylesheet" type="text/css" href="styles/main.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="styles/news.css">
<link rel="stylesheet" type="text/css" href="styles/footer.css">
<link rel="stylesheet" type="text/css" href="styles/nav.css">
<link rel="stylesheet" href="styles/login.css">
<script type="text/javascript" src="javascripts/jquery-3.7.1.js"></script>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta property="og:title" content="">
<meta property="og:type" content="">
<meta property="og:url" content="">
<meta property="og:image" content="">

<link rel="stylesheet" type="text/css" href="styles/main.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<meta name="theme-color" content="#fafafa">

<style>
.logo {
	display: block;
	text-align: center;
}

.logo img {
	width: 100%;
	max-width: 228px;
}

.mb-child-10>*:not(:last-child) {
	margin-bottom: 10px;
}

#note {
	width: 100%;
	border-color: #ddd;
	border-radius: 5px;
	resize: none;
	padding: 5px 10px;
}

.alert-info {
	background-color: #d1ecf1;
	color: #0c5460;
	text-align: center;
	padding: 8px 5px;
	border: 1px solid #bee5eb;
	border-radius: 5px;
}

.pay-method {
	width: 100%;
	padding: 8px 10px;
	border-radius: 5px;
	border: 2px solid #ddd;
}

.left {
	padding-left: 10%;
	padding-right: 2%;
}

.right {
	height: 100vh;
	border-left: 2px solid #ddd;
	background-color: rgba(245, 245, 245, 0.8);
}

.border-bottom-child>*:not(:last-child) {
	border-bottom: 2px solid #ddd;
}

.order-summary {
	display: flex;
	flex-direction: column;
}

.order-item {
	display: flex;
	align-items: center;
}

.btn-blue {
	width: 50%;
	margin-left: 0.85714em;
	padding: 8px 10px;
	color: #fff;
	border: 2px solid #2f71a9;
	border-radius: 10px;
	background-color: #357ebd;
	white-space: nowrap;
}

.large-price {
	color: #2a9dcc;
	font-size: 20px;
	font-weight: 400;
}

.select2-selection__rendered {
	line-height: 31px !important;
}

.select2-container .select2-selection--single {
	background-color: #3dd5f3;
	height: 35px !important;
}

.select2-selection__arrow {
	height: 34px !important;
}

.col {
	padding: 0 !important;
	margin-bottom: 10px;
}

.custom-scrollbar {
	max-height: 350px;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
	background-color: #2a9dcc;
}

.circular-element {
	position: absolute;
	top: -5px;
	right: -5px;
	background-color: #2a9dcc;
	color: #fff;
	border-radius: 50%;
	padding: 4px 8px;
	font-size: 10px;
}
</style>

</head>

<%
User user = session.getAttribute("user") == null ? null : (User) session.getAttribute("user");
Cart cart = (Cart) session.getAttribute("cart");
if (cart == null)
	cart = new Cart();
%>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
	integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
	crossorigin="anonymous"></script>
<body>
	<div id="wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-8 my-3 left">
					<div class="logo">
						<a href=""><img src="./images/logo/logo.png" alt=""></a>
					</div>
					<div class="row">
						<div class="col-md-6 mt-2">
							<div class="d-flex justify-content-between mb-2">
								<h4 class="title-head">Thông tin đăng nhập</h4>
							</div>
							<form class="mb-child-10" method="post" id="thanh-toan"
								accept-charset="UTF-8" action="OrderSendMail">
								<input type="email" id="email"
									pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,63}$" name="email"
									class="form-control" placeholder="Email" required=""
									value="${user.email}">
								<div id="error-email" style="color: red;"></div>
								<input type="text" id="full-name" name="full-name"
									class="form-control" placeholder="Họ và tên" required=""
									value="${user.fullName}">
								<div id="error-full-name" style="color: red;"></div>
								<input type="text" id="phone-number" name="phone-number"
									class="form-control" pattern="\d+" placeholder="Số điện thoại"
									required="" value="${user.phone}">
								<div id="error-phone" style="color: red;"></div>
								<c:forEach var="item" items="${user.getAddresses()}">
									<c:if test="${item.isDefault()}">
										<input type="text" id="address" name="address"
											class="form-control" placeholder="Địa chỉ (tùy chọn)"
											value="${item.getDescription()}">
										<div class="col">
											<input type="text" id="provinces" name="provinces"
												class="form-control" placeholder="Tỉnh, thành phố"
												value="${item.getProvince()} ">
										</div>
										<div class="col">
											<input type="text" id="districts" name="districts"
												class="form-control" placeholder="Quận huyện"
												value="${item.getDistricts()}">
										</div>
										<div class="col">
											<input type="text" id="wards" name="wards"
												class="form-control" placeholder="Phường xã"
												value="${item.getWards()}">
										</div>
									</c:if>
								</c:forEach>
								<textarea id="note" name="note" rows="4"
									placeholder="Ghi chú (tùy chọn)"></textarea>
							</form>
						</div>

						<div class="col-md-6 mt-2">
							<h4 class="title-head mb-3">Vận chuyển</h4>
							<div class="fee-ship pay-method form-check form-check-inline">
								<input type="radio" name="shipping-method" id="fee-ship"
									class="form-check-input" checked>
								<div class="d-flex">
									<label for="fee-ship" class="mx-2 form-check-label">Giao
										hàng tận nơi</label> <label for="fee-ship"
										class="mx-2 form-check-label" style="padding-left: 140px">40.000đ</label>
								</div>
							</div>

							<h4 class="title-head mb-3 mt-5">Thanh toán</h4>
							<div class="pay-method form-check form-check-inline">
								<input type="radio" name="payment-method" id="pay-on-delivery"
									class="form-check-input"> <label for="pay-on-delivery"
									class="mx-2 form-check-label">Thanh toán khi nhận hàng</label>
							</div>
						</div>
					</div>
				</div>
				<aside class="col-md-4 right border-bottom-child">
					<div class="mt-4">
						<c:set var="totalItems" value="<%=cart.getTotalItems()%>" />
						<h4 class="title-head">
							<c:choose>
								<c:when test="${totalItems > 0}">
            						Đơn hàng (<c:out value="${totalItems}" /> sản phẩm)
        						</c:when>
								<c:otherwise>
           	 						Bạn chưa thêm sản phẩm nào vào giỏ hàng
        						</c:otherwise>
							</c:choose>
						</h4>
					</div>
					<div class="order-summary border-bottom-child">
						<c:if test="${totalItems  > 0}">
							<div class="custom-scrollbar border-bottom-child">
								<c:forEach items="${cart.getCartItems()}" var="item">
									<c:set var="isSale"
										value="${item.product.getClass().getSimpleName() eq 'ProductSale'}" />

									<div class="order-item" data-product-id="${item.product.id}">
										<div class="row g-0">
											<div class="col-md-3 d-flex align-items-center p-2">
												<div class="position-relative">
													<img src="${item.product.thumb}" alt=""
														class="card-img mx-auto">
													<div class="circular-element">${item.getQuantity()}</div>
												</div>
											</div>
											<div class="col-md-9">
												<div class="card-body d-flex flex-column">
													<h3 class="card-title">
														<a href="">${item.product.name}</a>
													</h3>
													<div class="d-flex justify-content-between">
														<div class="card-text">
															<span>Đơn giá:</span>
														</div>
														<div class="card-text">
															<div class="price-box">
																<span class="product_new_price"> <fmt:setLocale
																		value='vi-VN' /> <fmt:formatNumber
																		value="${item.getProductPrice()}" type="currency" />
																</span>
																<c:if test="${isSale}">
																	<span class="price-compare product_unit_price">
																		<fmt:setLocale value='vi-VN' /> <fmt:formatNumber
																			value="${item.product.unitPrice}" type="currency" />
																	</span>
																</c:if>
															</div>
														</div>
													</div>
													<div class="d-flex justify-content-between">
														<div class="card-text">
															<span><b>Số tiền: </b></span>
														</div>
														<div class="card-text">
															<div class="price-box">
																<span class="product_new_price"> <fmt:setLocale
																		value='vi-VN' /> <fmt:formatNumber
																		value="${item.calculatePrice()}" type="currency" />
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</c:if>
					</div>
					<div class="d-flex align-items-center justify-content-between py-3">
						<input type="text" name="discount" id="discount"
							class="form-control" placeholder="Nhập mã giảm giá">
						<button class="btn-blue disabled">Áp dụng</button>
					</div>

					<div class="py-3">
						<div class="d-flex justify-content-between">
							<span>Tạm tính</span> <span class="small-price"> <fmt:setLocale
									value='vi-VN' /> <fmt:formatNumber
									value="${cart.getTotalPrice()}" type="currency" />

							</span>
						</div>
						<div class="d-flex justify-content-between mt-2">
							<span>Phí vận chuyển</span> <span class="small-price">40.000đ</span>
						</div>
					</div>
					<div class="py-3">
						<div class="d-flex justify-content-between">
							<span class="title-head">Tổng cộng</span> <span
								class="large-price"><fmt:setLocale value='vi-VN' /> <fmt:formatNumber
									value="${cart.getTotalPrice() + 40000}" type="currency" /></span>
						</div>
						<div
							class="d-flex align-items-center justify-content-between mt-3">
							<a style="color: #2a9dcc" href="gio-hang.jsp">< Quay về giỏ hàng</a>
							<button class="btn-blue" type="button" id="dat-hang"
								onclick="validateAndSubmit()">Đặt hàng</button>
						</div>
					</div>
				</aside>
			</div>
		</div>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<script src="javascripts/vn-provinces.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    var districts;
    var provincesElement = $("#provinces");
    var districtsE = $("#districts");
    for (const province of provinces) {
        var optionE = $("<option>").html(province.name);
        provincesElement.append(optionE);
    }
    provincesElement.select2();
    function  getDistricts(){
        var selectedProvince = $("#provinces").val();


        districtsE.empty();
        for (const province of provinces) {
            if(province.name===(selectedProvince)){
                districts = province.districts
            }
        }
        for (const district of districts) {
            var option = $("<option>").html(district.name);
            districtsE.append(option);
        }
    }

    function  getWards(){
        var selectedDisctrict = districtsE.val();
        var wards;
        var wardE = $("#wards");
        wardE.empty();
        for (const district of districts) {
            if(district.name===(selectedDisctrict)){
                wards = district.wards;
            }
        }
        for (const ward of wards) {
            var option = $("<option>").html(ward.name);
            wardE.append(option);
        }
    }

</script>
<script>
    function validateAndSubmit() {
        // Lấy giá trị từ các trường
        var email = $("#email").val();
        var fullName = $("#full-name").val();
        var phoneNumber = $("#phone-number").val();

        // Thực hiện kiểm tra
        var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(email)) {
            $("#error-email").text("Định dạng email không hợp lệ. Vui lòng nhập đúng định dạng.");
            return;
        }
        if (fullName === '') {
            $("#error-full-name").text("Vui lòng điền đầy đủ thông tin.");
            return;
        }
        var phoneRegex = /^\d+$/;
        if (!phoneRegex.test(phoneNumber)) {
            $("#error-phone").text("Số điện thoại không hợp lệ. Vui lòng chỉ nhập chữ số.");
            return;
        }

        // Kiểm tra điều kiện khác nếu cần

        // Nếu mọi thứ hợp lệ, thực hiện đặt hàng
       	location.href = "OrderSendMail";
    }

    $("#email").on("focus", function () {
        $("#error-email").text("");
    })

    $("#full-name").on("focus", function () {
        $("#error-full-name").text("");
    })

    $("#phone-number").on("focus", function () {
        $("#error-phone").text("");
    })
</script>
</html>