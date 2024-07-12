<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section class="section_coupon container mt-3">
    <div class="coupon-slider">
        <%--        <div class="card-deck d-flex mr-child-20">--%>
        <c:forEach items="${discounts}" var="item">
                <div class="card card-coupon ">
                    <a class="btn-info">i</a>
                    <div class="card-title font-weight">
                        <strong>${item.code}</strong>
                        <div class="coupon-info">
                            <span class="">${item.description}</span>
                        </div>
                    </div>
                    <div class="coupon-footer">
                        <span class="small-text text-light-color">HSD:
                                ${item.expDate}</span>
                        <div class="coupon-copy" data-target="${item.code}">Sao chép</div>
                    </div>
                </div>
        </c:forEach>
        <%--        </div>--%>
    </div>
</section>
<script type="text/javascript">
    $(document).ready(function () {
        $('.coupon-slider').slick({
            infinite: true,
            slidesToShow: 4,
            slidesToScroll: 3
        });


        $(".coupon-footer .coupon-copy").click(function () {
            let copyBtn = $(this);

            $(".coupon-footer .coupon-copy").not(copyBtn).text('Sao chép').removeClass('copied');

            let code = copyBtn.data("target");

            navigator.clipboard.writeText(code).then(() => {
                Swal.fire({
                    title: "Chúc mừng",
                    text: "Bạn đã lưu mã giảm giá " + code + " thành công",
                    icon: "success",
                    timer: 800,
                    showConfirmButton: false
                });

                copyBtn.text('Đã lưu').addClass('copied');
            }).catch(err => {
                Swal.fire({
                    title: "Lỗi",
                    text: "Không thể sao chép mã giảm giá. Vui lòng thử lại.",
                    icon: "error",
                    timer: 800,
                    showConfirmButton: false
                });
            });
        });

    });
</script>
