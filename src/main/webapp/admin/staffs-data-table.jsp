<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <link rel="stylesheet" type="text/css" media="all" href='../styles/bootstrap.css'>
    <link rel="stylesheet" type="text/css" href="../styles/base.css">
    <link rel="stylesheet" type="text/css" href="../styles/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="styles/admin.css">
    <script src="javascripts/chart.js"></script>
</head>

<body>
    <div class="container-fluid p-8 bg-grey" style= "padding-top: 60px">
        <div class="container title d-flex justify-content-between bg-white rounded">
            <h5>Quản lý sản phấm</h5>
            <span class="date">Thứ 2, ngày 30/10/2023 - 11 giờ 25 phút</span>
        </div>
        <div class="container-fluid">
            <div class="row w-100">
                <div class="col-12">
                    <div class="list-orders mt-3 bg-white">
                        <div class="sub-title">
                            <h4>Tình trạng đơn hàng</h4>
                        </div>
                        <table class="table" id="orders">
                            <thead>
                                <tr>
                                    <th scope="col">ID khách hàng</th>
                                    <th scope="col">Tên khách hàng</th>
                                    <th scope="col">Tổng tiền</th>
                                    <th scope="col">Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>DH3331</td>
                                    <td>Dư Ban Teo</td>
                                    <td>100.000đ</td>
                                    <td><button class="btn btn-info btn-sm">Chờ xử lý</button></td>
                                </tr>
                                <tr>
                                    <td>DH2312</td>
                                    <td>Lê Hoàng Long</td>
                                    <td>210.000đ</td>
                                    <td><button class="btn btn-warning btn-sm">Đang vận chuyển</button></td>
                                </tr>
                                <tr>
                                    <td>DH8321</td>
                                    <td>Ngô Cẩm Ly</td>
                                    <td>400.000đ</td>
                                    <td><button class="btn btn-success btn-sm">Đã hoàn thành</button></td>
                                </tr>
                                <tr>
                                    <td>DH1121</td>
                                    <td>Hà Hạnh Chi</td>
                                    <td>190.000đ</td>
                                    <td><button class="btn btn-danger btn-sm">Đã hủy</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                   
                </div>
              
            </div>
</body>
<script type="text/javascript" src="javascripts/chartDraw.js"></script>
<script type="text/javascript" src="javascripts/Utils.js"></script>
</html>