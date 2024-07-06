package Database;

import Model.CartItem;

import java.util.List;

public interface ICartDAO extends GenericDAO<CartItem> {
    List<CartItem> findAll();
}
