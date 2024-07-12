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
                            <h4>Thống kê</h4>
                        </div>
                        <div class="table-container mt-3">
                            <table id="datatable" class="row-border hover nowrap">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th class="text-center">Mã sản phẩm</th>
                                    <th style="min-width: 10vw">Tên sản phẩm</th>
                                    <th class="text-center">Hình ảnh</th>
                                    <th>Tình trạng</th>
                                    <th class="text-right">Tồn kho</th>
                                    <th class="text-right">Đã bán</th>
                                    <th>Lợi nhuận</th>
                                    <th>Danh mục</th>
                                    <th>Ngày nhập kho</th>
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
                                <div class="form-group">
                                    <div class="form-group row align-items-center">
                                        <label class="col" for="durationSelect">Thời gian thống kê</label>
                                        <div class="col">
                                            <select id="durationSelect" class="form-select"
                                                    onchange="handleDurationChange()">
                                                <option selected value="3">3</option>
                                                <option value="6">6</option>
                                                <option value="12">12</option>
                                                <option value="-1">Tất cả</option>
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
                                    <input class="mt-2 form-control input-number" type="text" inputmode="numeric" pattern="[0-9]*" id="durationInput" style="display: none;"
                                           placeholder="Khoảng thời gian khác">
                                </div>

                                <div class="form-group row align-items-center">
                                    <label class="col" for="categoriesList">Danh mục sản phẩm</label>
                                    <div class="col">
                                        <select id="categoriesList" class="form-select">
                                            <c:forEach items="${categoriesList}" var="item">
                                                <option value="${item.id}">${item.name}</option>
                                            </c:forEach>
                                            <option selected value="-1">Tất cả</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row align-items-center">
                                    <label class="col" for="statusList">Tình trạng sản phẩm</label>
                                    <div class="col">
                                        <select id="statusList" class="form-select">
                                            <option value="Còn hàng">Còn hàng</option>
                                            <option value="Hết hàng">Hết hàng</option>
                                            <option value="Cần nhập">Cần nhập</option>
                                            <option selected value="-1">Tất cả</option>
                                        </select>
                                    </div>
                                </div>
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
<script type="text/javascript" src="../javascripts/popper.min.js"></script>
<script type="text/javascript" src="../javascripts/bootstrap.min.js"></script>
<script type="text/javascript" src="../javascripts/jquery-3.7.1.js"></script>
<script type="text/javascript" src="../Datatables-V2/datatables.js"></script>
<script type="text/javascript" src="../javascripts/autocomplete.js"></script>
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

    function formatNumber(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(amount);
    }

    function formatDetailRow(data) {
        // `d` is the original data object for the row
        return (
            '<dl>' +
                formatSubDetailOnRow('Giá nhập', formatCurrency(data.product.costPrice)) +
                formatSubDetailOnRow(' - Trọng lượng', data.product.weight) +
                '<br>' +
                formatSubDetailOnRow('Giá bán', formatCurrency(data.product.unitPrice)) +
                '<br>' +
                formatSubDetailOnRow('Doanh thu', formatCurrency(data.totalSold * data.product.unitPrice)) +
            '</dl>'
        );
    }

    function formatSubDetailOnRow(label, data) {
        return '<b>' + label + ': </b>' + data;
    }

    $(document)
        .ready(
            function () {
                let controlBar = document.createElement('div');

                controlBar.innerHTML = `
                            <div class="align-items-center">
                            <label>Tìm kiếm sản phẩm</label>
                            <input style="padding-left: 5px; margin-left: 10px" id="search" class="search form-control" type="search" name="name" placeholder="Tìm kiếm...">
                            </div>
                            `;

                let createBar = document.createElement('div');
                createBar.innerHTML = `
                        <div>
                         <select id="typeStatistics" class="form-select custom-select">
                            <option selected>Dạng bảng</option>
                            <option>Biểu đồ</option>
                        </select>

                        <button type="button" id="btn-filter" class="btn btn-info btn-control"
                                    data-toggle="modal" data-target="#filterModal">
                                <i class="fa-solid fa-filter"></i>Bộ lọc</button>
                        </div>
                `;

                let table = $('#datatable').DataTable({
                    serverSide: true,
                    pageLength: 25,
                    scrollX: true,
                    scrollCollapse: true,
                    scrollY: '55vh',
                    order: [],
                    stateSave: true,
                    ajax: {
                        url: 'thong-ke',
                        type: 'POST',
                        data: function (d) {
                            NProgress.start();
                            d.duration = getDurationValue();
                            d.durationType = $('#durationType').val();
                            d.categoryId = $('#categoriesList').val();
                            d.status = $('#statusList').val();
                            NProgress.done();
                        }
                    },
                    rowCallback: function (row, data) {
                        $(row).attr('data-id', data.product.id);
                    },
                    columnDefs: [
                        {
                            targets: [0, 2],
                            className: 'dt-center'
                        },
                        {
                            targets: [6, 8, 4, 5],
                            className: 'dt-right'
                        },
                        {
                            targets: [2, 3, 7],
                            orderable: false
                        },
                        {targets: 0, name: 'id'},
                        {targets: 1, name: 'name'},
                        {targets: 4, name: 'unitsInStock'},
                        {targets: 5, name: 'totalSold'},
                        {targets: 6, name: 'totalRevenue'},
                        {targets: 2, name: 'thumb'}
                    ],
                    columns: [
                        {
                            className: 'dt-control',
                            orderable: false,
                            data: null,
                            defaultContent: ''
                        },
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
                                return '<img src="../' + data + '" width="100px" height="100px">';
                            }
                        },
                        {
                            data: null,
                            render: function (data, type, row) {
                                var status = row.status;

                                if (status.toLowerCase() === 'cần nhập') {
                                    var formattedRequiredQuantity = formatNumber(data.requiredQuantity);
                                    return '<span class="break-word">' + status + ' <br>' + formattedRequiredQuantity + ' SP</span>';
                                }
                                return '<span class="break-word">' + status + '</span>';
                            }
                        },
                        {
                            data: 'product.unitsInStock',
                            render: function (data, type, row) {
                                return '<span>' + formatNumber(data) + '</span>';
                            }
                        },
                        {
                            data: 'totalSold',
                            render: function (data, type, row) {
                                return '<span>' + formatNumber(data) + '</span>';
                            }
                        },
                        {
                            data: 'totalRevenue',
                            render: function (data, type, row) {
                                return formatCurrency(data)
                            }
                        },
                        {
                            data: 'product.categories.name',
                            render: function (data, type, row) {
                                return '<span class="break-word">' + data + '</span>';
                            }
                        },
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
                        top2Start: createBar,
                        top2End: 'buttons',
                        topStart: controlBar,
                        topEnd: 'pageLength'
                    },
                    buttons: [
                        {
                            extend: 'collection',
                            text: 'Xuất File',
                            attr: {
                                class: 'btn btn-warning'
                            },
                            buttons: [
                                {
                                    extend: 'copyHtml5',
                                    exportOptions: {
                                        columns: ':not(:eq(2))' // Loại bỏ cột thứ 2
                                    }
                                },
                                {
                                    extend: 'excelHtml5',
                                    exportOptions: {
                                        columns: ':not(:eq(2))' // Loại bỏ cột thứ 2
                                    }
                                },
                                {
                                    extend: 'csvHtml5',
                                    exportOptions: {
                                        columns: ':not(:eq(2))' // Loại bỏ cột thứ 2
                                    }
                                },
                                {
                                    extend: 'pdfHtml5',
                                    exportOptions: {
                                        columns: ':not(:eq(2))' // Loại bỏ cột thứ 2
                                    }
                                }
                            ]
                        }
                    ],
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

                $('.input-number').on('input', function() {
                    let value = $(this).val();
                    value = value.replace(/\D/g, '');
                    value = value.replace(/^0+/, '');
                    $(this).val(value);
                });

                table.on('requestChild.dt', function (e, row) {
                    row.child(format(row.data())).show();
                });

                table.on('click', 'td.dt-control', function (e) {
                    let tr = e.target.closest('tr');
                    let row = table.row(tr);

                    if (row.child.isShown()) {
                        // This row is already open - close it
                        row.child.hide();
                    }
                    else {
                        // Open this row
                        row.child(formatDetailRow(row.data())).show();
                    }
                });
            });

    $(".nav-link").removeClass("active");
    $("#thong-ke-nav-link").addClass("active");
</script>

</html>