package adapter;

import Model.Product;
import Model.ProductImport;
import com.google.gson.*;

import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ProductImportTypeAdapter implements JsonDeserializer<ProductImport> {
    @Override
    public ProductImport deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException {
        JsonObject jsonObject = json.getAsJsonObject();

        double weight = jsonObject.get("weight").getAsDouble();
        double costPrice = jsonObject.get("costPrice").getAsDouble();
        int quantity = jsonObject.get("quantity").getAsInt();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        String dateCreatedStr = jsonObject.get("dateCreated").getAsString();

        LocalDateTime localDateTime = LocalDateTime.parse(dateCreatedStr, formatter);

        Timestamp dateCreated = Timestamp.valueOf(localDateTime);

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
