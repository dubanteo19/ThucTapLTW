package Services;

import Model.CartItem;

import java.util.List;

public interface ICartService extends IGenericService<CartItem> {
    List<CartItem> findByUserId(int userId);
}
