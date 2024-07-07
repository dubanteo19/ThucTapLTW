package Services;

import Model.ProductStatistics;

import java.util.List;
import java.util.Map;

public interface IProductStatisticsService extends IGenericService<ProductStatistics> {
    List<ProductStatistics> findProductStatisticsByFilter(Map<String, Object> filters, int limit, int offSet, String order, String sort, int duration);
}
