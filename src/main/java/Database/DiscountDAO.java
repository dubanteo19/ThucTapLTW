package Database;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import com.mysql.cj.util.Util;

import Model.Discounts;
import RowMaper.DiscountMapper;

public class DiscountDAO extends AbtractDAO<Discounts> implements IDiscountDAO {

	@Override
	public List<Discounts> findAll() {
		String sql = "SELECT * FROM discounts";
		return querry(sql, new DiscountMapper());
	}

	@Override
	public int save(Discounts discounts) {
		String sql = "INSERT INTO discounts(amount,code,type,conditions,expDate) VALUES (?,?,?,?,?)";
		return save(sql, discounts.getAmount(), discounts.getCode(), discounts.getType(), discounts.getCondition(),
				discounts.getExpDate());
	}

	@Override
	public boolean update(Discounts discounts) {
		String sql = "UPDATE discounts SET amount =?,code =?,type =?,conditions = ?,expDate = ? where discountId =?";
		return update(sql, discounts.getAmount(), discounts.getCode(), discounts.getType(), discounts.getCondition(),
				discounts.getExpDate(), discounts.getId());
	}

	public static void main(String[] args) throws ParseException {
		DiscountDAO dao = new DiscountDAO();
		String selectedDate = "25/1/2024";
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		java.util.Date date = dateFormat.parse(selectedDate);
		Date sqlDate = new Date(date.getTime());
		System.out.println(dao.update(new Discounts(13, 1, "dsds", "sds", 10.0, sqlDate)));
	}

	@Override
	public boolean delete(Discounts discounts) {
		String sql = "DELETE FROM discounts WHERE discountId = ?";
		return update(sql, discounts.getId());
	}
}
