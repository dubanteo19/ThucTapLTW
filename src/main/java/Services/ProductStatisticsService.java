package Services;

import Database.IProductStatisticsDAO;
import Model.ProductStatistics;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

public class ProductStatisticsService implements IProductStatisticsService {

    @Inject
    IProductStatisticsDAO productStatisticsDAO;

    @Override
    public List<ProductStatistics> findProductStatisticsByFilter(Map<String, Object> filters, int limit, int offSet, String order, String sort, int duration) {
        return productStatisticsDAO.findProductStatisticsByFilter(filters, limit, offSet, order, sort, duration);
    }

    @Override
    public List<ProductStatistics> findAll() {
        return List.of();
    }

    @Override
    public List<ProductStatistics> findAll(int limit, int offSet) {
        return List.of();
    }

    @Override
    public int save(ProductStatistics productStatistics) {
        return 0;
    }

    @Override
    public boolean update(ProductStatistics productStatistics) {
        return false;
    }
}
