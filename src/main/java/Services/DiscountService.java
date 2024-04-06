package Services;

import java.util.List;

import javax.inject.Inject;

import Database.IDiscountDAO;
import Model.Discounts;

public class DiscountService implements IDiscountService {
	@Inject
	IDiscountDAO discountDAO;

	@Override
	public List<Discounts> findAll(int limit, int offSet) {
		return null;
	}

	@Override
	public List<Discounts> findAll() {
		return discountDAO.findAll();
	}

	@Override
	public int save(Discounts discounts) {
		return discountDAO.save(discounts);
	}

	@Override
	public boolean update(Discounts discounts) {
		return discountDAO.update(discounts);
	}

	@Override
	public boolean delete(Discounts discounts) {
		// TODO Auto-generated method stub
		return discountDAO.delete(discounts);
	}

}
