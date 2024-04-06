package Database;

import java.util.List;

import Model.Discounts;
import Model.Review;

public interface IDiscountDAO {
	List<Discounts> findAll();

	int save(Discounts discounts);

	boolean update(Discounts discounts);
	
	boolean delete(Discounts discounts);
}
