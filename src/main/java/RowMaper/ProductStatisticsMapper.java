package RowMaper;

import Model.Product;
import Model.ProductStatistics;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductStatisticsMapper implements RowMapper<ProductStatistics> {
    @Override
    public ProductStatistics map(ResultSet r) throws SQLException {

        ProductStatistics productStatistics = new ProductStatistics();

        productStatistics.setProduct(new ProductMapper().map(r));
        productStatistics.setTotalSold(r.getInt("totalSold"));
        productStatistics.setTotalRevenue(r.getDouble("totalRevenue"));

        return productStatistics;
    }
}
