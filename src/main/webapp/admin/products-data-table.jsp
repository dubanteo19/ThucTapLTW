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
	href=../styles/bootstrap.css'>
<link rel="stylesheet" type="text/css" href="../styles/base.css">
<link rel="stylesheet" type="text/css" href="../styles/main.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="styles/admin.css?dd">
<link rel="stylesheet" href="styles/pagination.css?dds">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container-fluid"></div>
	<div class="row">
		<jsp:include page="left-menu.jsp"></jsp:include>
		<div class="col-9 pt-3">
			<div
				class="container title d-flex justify-content-between bg-white rounded">
				<h5>Quản lý sản phấm</h5>
				<span class="date">Thứ 2, ngày 30/10/2023 - 11 giờ 25 phút</span>
			</div>
			<div class="container-fluid">
				<div class="row w-100">
					<div class="col-12">
						<div class="btns mt-3 btn-sm func-btns">
							<button id="newProduct"
								data-target="AdminProductController?action=forward"
								class="btn btn-success">
								<i class="fa-solid fa-plus"></i>Tạo sản phẩm mới
							</button>
							<button class="btn btn-warning ">
								<i class="fa-solid fa-file-pdf"></i>Xuất file PDF
							</button>
							<button class="btn btn-success ">
								<i class="fa-solid fa-file-excel"></i>Xuất file excel
							</button>
							<button id="categorybtn" class="btn btn-info "
								data-target="Category?action=get">
								<i class="fa-solid fa-list"></i>Quản lý danh mục
							</button>
						</div>
						<form action="AdminProductController" method="post"
							enctype="multipart/form-data">
							<input type="hidden" name="action" value="search">
							<div class="my-3">
								<label>Tìm kiếm sản phẩm</label> <input type="text" name="name"
									placeholder="Tên sản phẩm"> <input
									class="btn btn-success btn-sm" type="submit" value="Tìm kiếm">
							</div>
						</form>
						<div class=" mt-3 bg-white">
							<div class="sub-title">
								<h4>Danh sách sản phẩm</h4>
							</div>
							<table class="table" id="orders">
								<thead>
									<tr>
										<th scope="col">Mã sản phẩm</th>
										<th scope="col">Tên sản phẩm</th>
										<th scope="col">Hình ảnh</th>
										<th scope="col">Số lượng</th>
										<th scope="col">Tình trạng</th>
										<th scope="col">Danh mục</th>
										<th scope="col">Chức năng</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${products}">
										<tr>
											<td>${item.id}</td>
											<td>${item.name}</td>
											<td><img src='../${item.thumb}' width="100px"
												height="150px"></td>
											<td>${item.unitsInStock}</td>
											<td>${item.status.description}</td>
											<td>${item.categories.name}</td>
											<td>
												<div class="btn-group">
													<button class="btn btn-secondary btn-sm me-1"
														data-target=${item.id} >
														<i class='fa-solid fa-trash'></i>
													</button>
													<button class="btn btn-warning btn-sm detail-btn"
														data-target=${item.id}>
														<i class="fa-solid fa-pen-to-square"></i>
													</button>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="d-flex justify-content-center">
					<nav id="pagination"
						class="paginationjs paginationjs-theme-green paginationjs-big"></nav>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="../javascripts/jquery-3.7.1.js"></script>
<script type="text/javascript" src="../javascripts/pagination.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$(".detail-btn")
								.click(
										function() {
											let productId = $(this).data(
													"target");
											let href = "AdminProductController?action=detail&productId="
													+ productId;
											location.href = href;
										})
					});

	$(".func-btns button").click(function() {
		let href = $(this).data("target");
		location.href = href;
	});
	$(".nav-link").removeClass("active");
	$("#products-nav-link").addClass("active");
	let page = '${page}';
	let totalPage = '${totalPage}';
	$("#pagination").pagination(
			{
				dataSource : function(done) {
					var result = [];
					for (var i = 1; i < totalPage; i++) {
						result.push(i);
					}
					done(result);
				},
				pageNumber : page,
				pageSize : 10,
				callback : function(data, pagination) {
					let pageNumber = pagination.pageNumber;
					if (pageNumber != page) {
						let href = "AdminProductController?action=get&page="
								+ pageNumber;
						location.href = href;
					}
				}
			})
</script>

</html>