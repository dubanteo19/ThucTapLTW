package Database;

import Model.ProductStatistics;

import java.util.List;
import java.util.Map;

public interface IProductStatisticsDAO {

    List<ProductStatistics> findProductStatisticsByFilterByDate(Map<String, Object> filters, int month, String year);

    List<ProductStatistics> findProductStatisticsByFilter(Map<String, Object> filters, int limit, int offSet, String order, String sort, int duration, String durationType);
    int getCount(Map<String, Object> filters, int duration, String durationType);
}
