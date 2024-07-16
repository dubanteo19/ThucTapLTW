package Services;

import Model.ProductImport;

import java.util.List;

public interface IProductImportService extends IGenericService<ProductImport> {
    int save(List<ProductImport> productImports);
}
