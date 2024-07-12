<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <link rel="stylesheet" type="text/css" media="all"
          href="../styles/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../styles/base.css">
    <link rel="stylesheet" type="text/css" href="../styles/main.css">

    <link rel="stylesheet" href="styles/admin.css?dd">
    <link rel="stylesheet" type="text/css" href="../Datatables-V2/datatables.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .product-name:hover {
            color: var(--primary-green);
            cursor: pointer;
        }

        .product-name {
            white-space: normal;
            word-wrap: break-word;
        }

        .break-word {
            white-space: normal;
            word-wrap: break-word;
        }

        .close {
            cursor: pointer;
        }

        .modal-body label:not(.col) {
            margin-bottom: 10px;
        }

        .btn-info {
            color: #fff !important;
            background-color: #17a2b8 !important;
            border-color: #17a2b8 !important;
        }

        .btn-info:hover {
            color: #fff;
            background-color: #138496;
            border-color: #117a8b;
        }

        .btn-control {
            margin-left: 10px;
            vertical-align: inherit !important;
        }

        .btn-control i {
            margin-right: 6px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .select-option {
            cursor: pointer;
        }

        .autocomplete {
            /*the container must be positioned relative:*/
            position: relative;
            display: inline-block;
        }

        .autocomplete-items {
            position: absolute;
            border: 1px solid #d4d4d4;
            border-bottom: none;
            border-top: none;
            z-index: 99;
            /*position the autocomplete items to be the same width as the container:*/
            top: 100%;
            left: 0;
            right: 0;
        }

        .autocomplete-items div {
            padding: 10px;
            cursor: pointer;
            background-color: #fff;
            border-bottom: 1px solid #d4d4d4;
        }

        .autocomplete-items div:hover {
            /*when hovering an item:*/
            background-color: #e9e9e9;
        }

        .autocomplete-active {
            /*when navigating through the items using the arrow keys:*/
            background-color: DodgerBlue !important;
            color: #ffffff;
        }

        .custom-select, .search {
            width: auto !important;
            display: inline-block !important;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container-fluid"></div>
<div class="row">
    <jsp:include page="left-menu.jsp"></jsp:include>
    <div class="col-10 pt-3">
        <div class="container-fluid">
            <div class="row w-100">
                <div class="col-12">
                    <div class="bg-white">
                        <div class="sub-title">
                            <h4>Quản lý nhập kho</h4>
                        </div>
                        <div class="table-container mt-3">
                            <div>
                                <div class="table-control">
                                    <button class="btn btn-secondary">Nhập từ File</button>
                                </div>

                                <div class="mt-2">
                                    <label>Tìm kiếm sản phẩm</label>
                                    <input style="padding-left: 5px; margin-left: 10px" id="search" class="search form-control" type="search" name="name" placeholder="Tìm kiếm...">
                                </div>
                            </div>
                            <table id="datatable" class="row-border hover nowrap w-100 mt-1">
                                <thead>
                                <tr>
                                    <th class="text-center">Mã sản phẩm</th>
                                    <th style="min-width: 10vw">Tên sản phẩm</th>
                                    <th class="text-right">Trọng lượng</th>
                                    <th class="text-right">Giá nhập</th>
                                    <th class="text-right">Số lượng nhập</th>
                                    <th class="text-right">Tồn kho</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="../javascripts/popper.min.js"></script>
<script type="text/javascript" src="../javascripts/bootstrap.min.js"></script>
<script type="text/javascript" src="../javascripts/jquery-3.7.1.js"></script>
<script type="text/javascript" src="../Datatables-V2/datatables.js"></script>
<script type="text/javascript" src="../javascripts/autocomplete.js"></script>
<script type="text/javascript">
    function formatNumber(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    $(document)
        .ready(
            function () {

                let table = $('#datatable').DataTable({
                    pageLength: 25,
                    scrollX: true,
                    scrollCollapse: true,
                    scrollY: '55vh',
                    order: [],
                    columnDefs: [
                        {
                            targets: [2, 3, 4, 5],
                            className: 'dt-right'
                        },
                        {targets: 0, name: 'id'},
                        {targets: 1, name: 'name'},
                        {targets: 2, name: 'weight'},
                        {targets: 3, name: 'costPrice'},
                        {targets: 4, name: 'importQuantity'},
                        {targets: 5, name: 'unitsInStock'},
                    ],
                    layout: {
                        topStart: null,
                        topEnd: null
                    },
                    language: {
                        "sProcessing": "Đang xử lý...",
                        "sLengthMenu": "Hiển thị _MENU_ mục",
                        "sZeroRecords": "Không tìm thấy dữ liệu",
                        "sInfo": "Hiển thị _START_ đến _END_ của _TOTAL_ mục",
                        "sInfoEmpty": "Hiển thị 0 đến 0 của 0 mục",
                        "sInfoFiltered": "(được lọc từ _MAX_ mục)",
                        "emptyTable": "Vui lòng thêm sản phẩm",
                        "sInfoPostFix": "",
                        "sSearch": "Tìm kiếm:",
                        "sUrl": "",
                        "oPaginate": {
                            "sFirst": "Đầu",
                            "sPrevious": "Trước",
                            "sNext": "Tiếp",
                            "sLast": "Cuối"
                        },
                        "oAria": {
                            "sSortAscending": ": kích hoạt để sắp xếp cột tăng dần",
                            "sSortDescending": ": kích hoạt để sắp xếp cột giảm dần"
                        }
                    },
                });

                $(document).on('click', '.product-name', function () {
                    var productId = $(this).closest('tr').data('id');
                    let href = "AdminProductController?action=detail&productId=" + productId;
                    location.href = href;
                });

                $('.input-number').on('input', function () {
                    let value = $(this).val();
                    value = value.replace(/\D/g, '');
                    value = value.replace(/^0+/, '');
                    $(this).val(value);
                });
            });

    $(".nav-link").removeClass("active");
    $("#nhap-kho-nav-link").addClass("active");
</script>

</html>