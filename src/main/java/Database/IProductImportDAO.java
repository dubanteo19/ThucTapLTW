package Database;

import Model.ProductImport;

import java.util.List;

public interface IProductImportDAO extends GenericDAO<ProductImport> {
    int save(List<ProductImport> productImports);
}