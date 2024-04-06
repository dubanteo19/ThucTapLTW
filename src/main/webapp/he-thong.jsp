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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="styles/news.css">
    <link rel="stylesheet" type="text/css" href="styles/footer.css">
    <link rel="stylesheet" href="styles/nav.css">
    <link rel="stylesheet" href="styles/lien-he.css">
    <script type="text/javascript" src="javascripts/jquery-3.7.1.js"></script>
    <style>
        .fa-solid{
            background-color: var(--primary-green);
            border-radius: 50%;
            padding: 20px;
            font-size: 30px;
            color: #fff;
        }
        .item {
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: left;
            padding: 10px 0;
        }
        .thump{
            padding-right: 10px;
        }
        .name-cuahang{
            color: var(--primary-green);
        }
        .he-thong:hover{
            background-color: var(--hover-green);
            color: #fff!important;
        }
    </style>
</head>
<body>
	<jsp:include page="Components/header.jsp" />
	
		<jsp:include page="top-title.jsp">
		<jsp:param name="title" value="Hệ thống" />
	</jsp:include>
	
<section id="contact" class="contact">
    <div class="container">
        <div class="row justify-content-between" style="border: 2px solid #679210; border-radius: 5px">
            <div class="col-lg-4">
                <div class="item d-flex">
                    <div class="thump">
                        <i class="fa-solid fa-shop"></i>
                    </div>
                    <span>Hệ thống 8 cửa hàng<br>Trên toàn quốc</span>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="item d-flex">
                    <div class="thump">
                        <i class="fa-solid fa-people-group"></i>
                    </div>
                    <span>Hơn 100 nhân viên<br>Để phục vụ quý khách</span>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="item d-flex">
                    <div class="thump">
                        <i class="fa-solid fa-clock"></i>
                    </div>
                    <span>Mở cửa 8-22h<br>cả CN &amp; Lễ tết</span>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-lg-3 bg-footer " style="height: 180px; border-radius: 5px">
                <div class="box p-3 mt-3 he-thong" style="border: 2px solid #679210; border-radius: 5px">
                    <div class="store-list he-thong" style="line-height: 1">
                        <p class="name-cuahang fw-bold">Lương thực Sài Gòn</p>
                        <p class="store-name">
                            <b>Địa chỉ:</b> Khoa công nghệ thông tin Dại học Nông Lâm</p>
                        <p class="store-phone">
                            <b>Hotline:</b>
                            <a class="phone-url" href="tel:1900 6750">1900 6750</a></p>
                    </div>
                </div>
            </div>
            <div class="col-lg-9">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.1986922460583!2d106.78813967481935!3d10.872487157414945!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175276398969f7b%3A0x9672b7efd0893fc4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBOw7RuZyBMw6JtIFRQLiBI4buTIENow60gTWluaA!5e0!3m2!1svi!2s!4v1698586770520!5m2!1svi!2s" width="900" height="750" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
        </div>
    </div>
    </div>

</section><!-- End Contact Section -->
<footer>
    	<jsp:include page="Components/footer.jsp" />
</footer>
</body>
<script type="text/javascript" src="javascripts/main.js"></script>
</html>