<%@page import="Model.ProductSale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Formatter"%>
<%@page import="java.util.logging.SimpleFormatter"%>
<%@page import="Model.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="styles/bootstrap.css?d">
<link rel="stylesheet" type="text/css" href="styles/base.css?d">
<link rel="stylesheet" type="text/css" href="styles/main.css?d">
<link rel="stylesheet" type="text/css" href="styles/lightslider.css">
<link rel="stylesheet" type="text/css"
	href="styles/san-pham-khuyen-mai.css?">
<link rel="stylesheet" type="text/css" href="styles/aside.css?ấda">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<title>Sản phẩm</title>
<style type="text/css">
#pagination ul {
	display: flex;
	list-style: none;
	padding: 0;
	justify-content: center;
}

#pagination li {
	margin: 4px;
	text-align: center;
	cursor: pointer;
	box-sizing: border-box;
}

#pagination li a {
	display: block;
	padding: 6px 14px;
	text-decoration: none;
	background-color: #fff;
	color: #000;
	border: 1px solid #000;
	border-radius: 8px;
	transition: all .4s ease;
}

#pagination li.active a, #pagination li:hover a {
	background-color: var(--primary-green);
	color: #fff;
	border: 1px solid var(--primary-green);
}
</style>
</head>
<body>
	<jsp:include page="Components/header.jsp" />
	<jsp:include page="top-title.jsp">
		<jsp:param name="title" value="Sản phẩm" />
	</jsp:include>
	<div id="wrapper"></div>
	<div class="container mt-3">
		<div class="row gx-4">
			<div class="col-md-12">
				<jsp:include page="Components/voucher-component.jsp"></jsp:include>
				<div class="row">
					<aside class="col-md-3 mb-child-20">
						<jsp:include page="Components/left-categories-list.jsp"></jsp:include>
						<input type="hidden" id="categoryId" value=${category}>
						<div class="title-head-large text-primary-green dash-border">Bộ
							lọc sản phẩm</div>
						<!-- Giá -->
						<div class="aside-content bg-light-green">
							<div class="title-head text-primary-green my-2">Chọn mức
								giá</div>
							<div class="input-group flex-column price-filter">
								<label for="min-price">Tối thiểu</label> <input
									class="input-box" type="number" min="1" name="min-price" id="min-price"
									value="${minPrice != 0? minPrice : ''}"
									placeholder="Nhập số tiền tối thiểu"> <label
									for="max-price">Tối đa</label> <input class="input-box" min="1"
									type="number" name="max-price" id="max-price"
									value="${maxPrice != 0? maxPrice : ''}"
									placeholder="Nhập số tiền tối đa">
								<button class="btn btn-green my-2" style="border-radius: 8px;"
									type="button" id="price_filter">Áp dụng</button>
							</div>
					</aside>
					<div class="col-md-9 filter-2">
						<nav class="nav-filter d-flex align-items-center mb-4">
							<div>
								<i class="fa-sharp fa-solid fa-arrow-down-a-z"
									style="color: #000000;"></i> Sắp xếp theo:
							</div>
							<ul class="order-group">
								<li><a class="border-green order"
									data-order-type="name-asc">Tên A-Z</a></li>
								<li><a class="border-green order"
									data-order-type="name-desc">Tên Z-A</a></li>
								<li><a class="border-green order"
									data-order-type="price-asc">Giá thấp đến cao</a></li>
								<li><a class="border-green order"
									data-order-type="price-desc">Giá cao xuống thấp</a></li>
							</ul>
						</nav>
						<div class="products-view-grid">
							<div class="row mb-child-20 product-container"></div>
						</div>
						<div id="pagination"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</section>
	<footer>
		<jsp:include page="Components/footer.jsp" />
	</footer>
</body>
<script type="text/javascript" src="javascripts/jquery-3.7.1.js"></script>
<script type="text/javascript" src="javascripts/lightslider.js"></script>
<script type="text/javascript" src="javascripts/main.js?abc"></script>
<script type="text/javascript" src="javascripts/shopping-cart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript" src="javascripts/lightslider.js"></script>
<script type="text/javascript" src="javascripts/pagination.js"></script>
<script type="text/javascript">

function renderProducts(items, favoritedIds) {
    $.get('/Do_An_Thuc_Tap_Web_Thay_Long/templates/product-template.jsp', function (template) {
        var $productContainer = $('.product-container');
        $productContainer.empty();

        $.each(items, function (index, item) {
            var $product = $(template);

            $product.attr('data-product-id', item.id);
            $product.find('.product_thumb').attr('src', item.thumb);
            $product.find('.product_name').text(item.name);
            $product.find('.heartIcon').toggleClass('favorited', favoritedIds.includes(item.id));
            
            if (item.sale != null) {
                $product.find('.product_sale').text('Giảm ' + item.sale).show();
                $product.find('.product_new_price').text(formatPrice(item.newPrice));
                $product.find('.product_unit_price').text(formatPrice(item.unitPrice));
            } else {
                $product.find('.product_new_price').text(formatPrice(item.unitPrice));
            }

            var $col = $('<div class="col-6 col-md-4 col-xl-3">');
            $col.append($product);
            $productContainer.append($col);
        });
    }, "html");
}

function formatPrice(price) {
	return new Intl.NumberFormat('vi-VN', {
		style: 'currency',
		currency: 'VND'
	}).format(price);
};
	$(document).ready(function() {
		$('#sale-filter').prop('checked', ${isSale});
	    $('#ship-filter').prop('checked', ${isFreeShip});
		 $('#min-price, #max-price').on('input', function () {
	            var value = $(this).val();
	            if (value.trim() !== '' && !isNaN(value)) {
	                $(this).val(parseInt(value, 10));
	            }
	        });
		var filters = {
			    minPrice: $('#min-price').val(),
			    maxPrice: $('#max-price').val(),
			    category: $("#categoryId").val(),
			    isSale: $('#sale-filter').is(":checked"),
		        isFreeShip: $('#ship-filter').is(":checked")
		};
		$('.order-group a[data-order-type="' + '${order}' + '-' + '${sort}' + '"]').addClass('selected-order');
		function getOrder() {
		    var selectedOrderElement = $('.order.selected-order');
		    
		    if (selectedOrderElement.length > 0) {
		        var orderType = selectedOrderElement.data('order-type');
		        var [orderValue, sortValue] = orderType.split('-');
		        
		        return {
		            order: orderValue,
		            sort: sortValue
		        };
		    } else {
		        return {
		            order: 'id',
		            sort: 'asc'
		        };
		    }
		}
		$('.order').on('click', function(e) {
		    e.preventDefault();
		    if ($(this).hasClass('selected-order')) {
		        $(this).removeClass('selected-order');
		    } else {
		        $('.order').removeClass('selected-order');
		        $(this).addClass('selected-order');
		    }
		    applyFilters();
		});
		var order = {
			order: '${order}',
			sort:  '${sort}'
		};
		function updateOrder(orderType) {
            var orderField, sortDirection;
            if (orderType === 'name-asc') {
                orderField = 'name';
                sortDirection = 'asc';
            } else if (orderType === 'name-desc') {
                orderField = 'name';
                sortDirection = 'desc';
            } else if (orderType === 'price-asc') {
                orderField = 'price';
                sortDirection = 'asc';
            } else if (orderType === 'price-desc') {
                orderField = 'price';
                sortDirection = 'desc';
            }
            order.order = orderField;
            order.sort = sortDirection;
		};
		
		$('.order').on('click', function(e) {
            e.preventDefault();
            var orderType = $(this).data('order-type');
            updateOrder(orderType);
            $('.order').removeClass('selected-order');
            $(this).addClass('selected-order');
            applyFilters();
        });
		$(".aside-content .nav-item").click(function(){
		    let categoryId = $(this).data("category");
		    $("#categoryId").val(categoryId);
		    $(".nav-item").removeClass("high-light");
		    $(this).addClass("high-light");
		    applyFilters();
		})
		
		function createPagination(page, action) {
			var isCreate = true;
			var order = getOrder();
			var name = $('#searchInput').val();
			$('#pagination').pagination({
				dataSource: function(done){
					var result = [];
					$.ajax({
						url: '/Do_An_Thuc_Tap_Web_Thay_Long/san-pham',
			    	    type: 'POST',
			    	    data: {
			    	    	action: action,
			    	    	need: 'count',
			    	   		category:'${category}',
			    	    	name,
			    	        ...filters
			    	    },
			    	    dataType: 'json',
			    	    success: function (response) {
						    for(var i = 1; i <= response.count; i++){
						        result.push(i);
						    }
						    done(result);
			    	    }
					});
				},
			    pageSize: 16,
			    pageNumber: page,
			    autoHidePrevious: true,
			    autoHideNext: true,
			    ajax: {
			        beforeSend: function() {
			            dataContainer.html('Loading data from Luong thuc Viet ...');
			        }
			    },
			    callback: function (data, pagination) {
			    	$.ajax({
			    	    url: '/Do_An_Thuc_Tap_Web_Thay_Long/san-pham',
			    	    type: 'POST',
			    	    data: {
			    	    	action: isCreate? action : null,
			    	    	page: pagination.pageNumber,
			    			category:'${category}',
			    	    	name,
			    	    	...order,
			    	        ...filters
			    	    },
			    	    dataType: 'json',
			    	    success: function(response) {
			    	    	var newUrl = '/Do_An_Thuc_Tap_Web_Thay_Long/san-pham?action=' + action + '&page=' +
			    	    	  pagination.pageNumber;
			    	    	
			    	    	if(name !== null && name != undefined && name.trim() !== '') {
			    	    		newUrl += '&name=' + encodeURIComponent(name);
			    	    	}
			    	    	
			    	    	for (var key in filters) {
			    	    	  if (filters[key] !== null && filters[key] !== undefined &&
			    	    	    filters[key] !== false) {
			    	    	    if (typeof filters[key] === 'string') {
			    	    	      filters[key] = filters[key].trim();
			    	    	    }

			    	    	    if (filters[key] !== '' && filters[key] != 0) {
			    	    	      newUrl += '&' + key + '=' + encodeURIComponent(filters[key]);
			    	    	    }
			    	    	  }
			    	    	}
			    	    	for (var key in order) {
				    	    	  if (order[key] !== null && order[key] !== undefined &&
				    	    			  order[key] !== false) {

				    	    	    if (typeof order[key] === 'string') {
				    	    	    	order[key] = order[key].trim();
				    	    	    }

				    	    	    if (order[key] !== '' && order[key] != 0 && order.order !== 'id') {
				    	    	      newUrl += '&' + key + '=' + encodeURIComponent(order[key]);
				    	    	    }
				    	    	  }
				    	    	}
			    	    	
			    	    	window.history.pushState({}, '', newUrl);
					    	setTimeout(function() {
			    	        	window.scrollTo(0, $('.section_coupon').offset().top);
			    	        	renderProducts(response.productList, response.wishlist);
			                }, 300);
			    	    },
			    	    error: function(error) {
			    	        console.error(error);
			    	    }
			    	});
			    	isCreate = false;
			    }
			});
		}
		
		$('#sale-filter, #ship-filter').on('change', function() {
			  applyFilters();
			});

		function applyFilters() {
		    filters.minPrice = $('#min-price').val();
		    filters.maxPrice = $('#max-price').val();
		    filters.category = $('#categoryId').val();
		    filters.isSale = $('#sale-filter').is(":checked");
		    filters.isFreeShip = $('#ship-filter').is(":checked");
		    Object.keys(filters).forEach(key => {
		        if (typeof filters[key] === 'string') {
		            filters[key] = filters[key].trim();
		        }
		    });

		    if (Object.values(filters).some(value => {
		        if (typeof value === 'number') {
		            return value !== null && value !== undefined && value !== 0;
		        } else {
		            return value !== null && value !== undefined && value !== '';
		        }
		    })) {
		        $('#pagination').pagination('destroy');
		        createPagination(1, 'filter');
		    }
		    console.log(filters);
		    
		}
		$('#price_filter').on('click', function() {
		    applyFilters();
		});
 		createPagination(${page}, '${action}');
	});
</script>

</html>