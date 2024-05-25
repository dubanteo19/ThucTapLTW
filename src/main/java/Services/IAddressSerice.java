package Services;

import Model.Address;
import Model.User;

public interface IAddressSerice  extends IGenericService<Address>{
	boolean delete(Address address);
	Address findAddressById(int id);

	boolean updateDefaultAddress(int userId);
	Address getDefaultAddressByUserId(int userId);

}
