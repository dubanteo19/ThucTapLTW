package Services;

import Database.IProductImportDAO;
import Model.ProductImport;

import javax.inject.Inject;
import java.util.List;

public class ProductImportService implements IProductImportService {

    @Inject
    IProductImportDAO productImportDAO;

    @Override
    public int save(List<ProductImport> productImports) {
        return productImportDAO.save(productImports);
    }

    @Override
    public List<ProductImport> findAll() {
        return List.of();
    }

    @Override
    public List<ProductImport> findAll(int limit, int offSet) {
        return List.of();
    }

    @Override
    public int save(ProductImport productImport) {
        return 0;
    }

    @Override
    public boolean update(ProductImport productImport) {
        return false;
    }
}