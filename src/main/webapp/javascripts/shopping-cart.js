$(document).on('click', '.add_cart', function() {
	var id = $(this).closest('.product').data('product-id');
	addToCart(id);
	console.log("add to cart");
	Swal.fire({
		title: "Chúc mừng",
		text: "Bạn đã thêm vào giỏ hàng thành công",
		showConfirmButton: false,
		icon: "success",
		timer: 800
	});
});
$(document).on('click', '.search_detail', function() {
		var id = $(this).closest('.product').data('product-id');
	console.log("click");
	location.href = "ProductDetail?productId="+id;
});


$(document).on('click', '.cart-item .cart_increase', function() {
	var cartItem = $(this).closest('.cart-item');
	var quantity = parseInt(cartItem.find('.cart_quantity').val(), 10);
	updateCartItem(cartItem.data('cart-id'), quantity + 1);
});

$(document).on('click', '.cart-item .cart_decrease', function() {
	var cartItem = $(this).closest('.cart-item');
	var quantity = parseInt(cartItem.find('.cart_quantity').val(), 10);
	updateCartItem(cartItem.data('cart-id'), quantity - 1);
});

$(document).on('click', '.cart-item .cart_delete span', function() {
	var cartItem = $(this).closest('.cart-item');
	updateCartItem(cartItem.data('cart-id'), 0);
});

$(document).on({
	focus: function() {
		$(this).data('default-value', $(this).val());
	},
	change: function() {
		var inputQuantity = $(this);
		var quantity = parseInt(inputQuantity.val(), 10);

		if (!isNaN(quantity) && quantity >= 0) {
			updateCartItem(inputQuantity.closest('.cart-item').data('cart-id'), quantity);
		} else {
			inputQuantity.val(inputQuantity.data('default-value'));
		}
	}
}, '.input-quantity.cart_quantity');

function updateCartItem(idProduct, quantity) {
	$.ajax({
		type: "POST",
		url: "/Do_An_Thuc_Tap_Web_Thay_Long/CartController",
		dataTpe: "json",
		data: {
			action: "UPDATE",
			idProduct: idProduct,
			quantity: quantity
		},
		success: function(response) {
			var totalItems = response.totalItems;

			if (totalItems > 0) {
				$('#btn-card .badge').text(totalItems);
			}
			else {
				$('#btn-card .badge').text('');
			}

			$('.cart_total_price').text(formatPrice(response.totalPrice));

			var item = response.item;
			var itemDisplay = $('[data-cart-id="' + idProduct + '"]');

			if (item === null || item === undefined) {
				itemDisplay.remove();
			}
			else {
				itemDisplay.find('.cart_quantity').val(item.quantity);
				itemDisplay.find('.cart_price').text(formatPrice(response.itemTotalPrice));
			}
		},
		error: function(error) {
			console.log(error);
		}
	});
}

function addToCart(idProduct) {
	$.ajax({
		type: "POST",
		url: "/Do_An_Thuc_Tap_Web_Thay_Long/CartController",
		dataTpe: "json",
		data: {
			action: "ADD",
			idProduct: idProduct
		},
		success: function(response) {
			$('#btn-card .badge').text(response.totalItems);
			$('.cart_total_price').text(formatPrice(response.totalPrice));

			var item = response.item;

			var itemDisplay = $('[data-cart-id="' + idProduct + '"]');

			if (itemDisplay.length === 0) {
				renderCartItem(item, response.itemTotalPrice);
			}
			else {
				itemDisplay.find('.cart_quantity').val(item.quantity);
				itemDisplay.find('.cart_price').text(formatPrice(response.itemTotalPrice));
			}
		},
		error: function(error) {
			console.log(error);
		}
	});
}

function addToCart(idProduct, quanlity) {
	$.ajax({
		type: "POST",
		url: "/Do_An_Thuc_Tap_Web_Thay_Long/CartController",
		dataTpe: "json",
		data: {
			action: "ADD",
			idProduct: idProduct,
			"quanlity": quanlity,
		},
		success: function(response) {
			$('#btn-card .badge').text(response.totalItems);
			$('.cart_total_price').text(formatPrice(response.totalPrice));

			var item = response.item;

			var itemDisplay = $('[data-cart-id="' + idProduct + '"]');

			if (itemDisplay.length === 0) {
				renderCartItem(item, response.itemTotalPrice);
			}
			else {
				itemDisplay.find('.cart_quantity').val(item.quantity);
				itemDisplay.find('.cart_price').text(formatPrice(response.itemTotalPrice));
			}
		},
		error: function(error) {
			console.log(error);
		}
	});
}

function renderCartItem(item, itemTotalPrice) {
	$.get('/Do_An_Thuc_Tap_Web_Thay_Long/templates/cart-item-template.jsp', function(template) {
		var $cartItem = $(template);

		$cartItem.attr('data-cart-id', item.product.id);
		$cartItem.find('.cart_img').attr('src', item.product.thumb);
		$cartItem.find('.cart_title').text(item.product.name);
		$cartItem.find('.cart_quantity').val(1);
		$cartItem.find('.cart_price').text(formatPrice(itemTotalPrice));

		$('.cart-container').append($cartItem);
	}, "html");
}

function formatPrice(price) {
	return new Intl.NumberFormat('vi-VN', {
		style: 'currency',
		currency: 'VND'
	}).format(price);
};