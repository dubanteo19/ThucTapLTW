package adapter;

import Model.Product;
import Model.ProductImport;
import com.google.gson.*;

import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.time.LocalDate;

public class ProductImportTypeAdapter implements JsonDeserializer<ProductImport> {
    @Override
    public ProductImport deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException {
        JsonObject jsonObject = json.getAsJsonObject();

        double weight = jsonObject.get("weight").getAsDouble();
        double costPrice = jsonObject.get("costPrice").getAsDouble();
        int quantity = jsonObject.get("quantity").getAsInt();
        LocalDate localDate = LocalDate.parse(jsonObject.get("dateCreated").getAsString());
        Timestamp dateCreated = Timestamp.valueOf(localDate.atStartOfDay());

        int productId = jsonObject.get("id").getAsInt();
        String productName = jsonObject.get("name").getAsString();

        Product product = new Product();
        product.setName(productName);
        product.setId(productId);

        ProductImport productImport = new ProductImport();
        productImport.setProduct(product);
        productImport.setWeight(weight);
        productImport.setCostPrice(costPrice);
        productImport.setQuantity(quantity);
        productImport.setDateCreated(dateCreated);

        return productImport;
    }
}
