package Controller.cart;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import Database.IProductDAO;
import Database.ProductDAO;
import Model.CartItem;
import Model.Product;
import Services.IProductService;

public class Cart {

    IProductDAO productService;
	
	private HashMap<Integer, CartItem> cart;

	public Cart() {
		productService = new ProductDAO();
		cart = new HashMap<Integer, CartItem>();
	}

	public boolean add(int id) {
		return add(id, 1);
	}

	public boolean add(int id, int quantity) {
		Product product = productService.findProductById(id);
		if (product == null)
			return false;
		CartItem cartItem = cart.getOrDefault(id, new CartItem(product, 0));
		cartItem.increase(quantity);

		cart.put(id, cartItem);

		return true;
	}

	public boolean update(int id, int quantity) {
		Product product = productService.findProductById(id);

		if (product == null)
			return false;

		CartItem cartItem = cart.get(id);
		cartItem.setQuantity(quantity);

		if (cartItem.getQuantity() <= 0) {
			cart.remove(id);
		} else
			cart.put(id, cartItem);

		return true;
	}

	public int getTotalItems() {
		return cart.values().stream().mapToInt(CartItem::getQuantity).sum();
	}

	public double getTotalPrice() {
		return cart.values().stream().mapToDouble(CartItem::calculatePrice).sum();
	}

	public List<CartItem> getCartItems() {
		return cart.values().stream().collect(Collectors.toList());
	}

	public CartItem getItem(int id) {
		return cart.get(id);
	}
}
