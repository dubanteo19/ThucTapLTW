package Controller.cart;

import Database.IProductDAO;
import Database.ProductDAO;
import Model.CartItem;
import Model.Product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Cart {

    IProductDAO productDAO = new ProductDAO();

    private Map<Integer, CartItem> cart;

    public Cart() {
        cart = new HashMap<Integer, CartItem>();
    }

    public Cart(Map<Integer, CartItem> cart) {
        this.cart = cart;
    }

    public boolean add(int id) {
        return add(id, 1);
    }

    public boolean add(int id, int quantity) {
        Product product = productDAO.findProductById(id);
        if (product == null)
            return false;
        CartItem cartItem = cart.getOrDefault(id, new CartItem(product, 0));
        cartItem.increase(quantity);

        cart.put(id, cartItem);

        return true;
    }

    public boolean update(int id, int quantity) {
        Product product = productDAO.findProductById(id);

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
        return cart.size();
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

    public void setCart(Map<Integer, CartItem> cart) {
        this.cart = cart;
    }

    public void addAll(Map<Integer, CartItem> cart) {
        this.cart.putAll(cart);
    }
}