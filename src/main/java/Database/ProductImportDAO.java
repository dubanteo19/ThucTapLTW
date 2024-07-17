package Database;

import Model.Product;
import Model.ProductImport;
import Utils.JDBCConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

public class ProductImportDAO extends AbtractDAO<ProductImport> implements IProductImportDAO, SQLParameterSetter<ProductImport> {

    @Override
    public int save(List<ProductImport> productImports) {
        String sql = """
                INSERT INTO productimports (productId, weight, costPrice, quantity, dateCreated)
                SELECT ?, ?, ?, ?, ?
                FROM dual
                WHERE NOT EXISTS (
                    SELECT 1 FROM productimports\s
                    WHERE productId = ? AND dateCreated = ?
                )
                """;

        Map<Integer, ProductImport> productImportMap = new HashMap<>();
        for (ProductImport productImport : productImports) {
            int productId = productImport.getProduct().getId();

            if (!productImportMap.containsKey(productId)) {
                productImportMap.put(productId, productImport);
                continue;
            }

            Timestamp newDate = productImport.getDateCreated();
            if (newDate.after(productImportMap.get(productId).getDateCreated())) {
                productImportMap.put(productId, productImport);
            }
        }

        int result = save(sql, productImports, this);

        updateProduct(productImportMap.values().stream().collect(Collectors.toList()));

        return result;
    }

    private int updateProduct(List<ProductImport> objects) {
        try {
            String sql = "UPDATE products SET " +
                    "products.unitsInStock = (products.unitsInStock + ?)" +
                    ", products.weight = ?" +
                    ", products.costPrice = ?" +
                    ", products.lastUpdatedImport = ?" +
                    "WHERE productId = ? AND products.lastUpdatedImport < ?";

            Connection conn = JDBCConnector.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            conn.setAutoCommit(false);

            for (ProductImport object : objects) {
                Timestamp date = object.getDateCreated();

                statement.setInt(1, object.getQuantity());
                statement.setDouble(2, object.getWeight());
                statement.setDouble(3, object.getCostPrice());
                statement.setTimestamp(4, date);
                statement.setInt(5, object.getProduct().getId());
                statement.setTimestamp(6, date);

                statement.addBatch();
            }

            int[] result = statement.executeBatch();
            int totalRowsAffected = Arrays.stream(result).sum();
            conn.commit();

            return totalRowsAffected;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        } finally {
            JDBCConnector.closeConnect();
        }
    }

    @Override
    public void setParameters(PreparedStatement statement, ProductImport productImport) throws SQLException {
        int productId = productImport.getProduct().getId();

        statement.setInt(1, productId);
        statement.setDouble(2, productImport.getWeight());
        statement.setDouble(3, productImport.getCostPrice());
        statement.setInt(4, productImport.getQuantity());
        statement.setTimestamp(5, productImport.getDateCreated());
        statement.setInt(6, productId);
        statement.setTimestamp(7, productImport.getDateCreated());
    }

    public static void main(String[] args) {
        List<ProductImport> list = new ArrayList<>();
        Product p1 = new Product();
        p1.setId(1);

        Product p2 = new Product();
        p2.setId(2);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        String dateCreatedStr = "10-07-2003 13:00";
        LocalDateTime localDateTime = LocalDateTime.parse(dateCreatedStr, formatter);

        list.add(new ProductImport(p1, 1, 1, 1, Timestamp.valueOf(localDateTime)));
        list.add(new ProductImport(p2, 2, 2, 2, Timestamp.valueOf(localDateTime)));

        ProductImportDAO productImportDAO = new ProductImportDAO();
        System.out.println("Row affected: " + productImportDAO.save(list));
    }
}
