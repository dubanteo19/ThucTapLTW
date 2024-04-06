<%@page import="Controller.cart.Cart"%>
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
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="styles/base.css">
<link rel="stylesheet" type="text/css" href="styles/main.css">
<link rel="stylesheet" type="text/css" href="styles/product-detail.css">
<link rel="stylesheet" type="text/css" href="styles/lightslider.css">
<link rel="stylesheet" type="text/css"
	href="styles/san-pham-khuyen-mai.css">
<link rel="stylesheet" type="text/css" href="styles/aside.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<title></title>
</head>

<body>
	<jsp:include page="Components/header.jsp" />

	<jsp:include page="top-title.jsp">
		<jsp:param name="title" value="Sản phẩm khuyến mãi" />
	</jsp:include>

	<div id="wrapper">
		<div class="container mt-3">
			<div class="row gx-4">
				<div class="col-md-12">
					<section class="section_coupon">
						<div class="card-deck d-flex mr-child-20">
							<div class="card card-coupon">
								<a href="" class="btn-info">i</a>
								<div class="card-title">
									DOLA10
									<div class="coupon-info">
										<span>Giảm 10.000đ giá trị đơn hàng</span>
									</div>
								</div>
								<div class="coupon-footer">
									<span class="small-text text-light-color">HSD: 1/10/2023</span>
									<div class="coupon-copy">Sao chép</div>
								</div>
							</div>
							<div class="card card-coupon">
								<a href="" class="btn-info">i</a>
								<div class="card-title">
									DOLA10
									<div class="coupon-info">
										<span>Giảm 10.000đ giá trị đơn hàng</span>
									</div>
								</div>
								<div class="coupon-footer">
									<span class="small-text text-light-color">HSD: 1/10/2023</span>
									<div class="coupon-copy">Sao chép</div>
								</div>
							</div>
							<div class="card card-coupon">
								<a href="" class="btn-info">i</a>
								<div class="card-title">
									DOLA10
									<div class="coupon-info">
										<span>Giảm 10.000đ giá trị đơn hàng</span>
									</div>
								</div>
								<div class="coupon-footer">
									<span class="small-text text-light-color">HSD: 1/10/2023</span>
									<div class="coupon-copy">Sao chép</div>
								</div>
							</div>
							<div class="card card-coupon">
								<a href="" class="btn-info">i</a>
								<div class="card-title">
									DOLA10
									<div class="coupon-info">
										<span>Giảm 10.000đ giá trị đơn hàng</span>
									</div>
								</div>
								<div class="coupon-footer">
									<span class="small-text text-light-color">HSD: 1/10/2023</span>
									<div class="coupon-copy">Sao chép</div>
								</div>
							</div>
						</div>
					</section>
					<section>
						<div class="row">
							<aside class="col-md-3 mb-child-20">
								<div class="aside-content bg-light-green">
									<div class="title-head-large text-primary-green mb-3">Danh
										mục sản phẩm</div>
									<nav class="nav-category">
										<ul class="nav-list mb-child-20">
											<li class="nav-item"><a href="">Củ quả</a> <i
												class="fa-regular fa-plus open-menu" style="color: #000000;"></i>
											</li>
											<li class="nav-item"><a href="">Đậu</a> <i
												class="fa-regular fa-plus open-menu" style="color: #000000;"></i>
											</li>
											<li class="nav-item"><a href="">Gạo</a> <i
												class="fa-regular fa-plus open-menu" style="color: #000000;"></i>
											</li>
											<li class="nav-item"><a href="">Hạt</a> <i
												class="fa-regular fa-plus open-menu" style="color: #000000;"></i>
											</li>
											<li class="nav-item"><a href="">Ngũ cốc</a> <i
												class="fa-regular fa-plus open-menu" style="color: #000000;"></i>
											</li>
											<li class="nav-item"><a href="">Sản phẩm khác</a> <i
												class="fa-regular fa-plus open-menu" style="color: #000000;"></i>
											</li>
										</ul>
									</nav>
								</div>
								<div class="title-head-large text-primary-green dash-border">Bộ
									lọc sản phẩm</div>
								<!-- Giá -->
								<div class="aside-content bg-light-green">
									<div class="title-head text-primary-green my-2">Chọn mức
										giá</div>
									<div class="input-group flex-column price-filter">
										<label for="min-price">Tối thiểu</label> <input
											class="input-box" type="number" name="min-price"
											id="min-price" placeholder="Nhập số tiền tối thiểu">
										<label for="max-price">Tối đa</label> <input class="input-box"
											type="number" name="max-price" id="max-price"
											placeholder="Nhập số tiền tối đa">
									</div>
								</div>
								<!-- Thương hiệu -->
								<!-- Trọng lượng -->
								<div class="aside-content bg-light-green">
									<div class="title-head text-primary-green my-2">Trọng
										lượng</div>
									<div class="scroll">
										<div class="form-group">
											<div class="form-check">
												<label for="90g">1 ký</label> <input type="checkbox"
													name="90g" id="90g" class="form-check-input">
											</div>
											<div class="form-check">
												<label for="220g">10 ký</label> <input type="checkbox"
													name="220g" id="220g" class="form-check-input">
											</div>
											<div class="form-check">
												<label for="250g">100 ký</label> <input type="checkbox"
													name="250g" id="250g" class="form-check-input">
											</div>
										</div>
									</div>
								</div>
							</aside>
							<div class="col-md-9">
								<nav class="nav-filter d-flex align-items-center mb-4">
									<div>
										<i class="fa-sharp fa-solid fa-arrow-down-a-z"
											style="color: #000000;"></i> Sắp xếp theo:
									</div>
									<ul>
										<li><a class="border-green" href="">Tên A-Z</a></li>
										<li><a class="border-green" href="">Tên Z-A</a></li>
										<li><a class="border-green" href="">Hàng mới</a></li>
										<li><a class="border-green" href="">Giá thấp đến cao</a>
										</li>
										<li><a class="border-green" href="">Giá cao xuống
												thấp</a></li>
									</ul>
								</nav>
								<div class="products-view-grid">
									<div class="row mb-child-20">
										<div class="col-6 col-md-4 col-xl-3">
											<c:forEach items="${dsSanPham}" var="item">
												<jsp:include page="/templates/product-template.jsp">
													<jsp:param name="id" value="${item.id}" />
													<jsp:param name="name" value="${item.name}" />
													<jsp:param name="thumb" value="${item.thumb}" />
													<jsp:param name="unitPrice" value="${item.unitPrice}" />
													<jsp:param name="newPrice" value="${item.newPrice}" />
													<jsp:param name="sale" value="${item.sale}" />
												</jsp:include>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</div>
				</div>
			</div>
		</div>
		</section>
		<footer>
			<jsp:include page="Components/footer.jsp" />
		</footer>
</body>
<script type="text/javascript" src="javascripts/jquery-3.7.1.js"></script>
<script type="text/javascript" src="javascripts/lightslider.js"></script>
<script type="text/javascript" src="javascripts/main.js"></script>
<script type="text/javascript" src="javascripts/lightslider.js"></script>
<script type="text/javascript" src="javascripts/shopping-cart.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $('#imageGallery').lightSlider({
        gallery: true,
        item: 1,
        loop: true,
        auto: true,
        thumbItem: 6,
        slideMargin: 0,
        enableDrag: true,
        currentPagerPosition: 'left',
        onSliderLoad: function(el) {
            el.lightGallery({
                selector: '#imageGallery .lslide'
            });
        }
    });
    var showDesBtn = $("#show-des-btn");
    var showGuideBtn = $("#show-guide-btn");
    $(".buy-guide-box").hide();
    showDesBtn.click(function(event) {
        $(".description-box").show();
        $(".buy-guide-box").hide();
        showDesBtn.addClass('active');
        showGuideBtn.removeClass('active');
    });
    showGuideBtn.click(function(event) {
        $(".description-box").hide();
        $(".buy-guide-box").show();
        showGuideBtn.addClass('active');
        showDesBtn.removeClass('active');
    });
});
</script>

</html>