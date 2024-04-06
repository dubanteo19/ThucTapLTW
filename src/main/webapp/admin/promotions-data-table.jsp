<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="styles/admin.css?a">
<script src="javascripts/chart.js"></script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container-fluid"></div>
	<div class="row">
		<jsp:include page="left-menu.jsp"></jsp:include>
		<div class="col-9 pt-3">
			<div
				class="container title d-flex justify-content-between bg-white rounded">
				<h5>Chương trình khuyến mãi</h5>
				<span class="date">Thứ 2, ngày 30/10/2023 - 11 giờ 25 phút</span>
			</div>
			<div class="container-fluid">
				<div class="row w-100">
					<div class="col-12">
						<div class="list-orders mt-3 bg-white">
							<div class="sub-title">
								<h4>Danh sách các chương trình khuyến mãi</h4>
							</div>
							<div class="btns mt-3 btn-sm">
								<button id="createCategory" class="btn btn-success "
									data-togle="modal" data-target="#newCategoryModal">
									<i class="fa-solid fa-plus"></i>Tạo chương trình mới
								</button>
							</div>
							<table class="table" id="orders">
								<thead>
									<tr>
										<th scope="col">ID</th>
										<th scope="col">Tên chương trình</th>
										<th scope="col">Phần trăm giảm</th>
										<th scope="col">Số lượng còn lại</th>
										<th scope="col">Ngày bắt đầu</th>
										<th scope="col">Ngày kết thúc</th>
										<th scope="col">Chức năng</th>
									</tr>
								</thead>
								<tbody>
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
<script src="../javascripts/bootstrap.min.js"></script>
<script src="../javascripts/bootstrap.bundle.js"></script>
<script type="text/javascript">
    
</script>

</html>