package RowMaper;

import Model.Categories;
import Model.Product;
import Model.ProductImport;
import RowMaper.column.CategoriesColumn;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class ProductImportMapper implements RowMapper<ProductImport> {
    @Override
    public ProductImport map(ResultSet r) throws SQLException {
        ProductImport re;

        try {
            Categories categories = new Categories();
            categories.setId(r.getInt(CategoriesColumn.CategoryId.name()));
            categories.setName(r.getString(CategoriesColumn.CategoryName.name()));
            categories.setParentCategoryId(r.getInt(CategoriesColumn.ParentCategoryId.name()));
            categories.setActive(r.getInt(CategoriesColumn.Active.name()));

            Product product = new Product();
            product.setId(r.getInt("productId"));
            product.setName(r.getString("productName"));
            product.setCategories(categories);

            double weight = r.getDouble("weight");
            double costPrice = r.getDouble("costPrice");
            int quantity = r.getInt("quantity");
            Timestamp dateCreated = r.getTimestamp("dateCreated");

            re = new ProductImport(product, weight, costPrice, quantity, dateCreated);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        return re;
    }
}
