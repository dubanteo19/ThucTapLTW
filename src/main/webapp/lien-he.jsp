<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Title</title>
<link rel="stylesheet" type="text/css" href="styles/bootstrap.css">
<link rel="stylesheet" type="text/css" href="styles/base.css">
<link rel="stylesheet" type="text/css" href="styles/main.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="styles/news.css">
<link rel="stylesheet" type="text/css" href="styles/footer.css">
<link rel="stylesheet" href="styles/nav.css">
<link rel="stylesheet" href="styles/lien-he.css">
<script type="text/javascript" src="javascripts/jquery-3.7.1.js"></script>
</head>
<body>
	<jsp:include page="Components/header.jsp" />
	<jsp:include page="top-title.jsp">
		<jsp:param name="title" value="Liên hệ" />
	</jsp:include>
	<!-- ======= Contact Section ======= -->
	<section id="contact" class="contact">
		<div class="container" data-aos="fade-up">

			<div class="row mt-3">
				<div class="col-lg-6">
					<iframe
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.1986922460583!2d106.78813967481935!3d10.872487157414945!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175276398969f7b%3A0x9672b7efd0893fc4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBOw7RuZyBMw6JtIFRQLiBI4buTIENow60gTWluaA!5e0!3m2!1svi!2s!4v1698586770520!5m2!1svi!2s"
						width="600" height="750" style="border: 0;" allowfullscreen=""
						loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
				</div>
				<div class="col-lg-6 ">
					<div class="content-menu px-3 bg-footer ">
						<div class="title-head d-flex">
							<h4 class="font-weight-bold text-primary-green text-center pt-3">Cửa
								hàng Lương thực việt</h4>
							<img class="leaf-store" src="images/logo/leaf.png" alt="">
						</div>
						<div class="info social-links d-flex" style="flex-wrap: wrap;">
							<div class="address">
								<i class="fa-solid fa-location-dot"></i>
								<h4>Địa chỉ:</h4>
								<p>A108 Adam Street, New York, NY 535022</p>
							</div>

							<div class="open-hours">
								<i class="fa-regular fa-clock"></i>
								<h4>Thời gian làm việc:</h4>
								<p>
									Monday-Saturday:<br> 6:00 AM - 2300 PM
								</p>
							</div>

							<div class="email">
								<i class="fa-regular fa-envelope"></i>
								<h4>Email:</h4>
								<p>info@example.com</p>
							</div>

							<div class="phone">
								<i class="fa-solid fa-phone-volume"></i>
								<h4>Hostline:</h4>
								<p>+1 5589 55488 55s</p>
							</div>
						</div>

					</div>
					<div class="content-menu mt-4 px-3 bg-footer">
						<div class="title-head d-flex">
							<h4 class="font-weight-bold text-primary-green text-center pt-3">Liên
								hệ với chúng tôi</h4>
							<img class="leaf-store" src="images/logo/leaf.png" alt=""
								style="left: 245px !important;">
						</div>
						<form action="" method="post" role="form" class="php-email-form ">
							<div class="row">
								<p>Nếu bạn có thắc mắc gì, có thể gửi yêu cầu cho chúng tôi,
									và chúng tôi sẽ liên lạc lại với bạn sớm nhất có thể .</p>
								<div class="col-md-6 form-group">
									<input type="text" name="name" class="form-control" id="name"
										placeholder="Họ và tên" required>
								</div>
								<div class="col-md-6 form-group mt-3 mt-md-0">
									<input type="email" class="form-control" name="email"
										id="email" placeholder="Email" required>
								</div>
							</div>
							<div class="form-group mt-3">
								<input type="text" class="form-control" name="subject"
									id="subject" placeholder="Số điện thoại" required>
							</div>
							<div class="form-group mt-3">
								<textarea class="form-control" name="message" rows="8"
									placeholder="Nội dung " required></textarea>
							</div>
							<div class="my-3">
								<div class="loading">Loading</div>
								<div class="error-message"></div>
								<div class="sent-message">Tin nhắn của bạn đã được gửi.
									Cảm ơn!</div>
							</div>
							<div class="text-center pb-3">
								<button type="submit">Gửi thông tin</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		</div>

	</section>
	<!-- End Contact Section -->
	<footer>
		<jsp:include page="Components/footer.jsp" />
	</footer>
</body>
<script type="text/javascript" src="javascripts/main.js"></script>
</html>