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
    <link rel="stylesheet" type="text/css" href="../DataTables/datatables.css">
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
                        <div class="table-container mt-3">
                            <table id="datatable" class="row-border hover nowrap">
                                <thead>
                                <tr>
                                    <th class="text-center">Mã sản phẩm</th>
                                    <th style="padding: 0 5vw" class="text-center">Tên sản phẩm</th>
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

            <div class="modal fade" id="filterModal" tabindex="-1" role="dialog"
                 aria-labelledby="filterModalCenterTitle"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="filterModalLongTitle">Bộ lọc sản phẩm</h5>
                            <i data-dismiss="modal" class="close fa-solid fa-xmark"></i>
                        </div>
                        <div class="modal-body">
                            <form id="form-filter">
                                <div class="form-group row align-items-center">
                                    <label class="col" for="durationSelect">Thời gian thống kê</label>
                                    <div class="col">
                                        <select id="durationSelect" class="form-select" onchange="handleDurationChange()">
                                            <option value="3">3</option>
                                            <option value="6">6</option>
                                            <option value="12">12</option>
                                            <option selected value="-1">Tất cả</option>
                                            <option value="other">Khác</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <select id="durationType" class="form-select">
                                            <option value="DAY">DAY</option>
                                            <option selected value="MONTH">MONTH</option>
                                            <option value="YEAR">YEAR</option>
                                        </select>
                                    </div>
                                </div>
                                <input class="mt-2 form-control" type="number" id="durationInput" style="display: none;" placeholder="Khoảng thời gian khác">
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                            <button id="btnApplyFilter" class="btn btn-success" data-dismiss="modal">Áp dụng</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="../javascripts/bootstrap.min.js"></script>
<script type="text/javascript" src="../javascripts/jquery-3.7.1.js"></script>
<script type="text/javascript" src="../DataTables/datatables.js"></script>
<script type="text/javascript">
    function handleDurationChange() {
        var select = document.getElementById('durationSelect');
        var input = document.getElementById('durationInput');

        if (select.value === 'other') {
            input.style.display = 'block';
        } else {
            input.style.display = 'none';
        }
    }

    function getDurationValue() {
        var select = document.getElementById('durationSelect');
        var input = document.getElementById('durationInput');

        if (select.value === 'other') {
            return input.value;
        } else {
            return select.value;
        }
    }
    $(document)
        .ready(
            function () {
                let controlBar = document.createElement('div');

                controlBar.innerHTML = `
                            <div class="align-items-center">
                            <input style="padding-left: 5px" id="search" class="search" type="text" name="name" placeholder="Tìm kiếm...">
                            <input id="btn-search" style="margin-left: 10px; font-size: 14px" class="btn btn-success" type="submit" value="Tìm kiếm">
                             <button type="button" id="btn-filter" class="btn btn-info" style="margin-left: 10px; font-size: 14px""
                                    data-toggle="modal" data-target="#filterModal">
                                <i class="fa-solid fa-filter"></i>Bộ lọc</button>
                            </div>
                            `;

                $('#datatable').DataTable({
                    serverSide: true,
                    pageLength: 25,
                    scrollX: true,
                    scrollCollapse: true,
                    scrollY: '70vh',
                    ajax: {
                        url: 'warehouse-management',
                        type: 'POST',
                        data: function (d) {
                            d.duration = getDurationValue()
                            d.durationType = $('#durationType').val()
                        }
                    },
                    rowCallback: function (row, data) {
                        $(row).attr('data-id', data.product.id);
                    },
                    columnDefs: [
                        {
                            targets: [0, 2, 3, 4, 7],
                            className: 'dt-center'
                        },
                        {
                            targets: [2, 5, 6],
                            orderable: false
                        },
                        {targets: 0, name: 'id'},
                        {targets: 1, name: 'name'},
                        {targets: 3, name: 'unitsInStock'},
                        {targets: 4, name: 'totalSold'},
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
                                return new Date(data).toLocaleDateString('vi-VN', {
                                    day: '2-digit',
                                    month: '2-digit',
                                    year: 'numeric'
                                });
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
                    layout: {
                        topStart: controlBar,
                        topEnd: 'pageLength'
                    },
                    initComplete: function () {
                        var api = this.api();
                        var searchInput = $('#search');
                        var debounceTimeout;

                        function debounce(func, delay) {
                            var context = this;
                            clearTimeout(debounceTimeout);
                            debounceTimeout = setTimeout(function () {
                                func.apply(context);
                            }, delay);
                        }

                        searchInput.on('keyup', function () {
                            var value = this.value;
                            debounce(function () {
                                api.search(value).draw();
                            }, 300);
                        });
                    }
                });

                $(document).on('click', '.product-name', function () {
                    var productId = $(this).closest('tr').data('id');
                    let href = "AdminProductController?action=detail&productId=" + productId;
                    location.href = href;
                });

                $('#btnApplyFilter').click(function (event) {
                    reloadDataTable();
                });

                function reloadDataTable() {
                    $('#datatable').DataTable().ajax.reload();
                }
            });

    $(".func-btns button").click(function () {
        let href = $(this).data("target");
        location.href = href;
    });
    $(".nav-link").removeClass("active");
    $("#warehouse-product-nav-link").addClass("active");
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