package Services;

import java.util.List;

import Model.Discounts;

public interface IDiscountService extends IGenericService<Discounts> {
	List<Discounts> findAll();

	int save(Discounts discounts);

	boolean update(Discounts discounts);
	
	boolean delete(Discounts discounts);
}
