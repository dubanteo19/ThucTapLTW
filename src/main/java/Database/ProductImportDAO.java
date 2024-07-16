package Database;

import Model.Product;
import Model.ProductImport;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ProductImportDAO extends AbtractDAO<ProductImport> implements IProductImportDAO, SQLParameterSetter<ProductImport> {

    public int save(List<ProductImport> productImports) {
        String sql = "INSERT INTO productimports (productId, weight, costPrice, quantity, dateCreated) " +
                "VALUES (?, ?, ?, ?, ?)";

        return save(sql, productImports, this);
    }

    @Override
    public void setParameters(PreparedStatement statement, ProductImport productImport) throws SQLException {
        int productId = productImport.getProduct().getId();

        statement.setInt(1, productId);
        statement.setDouble(2, productImport.getWeight());
        statement.setDouble(3, productImport.getCostPrice());
        statement.setInt(4, productImport.getQuantity());
        statement.setTimestamp(5, productImport.getDateCreated());
    }

    public static void main(String[] args) {
        List<ProductImport> list = new ArrayList<>();
        Product p1 = new Product();
        p1.setId(1);

        Product p2 = new Product();
        p2.setId(2);

        list.add(new ProductImport(p1, 1, 1, 1, new Timestamp(System.currentTimeMillis())));
        list.add(new ProductImport(p2, 2, 2, 2, new Timestamp(System.currentTimeMillis())));

        ProductImportDAO productImportDAO = new ProductImportDAO();
        System.out.println("Row affected: " + productImportDAO.save(list));;
    }
}
