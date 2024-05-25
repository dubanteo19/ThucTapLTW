<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 5/26/2024
  Time: 1:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    .adress-form-content form input, select {
        width: 100%!important;
    }
</style>
<body>
<div class="row adress-form wrapper">
    <div class="col-md-8 mb-4">
        <div class="card mb-4">
            <div class="adress-form">
                <div class="adress-form-content">
                    <h2>
                        Địa chỉ nhận hàng <span id="adress-close">X Đóng</span>
                    </h2>
                    <form action="UserInfo" method="post" id="address-form">
                        <input type="hidden" name="pos" id="pos" value=""> <input
                            type="hidden" name="action" value="addAddress"> <input
                            type="hidden" name="menu" value="address_your">
                        <p>Chọn đầy đủ địa chỉ nhận hàng để biết chính xác thời
                            gian giao</p>
                        <div class=" col-lg-12 col-sm-12 col-xs-12">
                            <fieldset class="form-group" style="margin: 0">
                                <input type="text" class="form-input select-field"
                                       value="" name="fullName" id="fullName"
                                       placeholder="Họ tên" required="">
                            </fieldset>
                        </div>
                        <div class=" col-lg-12 col-sm-12 col-xs-12">
                            <fieldset class="form-group">
                                <input placeholder="Số điện thoại" type="text"
                                       pattern="\d+" class="form-input form-control-comment"
                                       name="PhoneNumber" required="" id="PhoneNumber">
                            </fieldset>
                        </div>
                        <div
                                class="group-country col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <fieldset
                                    class="form-group select-field select-field-provinces">
                                <select name="Province" value=""
                                        class="form-control add provinces" id="provinces"
                                        onchange="getDistricts()"></select>
                            </fieldset>
                            <fieldset class="form-group select-field">
                                <select name="District" class="form-control add districts"
                                        value="" id="districts" onchange="getWards()">
                                    <option value="" hidden="">Quận huyện</option>
                                </select>
                            </fieldset>
                            <fieldset class="form-group select-field">
                                <select name="Ward" class="form-control add wards"
                                        value="" id="wards">
                                    <option value="" hidden="">Phường xã</option>
                                </select>
                            </fieldset>
                        </div>
                        <div class=" col-lg-12 col-sm-12 col-xs-12">
                            <fieldset class="form-group">
                                <input class="description" type="text" name="Description"
                                       placeholder="Số nhà tên đường (không bắt buộc)"
                                       style="margin: 0">
                            </fieldset>
                        </div>
                        <div class="d-flex">
                            <div class="form-check">
                                <input class="" type="checkbox" value=1 name="default"> <label class="" for=""> Địa chỉ
                                mặc định </label>

                            </div>
                            <button class="btn-hover">Xác nhận</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
