<%@page import="Model.Image"%>
<%@page import="java.util.List"%>
<%@page import="Model.ProductDetail"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
<link rel="stylesheet" type="text/css"
	href="styles/product-detail.css?sd">
<link rel="stylesheet" type="text/css" href="styles/lightslider.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<title>Chi tiết sản phẩm</title>
</head>
<%
ProductDetail productDetail = (ProductDetail) request.getAttribute("productDetail");
boolean isSale = productDetail.getSale() != null ? true : false;
List<Image> images = productDetail.getImages();
%>
<c:set var="Sale" value="${not empty productDetail.sale}" />
<body>
	<h1>${Sale}</h1>
	<jsp:include page="Components/header.jsp" />
	<jsp:include page="top-title.jsp">
		<jsp:param name="title" value="Chi tiết sản phẩm" />
	</jsp:include>
	<div class="container mt-3">
		<div class="row gx-4">
			<div class="col-9">
				<div class="left-side row">
					<div class="col-6">
						<div class="product-images">
							<ul id="imageGallery">
								<c:forEach items="<%=images%>" var="image">
									<li data-thumb="${image.path}" data-src="${image.path}"><img
										width="400px" alt="${image.name}" src="${image.path}"></li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div class="col-6">
						<div class="product-details">
							<h4 class="title text-primary-green" id="productName">${productDetail.name}</h4>
							<div class="description">
								<span>Tình trạng: </span><span
									class="description text-light-color" id="productStatus">
									${productDetail.status.description} </span>
							</div>
							<div class="description">
								<span>Mã sản phẩm: </span><span id="productId"
									class="description text-light-color">${productDetail.id}</span>
							</div>
							<div class="product-price-box">
								<div class="row gx-0">
									<c:if test="${Sale}">
										<div class="col-4">
											<h2 id="price" class="text-primary-green">
												<fmt:formatNumber value="${productDetail.newPrice}"
													type="currency"></fmt:formatNumber>
											</h2>
											<span class="saving">Tiết kiệm: <span class="text-red">
													<fmt:formatNumber
														value="${productDetail.unitPrice - productDetail.newPrice}"
														type="currency"></fmt:formatNumber>
											</span></span>
										</div>
										<div class="col-4">
											<span class="origin-price"> <fmt:formatNumber
													value="${productDetail.unitPrice}" type="currency"></fmt:formatNumber>
											</span>
										</div>
									</c:if>
									<c:if test="${!Sale}">
										<div class="col-4">
											<h2 id="price" class="text-primary-green">
												<fmt:formatNumber value="${productDetail.unitPrice}"
													type="currency"></fmt:formatNumber>
											</h2>
										</div>
									</c:if>
								</div>
							</div>
							<div class="weight mt-3">
								<p>
									<span class="description fw-bold">Trọng lượng: </span>
									<fmt:formatNumber type="number" pattern="###.##Kg"
										value="${productDetail.weight}" />
								</p>
								<span id="type-label" class="text-primary-green"></span>
								<div class="type-btns d-flex"></div>
							</div>
							<div class="quantity mt-3">
								<span class="description fw-bold">Số lượng: </span>
								<div class="quantity-form">
									<button class="btn-green minus-btn">-</button>
									<input class="input-quanlity" type="number" value="1">
									<button class="btn-green plus-btn">+</button>
								</div>
							</div>
							<button class="add-to-cart-btn btn-green mt-3">
								<div class="col-2">
									<i class="fas fa-shopping-cart cart-icon"></i>
								</div>
								<div class="col-10" id="add-to-cart">
									<span class="fw-bold">Thêm vào giỏ hàng</span><br> <span>Giao
										hàng tận nơi miễn phí</span>
								</div>
							</button>
							<div class="progress mr-3  mt-2">
								<div
									class="progress-bar 
                        progress-bar-striped 
                        progress-bar-animated my-progress-bar"
									aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
								</div>
							</div>
							<span class="fw-bold">Đã được miễn phí vận chuyển</span>
							<div class="sale-box">
								<div class="sale-title bg-primary-green">
									<i class="fa-solid fa-gift" style="font-size: 25px;"></i>
									Khuyến mãi đặc biệt !!!
								</div>
							</div>
							<div class="sale-detail border-s-r-5">
								<div class="d-flex align-items-center">
									<i class="fa-solid fa-check text-primary-green p-2 fs-2"></i> <span>Áp
										dụng Phiếu quà tặng/ Mã giảm giá theo ngành hàng.</span>
								</div>
								<div class="d-flex align-items-center">
									<i class="fa-solid fa-check text-primary-green p-2 fs-2"></i> <span>Giảm
										giá 10% khi mua từ 5 sản phẩm trở lên.</span>
								</div>
							</div>
						</div>
					</div>
					<div class="product-des mt-4">
						<button id="show-des-btn" data-target="description-box"
							class="px-4 py-2 btn-white-border-green active">MÔ TẢ
							SẢN PHẨM</button>
						<button id="show-guide-btn" data-target="buy-guide-box"
							class="px-4 py-2 btn-white-border-green">HƯỚNG DẪN MUA
							HÀNG</button>
						<button id="review-btn" data-target="review-box"
							class="px-4 py-2 btn-white-border-green">ĐÁNH GIÁ</button>
						<div class="description-box" id="description-box">
							<div id="showMore"><%=productDetail.getBlog().getContent()%></div>
						</div>
						<div class="description-box" id="buy-guide-box">
							<jsp:include page="Components/ProductDetail/buy-guide.jsp"></jsp:include>
						</div>
						<div class="description-box" id="review-box">
							<jsp:include page="Components/ProductDetail/review.jsp"></jsp:include>
						</div>
					</div>

					<jsp:include page="Components/ProductDetail/sanPhamLienQuan.jsp"></jsp:include>

					<jsp:include page="Components/ProductDetail/sanPhamDaXem.jsp"></jsp:include>

				</div>
			</div>
			<div class="col-3">
				<div class="right-side">
					<jsp:include page="Components/ProductDetail/chinhSachCuaHang.jsp"></jsp:include>
					<jsp:include page="Components/ProductDetail/coTheBanThich.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="Components/footer.jsp" />
	</footer>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script type="text/javascript" src="javascripts/jquery-3.7.1.js"></script>
<script type="text/javascript" src="javascripts/jquery.show-more.js"></script>
<script type="text/javascript" src="javascripts/lightslider.js"></script>
<script type="text/javascript" src="javascripts/main.js?ddsdss"></script>
<script type="text/javascript" src="javascripts/shopping-cart.js?dds"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
$(document).ready(function() {
    
    $("#showMore").showMore({
		minheight: 300,
	  buttontxtmore: "Xem thêm",
	  buttontxtless: "Ẩn bớt",
	  animationspeed: 250,
    })

    $("#add-to-cart").click(function (){
	let quanlity = $(".input-quanlity").val();
	let productId = ${productDetail.id}
	addToCart(productId,quanlity);
	notify2("Chúc mừng","Bạn đã thêm vào giỏ hàng thành công ","success",800);
    })
	show("description-box");
	   $('#imageGallery').lightSlider({
	        gallery: true,
	        item: <%=images.size()%>,
	        loop: true,
	        auto: true,
	        thumbItem: <%=images.size()%>,
	        slideMargin: 0,
	        enableDrag: true,
	        currentPagerPosition: 'left',
	    }); 
	 function plus(val) {
	        let inputQuanlity = $(".input-quanlity");
	        let newCount = Number(inputQuanlity.val()) + val;
	        if (newCount > 0) {
	            inputQuanlity.val(newCount);
	        }
	    }
    $(".plus-btn").on('click', () => plus(1));
    $(".minus-btn").on('click', () => plus(-1));
	let productDetailBtns = $(".product-des > button");
	productDetailBtns.click(function(){
		productDetailBtns.removeClass("actived");
		$(this).addClass("actived");
		show($(this).data("target"));
	});
	
	function hideAll(){
		let descriptionBoxes = $(".description-box");
		descriptionBoxes.each(function(){
			$(this).hide();
		})
	};
	function show(id){
		hideAll();
		$("#"+id).show();
	}

    
});
</script>
<style>
.showmore-button {
	cursor: pointer;
	background-color: #999;
	color: white;
	text-transform: uppercase;
	text-align: center;
	padding: 7px 5px 5px 5px;
	margin-top: 5px;
}
</style>
</html>