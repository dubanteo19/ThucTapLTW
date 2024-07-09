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
          href='../styles/bootstrap.css'>
    <link rel="stylesheet" type="text/css" href="../styles/base.css">
    <link rel="stylesheet" type="text/css" href="../styles/main.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="styles/admin.css?aa">
</head>
<style>
    .btn-order-detail i {
        color: #fFffff;
    }

    .level {
        margin: 10px !important;
        padding: 20px !important;
    }

    .info {
        background-color: #3dd5f3 !important;
        padding: 10px !important;
        border-radius: 5px !important;
    }

    .danger {
        background-color: red;
        padding: 10px !important;
        border-radius: 5px !important;
    }

    .warning {
        background-color: orange;
        padding: 10px !important;
        border-radius: 5px !important;
    }

    .alertz {
        background-color: yellow;
        padding: 10px !important;
        border-radius: 5px !important;
    }
</style>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="row">
    <jsp:include page="left-menu.jsp"></jsp:include>
    <div class="col-10 pt-3 ">
        <div
                class="container title d-flex justify-content-between bg-white rounded">
            <h5>Hệ thống</h5>
            <span class="date">Thứ 2, ngày 30/10/2023 - 11 giờ 25 phút</span>
        </div>
        <div class="container-fluid ">
            <div class="row w-100">
                <div class="col-12">
                    <div class="list-orders mt-3 bg-white">
                        <div class="sub-title">
                            <h4>Bảng ghi log</h4>
                        </div>
                        <table class="table" id="orders">
                            <thead>
                            <tr>
                                <th scope="col">ID Log</th>
                                <th scope="col">Địa chỉ IP</th>
                                <th scope="col">Quốc gia</th>
                                <th scope="col">URL</th>
                                <th scope="col">LEVEL</th>
                                <th scope="col">Giá trị trước</th>
                                <th scope="col">Giá trị sau</th>
                                <th scope="col">Thời gian</th>
                                <th scope="col">Chức năng</th>
                            </tr>
                            </thead>
                            <c:forEach items="${logs}" var="item">
                                <c:set var="level">
                                    <c:choose>
                                        <c:when test="${item.level == 'INFO'}">info</c:when>
                                        <c:when test="${item.level == 'ALERT'}">alertz</c:when>
                                        <c:when test="${item.level == 'WARNING'}">warning</c:when>
                                        <c:when test="${item.level == 'DANGER'}">danger</c:when>
                                    </c:choose>
                                </c:set>

                                <tbody id="${item.id}">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.ipAddress}</td>
                                    <td>${item.nation}</td>
                                    <td>${item.url}</td>
                                    <td class="level">
                                        <span class="${level}">${item.level}</span>
                                    </td>
                                    <td>${item.currentValue}</td>
                                    <td>${item.afterValue}</td>
                                    <td>${item.dateCreated}</td>
                                    <td>
                                        <div class="btn-group">
                                            <button class="btn btn-success btn-sm detail-btn me-1"
                                                    type="button"
                                                    data-toggle="modal"
                                                    data-target="#log-detail-modal-lg"
                                                    data-logId=${item.id}>
                                                <i class="fa-solid fa-circle-info"></i>
                                            </button>
                                            <button
                                                    type="button"
                                                    data-toggle="modal"
                                                    data-target="#log-detail-modal-lg"
                                                    class="btn btn-warning btn-sm remove-btn"
                                                    data-logId=${item.id}>
                                                <i class='fa-solid fa-trash'></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade " id="log-detail-modal-lg" tabindex="-1" role="dialog" aria-labelledby="logDetailModal"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="container p-3">
                <h3 class="text-center">Chi tiết log </h3>
                <span>Địa chỉ IP: <span id="modal-ipAddress"></span> </span>
            </div>
        </div>
    </div>
</div>

</body>
<script src="../javascripts/jquery-3.7.1.js"></script>
<script src="../javascripts/bootstrap.min.js"></script>
<script type="text/javascript" src="javascripts/Utils.js"></script>
<script type="text/javascript">
    $(".nav-link").removeClass("active");
    $("#logs-nav-link").addClass("active");
    $(".remove-btn").click(function () {
        let logId = $(this).data("target");
        removeLog(logId);
    })

    function removeLog(logId) {
        $.ajax({
            type: "post",
            url: "/admin/LogController",
            data: {
                logId: logId,
                action: "remove"
            },
            success: function (response) {
            },
            error: function (xhr, status, error) {
                console.log("loi")
            }
        });
    }
</script>

</html>
