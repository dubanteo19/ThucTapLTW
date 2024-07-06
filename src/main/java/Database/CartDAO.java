package Database;

import Model.CartItem;
import RowMaper.CartItemMapper;

import java.util.List;

public class CartDAO extends AbtractDAO<CartItem> implements ICartItemDAO {

    @Override
    public List<CartItem> findByUserId(int userId) {
        String sql = """
                SELECT p.*, categories.*, `status`.*, products_sale.*, JSON_UNQUOTE(JSON_EXTRACT(ci.cartItem, '$.quantity')) AS quantityItem
                FROM products p
                JOIN (
                    SELECT JSON_UNQUOTE(JSON_EXTRACT(cartItem, '$')) AS cartItem
                    FROM carts, JSON_TABLE(cartItems, '$[*]' COLUMNS (
                            cartItem JSON PATH '$'
                						)) AS ci
                    WHERE userId = ?
                ) AS ci ON p.productId = JSON_UNQUOTE(JSON_EXTRACT(ci.cartItem, '$.productId'))
                INNER JOIN categories ON p.categoryId = categories.categoryId
                INNER JOIN status ON p.statusId = status.statusId
                LEFT JOIN products_sale ON p.productId = products_sale.productId AND products_sale.endDateDiscount >= NOW()
                """;
        return querry(sql, new CartItemMapper(), userId);
    }

    public static void main(String[] args) {
        System.out.println(new CartDAO().findByUserId(12));
    }
}