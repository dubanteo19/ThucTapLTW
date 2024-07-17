package Database;

import Model.Product;
import Model.ProductImport;
import RowMaper.ProductImportMapper;
import RowMaper.column.CategoriesColumn;
import RowMaper.column.ProductsColumn;
import Utils.JDBCConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.MessageFormat;
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

    @Override
    public List<ProductImport> find(Map<String, Object> filters, int limit, int offSet, String order, String sort, int duration, String durationType) {
        StringBuilder queryFilter = getQueryFilters(filters);
        StringBuilder queryOrder = getQueryOrder(order, sort);
        StringBuilder sql = getQueryProductImport();

        if (queryFilter != null && !queryFilter.isEmpty()) {
            sql.append(" WHERE")
                    .append(queryFilter);
        }

        if (duration != -1) {
            sql.append(MessageFormat
                    .format(" AND productimports.dateCreated >= DATE_SUB(NOW(), INTERVAL {0} {1})", duration, durationType));
        }

        sql.append(" ORDER BY");

        if (queryOrder != null && !queryOrder.isEmpty()) {
            sql.append(queryOrder);
        }

        sql.append(" products.productId ASC")
                .append(getQueryFilter("limit", limit, offSet)).append(";");

        return querry(sql.toString(), new ProductImportMapper());
    }

    @Override
    public int getCount(Map<String, Object> filters, int duration, String durationType) {
        StringBuilder queryFilter = getQueryFilters(filters);
        StringBuilder sql = new StringBuilder("""
                SELECT COUNT(*) FROM productimports
                LEFT JOIN products ON products.productId = productimports.productId
                INNER JOIN categories ON categories.categoryId = products.productId
                """);

        if (queryFilter != null && !queryFilter.isEmpty()) {
            sql.append(" WHERE")
                    .append(queryFilter);
        }

        if (duration != -1) {
            sql.append(MessageFormat
                    .format(" AND productimports.dateCreated >= DATE_SUB(NOW(), INTERVAL {0} {1})", duration, durationType));
        }

        return count(sql.toString());
    }

    private StringBuilder getQueryProductImport() {
        return new StringBuilder("""
                SELECT * FROM productimports
                LEFT JOIN products ON products.productId = productimports.productId
                INNER JOIN categories ON categories.categoryId = products.productId
                """);
    }

    private StringBuilder getQueryFilters(Map<String, Object> filters) {
        StringBuilder sql = new StringBuilder();

        filters.forEach((filter, param) -> {
            StringBuilder subQuery = getQueryFilter(filter, param);
            if (subQuery != null) {
                if (sql.length() > 0) {
                    sql.append(" AND ");
                }
                sql.append(subQuery);
            }
        });
        return sql;
    }

    private StringBuilder getQueryFilter(String filter, Object... params) {
        return switch (filter) {
            case "minCostPrice" ->
                    new StringBuilder(MessageFormat.format(" (products.costPrice > {0,number,#})", params));

            case "maxCostPrice" ->
                    new StringBuilder(MessageFormat.format(" (products.costPrice < {0,number,#})", params));

            case "category" ->
                    new StringBuilder(MessageFormat.format(" (categories.categoryId = {0,number,#} OR categories.parentCategoryId = {0,number,#})", params));

            case "id" -> new StringBuilder(MessageFormat.format(" (products.productId = {0,number,#})", params));

            case "limit" -> new StringBuilder(MessageFormat.format(" LIMIT {0,number,#} OFFSET {1,number,#}", params[0], params[1]));

            case "dateCreated"
                    -> new StringBuilder(MessageFormat.format(" (productimports.dateCreated = {0})", params));

            case "search" -> {
                StringBuilder columnsStr = new StringBuilder();
                for (ProductsColumn c : ProductsColumn.values()) {
                    if (c != ProductsColumn.CategoryId
                            && c != ProductsColumn.BlogId
                            && c != ProductsColumn.StatusId
                            && c != ProductsColumn.Thumb) {
                        columnsStr
                                .append("products.")
                                .append(c.name()).append(" LIKE ")
                                .append("'%").append(params[0]).append("%'").append(" OR ");
                    }

                }
                for (CategoriesColumn c : CategoriesColumn.values()) {
                    if (c != CategoriesColumn.CategoryId
                            && c != CategoriesColumn.ParentCategoryId) {
                        columnsStr
                                .append("categories.")
                                .append(c.name()).append(" LIKE ")
                                .append("'%").append(params[0]).append("%'").append(" OR ");
                    }
                }

                columnsStr.delete(columnsStr.length() - " OR ".length(), columnsStr.length());

                yield new StringBuilder(MessageFormat.format(" ({0})", columnsStr.toString()));
            }
            default -> null;
        };
    }

    private StringBuilder getQueryOrder(String order, String sort) {
        if (order == null || order.isEmpty()) return null;

        StringBuilder query = new StringBuilder();

        switch (order) {
            case "name":
                query.append(" products.productName ");
                break;

            case "dateCreated":
                query.append(" productimports.dateCreated ");
                break;

            case "id":
                query.append(" products.productId ");
                break;

            case "costPrice":
                query.append(" productimports.costPrice ");
                break;

            case "weight":
                query.append(" productimports.weight ");
                break;

            case "quantity":
                query.append(" productimports.quantity ");
                break;

            default:
                return null;
        }
        if (sort == null
                || (!sort.equalsIgnoreCase("ASC") && !sort.equalsIgnoreCase("DESC"))) return null;

        query.append(sort).append(", ");
        return query;
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
//        System.out.println("Row affected: " + productImportDAO.save(list));

        Map<String, Object> filters = new HashMap<>();

        String orderBy = "costPrice";
        String orderDir = "DESC";

        int limit = 5;
        int offset = 0;

        int duration = 1;
        String durationType = "MONTH";

        productImportDAO.find(filters, limit, offset, orderBy, orderDir, duration, durationType).forEach(System.out::println);
        System.out.println(productImportDAO.getCount(filters, duration, durationType));
    }
}
