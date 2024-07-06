package Database;

import Controller.cart.Cart;
import Model.CartItem;

import java.util.List;

public interface ICartItemDAO extends GenericDAO<CartItem> {
    List<CartItem> findByUserId(int userId);
}