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
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
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
            margin-left: 16px;
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

        .custom-select, .search {
            width: auto !important;
            display: inline-block !important;
        }

        .ui-autocomplete {
            z-index: 9999999 !important;
            max-height: 200px;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .ui-autocomplete li {
            padding: 5px;
            cursor: pointer;
        }

        .dt-center {
            text-align: center !important;
        }

        .highlight {
            background: var(--primary-green) !important;
            color: white;
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
                            <div class="mb-3">
                                <div class="table-control d-flex align-items-center">
                                    <button id="btnImport" class="btn btn-secondary"
                                            data-toggle="modal" data-target="#importModal">Thêm sản phẩm
                                    </button>
                                    <button class="btn btn-secondary btn-control">Nhập từ File</button>
                                </div>
                            </div>
                            <table id="datatable-products" class="cell-border hover nowrap w-100">
                                <thead>
                                <tr>
                                    <th class="text-center">Mã sản phẩm</th>
                                    <th style="min-width: 10vw">Tên sản phẩm</th>
                                    <th class="text-right">Trọng lượng</th>
                                    <th class="text-right">Giá nhập</th>
                                    <th class="text-right">Số lượng nhập</th>
                                    <th class="text-center">Ngày nhập</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="importModal" tabindex="-1" role="dialog"
                 aria-labelledby="importModalCenterTitle"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <form autocomplete="off" id="formImport">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="filterModalLongTitle">Nhập kho sản phẩm</h5>
                                <i data-dismiss="modal" class="close fa-solid fa-xmark"></i>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <div class="form-group row align-items-center ui-widget">
                                        <label class="col-4">Mã sản phẩm</label>
                                        <div class="col-8">
                                            <input class="form-control input-number" id="productIdInput" type="text"
                                                   inputmode="numeric" pattern="[0-9]*"
                                                   placeholder="Để trống nếu tạo mới">
                                        </div>
                                    </div>

                                    <div class="form-group row align-items-center">
                                        <label class="col-4">Tên sản phẩm</label>
                                        <div class="col-8">
                                            <input class="form-control" id="productNameInput" type="text"
                                                   required>
                                        </div>
                                    </div>

                                    <div class="form-group row align-items-center">
                                        <div class="col">
                                            <label class="mb-2" for="productCostPriceInput">Giá nhập</label>
                                            <div class="input-group">
                                                <input class="form-control input-price" id="productCostPriceInput"
                                                       type="text" inputmode="numeric" pattern="[0-9,\.]*" required>

                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">đ</div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col">
                                            <label class="mb-2" for="productWeightInput">Trọng lượng</label>
                                            <div class="input-group">
                                                <input class="form-control input-weight" id="productWeightInput"
                                                       type="text" inputmode="numeric" pattern="[0-9,.]*" required>

                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">kg</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group row align-items-center">
                                        <div class="col">
                                            <label class="mb-2" for="productImportQuantityInput">Số lượng nhập</label>
                                            <input class="form-control input-price" id="productImportQuantityInput"
                                                   type="text" inputmode="numeric" pattern="[0-9,\.]*" required>
                                        </div>

                                        <div class="col">
                                            <label class="mb-2" for="productUnitInStock">Tồn kho</label>
                                            <input class="form-control input-number" id="productUnitInStock"
                                                   type="text" inputmode="numeric" pattern="[0-9]*" required disabled>
                                        </div>
                                    </div>

                                    <div class="form-group row align-items-center">
                                        <label class="col" for="productDateImportInput">Ngày nhập</label>
                                        <div class="col">
                                            <input class="form-control" id="productDateImportInput"
                                                   type="date" required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                <button id="btnAdd" class="btn btn-success" type="submit">Thêm</button>
                            </div>
                        </div>
                    </form>
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
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
<script type="text/javascript">
    function formatNumber(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(amount);
    }

    $(document)
        .ready(
            function () {
                var productIdInput = $('#productIdInput');

                productIdInput.autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: "nhap-kho",
                            type: 'POST',
                            data: {
                                action: 'search',
                                request: 'find-id-list',
                                id: request.term
                            },
                            success: function (resp) {
                                var data = resp.data;
                                if(data != null) {
                                    response(data.map(num => String(num)));
                                }
                            }
                        });
                    },
                    minLength: 1,
                    select: function (event, ui) {
                        $(this).val(ui.item.value);
                        $(this).blur();
                        return false;
                    }
                });

                productIdInput.change(function (change) {
                    var id = $(this).val();
                    if(id !== '') {
                        $.ajax({
                            url: 'nhap-kho',
                            type: 'POST',
                            data: {
                                action: 'search',
                                request: 'find-product',
                                id: id
                            },
                            success: function (resp) {
                                var product = resp.data;

                                if (product !== null) {
                                    $('#productNameInput').val(product.name);
                                    $('#productCostPriceInput').val(product.costPrice);
                                    $('#productWeightInput').val(formatNumber(product.weight));
                                    $('#productUnitInStock').val(formatNumber(product.unitsInStock));

                                    $('#productCostPriceInput').trigger('input');
                                    $('#productWeightInput').trigger('input');
                                }
                                else {
                                    $('#formImport')[0].reset();
                                }
                            }
                        });
                    } else {
                        $('#formImport')[0].reset();
                    }
                });

                let controlBar = document.createElement('div');

                controlBar.innerHTML = `
                            <div class="align-items-center">
                            <label>Tìm kiếm sản phẩm</label>
                            <input style="padding-left: 5px; margin-left: 10px" id="search" class="search form-control" type="search" name="name" placeholder="Tìm kiếm...">
                            </div>
                            `;

                let btnSave = document.createElement('div');
                btnSave.innerHTML = '<button id="btnSave" class="btn btn-success my-2">Nhập kho' + '</button>';

                let table = $('#datatable-products').DataTable({
                    pageLength: 25,
                    scrollX: true,
                    scrollCollapse: true,
                    scrollY: '55vh',
                    order: [],
                    columnDefs: [
                        {targets: 0, name: 'id'},
                        {targets: 1, name: 'name'},
                        {targets: 2, name: 'weight'},
                        {targets: 3, name: 'costPrice'},
                        {targets: 4, name: 'quantity'},
                        {targets: 5, name: 'dateCreated'},
                        {
                            targets: [2, 3, 4],
                            className: 'dt-right'
                        },
                        {
                            targets: [0, 5],
                            className: 'dt-center'
                        },
                    ],
                    columns: [
                        {
                            data: 'id',
                            render: function (data, type, row) {
                                if (data == -1) {
                                    return 'Mới';
                                }
                                return data;
                            }
                        },
                        {
                            data: 'name',
                            render: function (data, type, row) {
                                return '<span class="product-name">' + data + '</span>';
                            }
                        },
                        {
                            data: 'weight',
                            render: function (data, type, row) {
                                return data + ' kg';
                            }
                        },
                        {
                            data: 'costPrice',
                            render: function (data, type, row) {
                                return formatCurrency(data)
                            }
                        },
                        { data: 'quantity' },
                        { data: 'dateCreated' }
                    ],
                    layout: {
                        topStart: controlBar,
                        topEnd: 'pageLength',
                        bottomStart: null,
                        bottomEnd: btnSave,
                        bottom2Start: 'info',
                        bottom2End: 'paging'
                    },
                    language: {
                        "sProcessing": "Đang xử lý...",
                        "sLengthMenu": "Hiển thị _MENU_ mục",
                        "sZeroRecords": "Không tìm thấy dữ liệu",
                        "sInfo": "Hiển thị _START_ đến _END_ của _TOTAL_ mục",
                        "sInfoEmpty": "Hiển thị 0 đến 0 của 0 mục",
                        "sInfoFiltered": "(được lọc từ _MAX_ mục)",
                        "emptyTable": "Vui lòng thêm dữ liệu",
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

                $('.input-price').on('input', function () {
                    let value = $(this).val();
                    value = value.replace(/\D/g, '');

                    if (value == "") {
                        $(this).val(value);
                        return;
                    }

                    $(this).val(parseInt(value).toLocaleString("vi-VN"));
                });

                $('.input-weight').on('input', function () {
                    let value = $(this).val();

                    value = value.replace(/[^0-9.]/g, '');

                    let decimalParts = value.split('.');
                    if (decimalParts.length > 2) {
                        value = decimalParts[0] + '.' + decimalParts.slice(1).join('');
                    }

                    let integerPart = decimalParts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                    let formattedValue = integerPart;

                    if (decimalParts.length > 1) {
                        formattedValue += '.' + decimalParts[1];
                    }

                    $(this).val(formattedValue);
                });

                $('#formImport').submit(function (e) {
                    e.preventDefault();

                    let id = $('#productIdInput').val();
                    if(id === '') id = -1;

                    let name = $('#productNameInput').val();
                    let weight = $('#productWeightInput').val();
                    let costPrice = $('#productCostPriceInput').val().replace(/\D/g, '');
                    let quantity = $('#productImportQuantityInput').val().replace(/\D/g, '');
                    let dateCreate = $('#productDateImportInput').val();

                    let product = {
                        id: id,
                        name: name,
                        weight: weight,
                        costPrice: costPrice,
                        quantity: quantity,
                        dateCreated: dateCreate
                    };

                    var rowNode = table.row.add(product).draw()
                        .node();

                    $(rowNode).addClass('highlight');

                    setTimeout(function() {
                        $(rowNode).removeClass('highlight');
                    }, 2000);

                    $('#formImport .close').click();
                    $('#formImport')[0].reset();
                });

                $(document).on('click', '#btnSave', function () {
                    var data = table.rows().data().toArray();

                    $.ajax({
                        url: "nhap-kho",
                        type: 'POST',
                        data: {
                            action: 'import',
                            data: JSON.stringify(data)
                        },
                        success: function (resp) {

                        }
                    });
                });
            });

    $(".nav-link").removeClass("active");
    $("#nhap-kho-nav-link").addClass("active");
</script>
</html>