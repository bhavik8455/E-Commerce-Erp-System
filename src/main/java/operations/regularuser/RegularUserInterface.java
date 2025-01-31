package operations.regularuser;

import model.CustomerPojo;

public interface RegularUserInterface {
    CustomerPojo getCustomerById(int customerId);
    boolean updateCustomerDetails(int customerId, String name, String email, String phone, String address);
}