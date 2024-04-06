<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="styles/voucher.css">
<title></title>
</head>
<body>
	<section class="section_coupon container mt-3">
		<div class="card-deck d-flex mr-child-20">
			<c:forEach items="${discounts}" var="item">
				<div class="card card-coupon">
					<a class="btn-info">i</a>
					<div class="card-title font-weight">
						<strong>${item.code}</strong>
						<div class="coupon-info">
							<span class="">${item.description}</span>
						</div>
					</div>
					<div class="coupon-footer">
						<span class="small-text text-light-color">HSD:
							${item.expDate}</span>
						<div class="coupon-copy" data-target=${item.code}>Sao chép</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
</body>

<script type="text/javascript">
    $(".coupon-footer .coupon-copy").click(
	    function() {
		let code = $(this).data("target");
		navigator.clipboard.writeText(code);
		notify("Chúc mừng", "Bạn đã lưu mã giảm giá " + code
			+ " thành công", "success", false, 800);
	    })
</script>
</html>