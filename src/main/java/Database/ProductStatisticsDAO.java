package Database;

import Model.ProductStatistics;
import RowMaper.ProductStatisticsMapper;
import RowMaper.column.CategoriesColumn;
import RowMaper.column.ProductsColumn;
import RowMaper.column.StatusColumn;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductStatisticsDAO extends AbtractDAO<ProductStatistics> implements IProductStatisticsDAO {

    @Override
    public int getCount(Map<String, Object> filters, int duration, String durationType) {
        StringBuilder queryFilter = getQueryFilters(filters);
        StringBuilder sql;

        if (duration != -1) {
            sql = new StringBuilder(MessageFormat.format("""
                    SELECT COUNT(*) AS count
                    FROM products
                    INNER JOIN
                    	(SELECT orderdetails.productId
                    	FROM orderdetails
                    	INNER JOIN orders ON orders.orderId = orderdetails.orderId
                    	WHERE orders.dateCreated >= DATE_SUB(NOW(), INTERVAL {0} {1}) AND orders.statusId = 6
                    	GROUP BY orderdetails.productId) AS orderdetails ON orderdetails.productId = products.productId
                    INNER JOIN categories ON products.categoryId = categories.categoryId
                    INNER JOIN status ON products.statusId = status.statusId
                    """, duration, durationType));
        } else return -1;

        if (queryFilter != null && !queryFilter.isEmpty()) {
            sql.append(" WHERE")
                    .append(queryFilter);
        }

        return count(sql.toString());
    }

    public List<ProductStatistics> findProductStatisticsByFilterByDate(Map<String, Object> filters, int month, String year) {
        StringBuilder queryFilter = getQueryFilters(filters);
        StringBuilder sql = new StringBuilder(MessageFormat.format("""
                SELECT\s
                	products.*,
                	categories.*,
                	status.*,
                	orderdetails.totalSold,
                	((products.unitPrice - products.costPrice) * orderdetails.totalSold) AS totalRevenue
                FROM products
                INNER JOIN (
                	SELECT orderdetails.productId, SUM(orderdetails.quantity) AS totalSold
                	FROM orderdetails
                	INNER JOIN orders ON orders.orderId = orderdetails.orderId
                	WHERE orders.statusId = 6
                	AND (MONTH(orders.dateCreated) = {0} AND YEAR(orders.dateCreated) = {1})
                	GROUP BY orderdetails.productId
                ) AS orderdetails ON orderdetails.productId = products.productId
                INNER JOIN categories ON products.categoryId = categories.categoryId
                INNER JOIN status ON products.statusId = status.statusId
                """, month, year));

        if(month < 1 || month > 12) {
            return null;
        }

        if (queryFilter != null && !queryFilter.isEmpty()) {
            sql.append(" WHERE")
                    .append(queryFilter);
        }

        return querry(sql.toString(), new ProductStatisticsMapper());
    }

    @Override
    public List<ProductStatistics> findProductStatisticsByFilter(Map<String, Object> filters, int limit, int offSet, String order, String sort, int duration, String durationType) {
        StringBuilder queryFilter = getQueryFilters(filters);
        StringBuilder queryOrder = getQueryOrder(order, sort);
        StringBuilder sql;

        if (duration != -1) {
            sql = getQueryProductStatistics(duration, durationType);
        } else {
            sql = getQueryProductStatistics();
        }

        if (queryFilter != null && !queryFilter.isEmpty()) {
            sql.append(" WHERE")
                    .append(queryFilter);
        }
        sql.append(" ORDER BY");

        if (queryOrder != null) {
            sql.append(queryOrder);
        }

        sql.append(" products.productId ASC")
                .append(getQueryFilter("limit", limit, offSet));

        return querry(sql.toString(), new ProductStatisticsMapper());
    }

    private StringBuilder getQueryOrder(String order, String sort) {
        if (order == null || order.isEmpty()) return null;

        StringBuilder query = new StringBuilder();

        switch (order) {
            case "name":
                query.append(" products.productName ");
                break;

            case "price":
                query.append(" COALESCE(products_sale.newPrice, products.unitPrice) ");
                break;

            case "totalRevenue":
                query.append(" totalRevenue ");
                break;

            case "totalSold":
                query.append(" totalSold ");
                break;

            case "unitsInStock":
                query.append(" products.unitsInStock ");
                break;

            case "lastUpdated":
                query.append(" products.lastUpdated ");
                break;

            case "id":
                query.append(" products.productId ");
                break;

            default:
                return null;
        }
        if (sort == null
                || (!sort.equalsIgnoreCase("ASC") && !sort.equalsIgnoreCase("DESC"))) return null;

        query.append(sort).append(", ");
        return query;
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

    private StringBuilder getQueryProductStatistics() {
        return new StringBuilder("""
                SELECT\s
                    products.*,
                    categories.*,
                    status.*,
                    orderdetails.totalSold,
                    ((products.unitPrice - products.costPrice) * orderdetails.totalSold) AS totalRevenue
                FROM products
                INNER JOIN categories ON products.categoryId = categories.categoryId
                INNER JOIN status ON products.statusId = status.statusId
                LEFT JOIN (
                    SELECT orderdetails.productId, SUM(orderdetails.quantity) AS totalSold FROM orderdetails
                    GROUP BY orderdetails.productId
                ) AS orderdetails ON orderdetails.productId = products.productId
                """);
    }

    private StringBuilder getQueryProductStatistics(int duration, String durationType) {
        return new StringBuilder(MessageFormat.format("""
                SELECT\s
                	products.*,
                	categories.*,
                    status.*,
                    orderdetails.totalSold,
                    ((products.unitPrice - products.costPrice) * orderdetails.totalSold) AS totalRevenue
                FROM products
                INNER JOIN
                	(SELECT orderdetails.productId, SUM(orderdetails.quantity) AS totalSold
                	FROM orderdetails
                	INNER JOIN orders ON orders.orderId = orderdetails.orderId
                	WHERE orders.dateCreated >= DATE_SUB(NOW(), INTERVAL {0} {1}) AND orders.statusId = 6
                	GROUP BY orderdetails.productId) AS orderdetails ON orderdetails.productId = products.productId
                INNER JOIN categories ON products.categoryId = categories.categoryId
                INNER JOIN status ON products.statusId = status.statusId
                """, duration, durationType));
    }

    private StringBuilder getQueryFilter(String filter, Object... params) {
        return switch (filter) {
            case "minUnitPrice" ->
                    new StringBuilder(MessageFormat.format(" (COALESCE(products_sale.newPrice, products.unitPrice) > {0,number,#})", params));

            case "maxUnitPrice" ->
                    new StringBuilder(MessageFormat.format(" (COALESCE(products_sale.newPrice, products.unitPrice) < {0,number,#})", params));

            case "minCostPrice" ->
                    new StringBuilder(MessageFormat.format(" (products.costPrice > {0,number,#})", params));

            case "maxCostPrice" ->
                    new StringBuilder(MessageFormat.format(" (products.costPrice < {0,number,#})", params));

            case "category" ->
                    new StringBuilder(MessageFormat.format(" (categories.categoryId = {0} OR categories.parentCategoryId = {0})", params));

            case "status" -> new StringBuilder(MessageFormat.format(" (status.statusId = {0})", params));

            case "id" -> new StringBuilder(MessageFormat.format(" (products.productId = {0})", params));

            case "limit" -> new StringBuilder(MessageFormat.format(" LIMIT {0} OFFSET {1}", params[0], params[1]));

            case "name" ->
                    new StringBuilder(MessageFormat.format(" ((products.productName LIKE ''%{0}%'') OR (categories.categoryName LIKE ''%{0}%''))", params));
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
                for (StatusColumn c : StatusColumn.values()) {
                    if (c != StatusColumn.StatusId) {
                        columnsStr
                                .append("status.")
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

    public static void main(String[] args) {
        ProductStatisticsDAO productStatisticsDAO = new ProductStatisticsDAO();

        Map<String, Object> filters = new HashMap<>();
        filters.put("category", 2);

        String orderBy = "totalRevenue";
        String orderDir = "DESC";

        int limit = 5;
        int offset = 0;

        int duration = 3;

        System.out.println(productStatisticsDAO.getCount(filters, duration, "MONTH"));
        System.out.println(productStatisticsDAO.findProductStatisticsByFilter(filters, limit, offset, orderBy, orderDir, duration, "MONTH"));
        System.out.println(productStatisticsDAO.findProductStatisticsByFilterByDate(filters, 7, "2024"));
    }
}
