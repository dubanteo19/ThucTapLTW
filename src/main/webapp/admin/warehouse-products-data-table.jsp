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
          href=../styles/bootstrap.css'>
    <link rel="stylesheet" type="text/css" href="../styles/base.css">
    <link rel="stylesheet" type="text/css" href="../styles/main.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="styles/admin.css?dd">
    <link rel="stylesheet" href="styles/pagination.css?dds">
    <link rel="stylesheet" type="text/css" href="../DataTables/datatables.css">

    <style>
        .product-name:hover {
            color: var(--primary-green);
            cursor: pointer;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container-fluid"></div>
<div class="row">
    <jsp:include page="left-menu.jsp"></jsp:include>
    <div class="col-10 pt-3">
        <div
                class="container title d-flex justify-content-between bg-white rounded">
            <h5>Quản lý nhập kho</h5>
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
                    <div class=" mt-3 bg-white">
                        <div class="sub-title">
                            <h4>Danh sách sản phẩm</h4>
                        </div>
                        <div class="table-container">
                            <table id="datatable" class="row-border hover nowrap">
                                <thead>
                                <tr>
                                    <th class="text-center">Mã sản phẩm</th>
                                    <th class="text-center">Tên sản phẩm</th>
                                    <th class="text-center">Hình ảnh</th>
                                    <th class="text-center">Số lượng tồn kho</th>
                                    <th class="text-center">Số lượng đã bán</th>
                                    <th class="text-center">Tình trạng</th>
                                    <th class="text-center">Danh mục</th>
                                    <th class="text-center">Ngày nhập kho</th>
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
<script type="text/javascript" src="../javascripts/jquery-3.7.1.js"></script>
<script type="text/javascript" src="../javascripts/pagination.js"></script>
<script type="text/javascript" src="../DataTables/datatables.js"></script>
<script type="text/javascript">
    $(document)
        .ready(
            function () {
                $('#datatable').DataTable({
                    serverSide: true,
                    pageLength: 25,
                    scrollX: true,
                    scrollCollapse: true,
                    scrollY: '70vh',
                    ajax: {
                        url: 'warehouse-management',
                        type: 'POST'
                    },
                    rowCallback: function (row, data) {
                        $(row).attr('data-id', data.id);
                    },
                    columnDefs: [
                        {
                            targets: [0, 2, 3, 4],
                            className: 'dt-center'
                        },
                        {
                            targets: [2, 5, 6],
                            orderable: false
                        },
                        { targets: 0, name: 'id'},
                        { targets: 1, name: 'name' },
                        { targets: 3, name: 'unitsInStock' },
                        { targets: 4, name: 'totalSold' },
                        { targets: 7, name: 'lastUpdated' },
                    ],
                    columns: [
                        {data: 'product.id'},
                        {
                            data: 'product.name',
                            render: function (data, type, row) {
                                return '<span class="product-name">' + data + '</span>';
                            }
                        },
                        {
                            data: 'product.thumb',
                            render: function (data, type, row) {
                                return '<img src="../' + data + '" width="100px" height="150px">';
                            }
                        },
                        {data: 'product.unitsInStock'},
                        {data: 'totalSold'},
                        {data: 'product.status.description'},
                        {data: 'product.categories.name'},
                        {
                            data: 'product.lastUpdated',
                            render: function (data, type, row) {
                                return new Date(data).toLocaleString();
                            }
                        }
                    ],
                    language: {
                        "sProcessing": "Đang xử lý...",
                        "sLengthMenu": "Hiển thị _MENU_ mục",
                        "sZeroRecords": "Không tìm thấy dữ liệu",
                        "sInfo": "Hiển thị _START_ đến _END_ của _TOTAL_ mục",
                        "sInfoEmpty": "Hiển thị 0 đến 0 của 0 mục",
                        "sInfoFiltered": "(được lọc từ _MAX_ mục)",
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
            });

    $(".func-btns button").click(function () {
        let href = $(this).data("target");
        location.href = href;
    });
    $(".nav-link").removeClass("active");
    $("#products-nav-link").addClass("active");
    let page = '${page}';
    let totalPage = '${totalPage}';
    $("#pagination").pagination(
        {
            dataSource: function (done) {
                var result = [];
                for (var i = 1; i < totalPage; i++) {
                    result.push(i);
                }
                done(result);
            },
            pageNumber: page,
            pageSize: 10,
            callback: function (data, pagination) {
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