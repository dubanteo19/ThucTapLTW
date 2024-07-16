package Model;

import java.io.Serializable;
import java.sql.Timestamp;

public class ProductImport implements Serializable {

    private Product product;
    private double weight;
    private double costPrice;
    private int quantity;
    private Timestamp dateCreated;

    public ProductImport() {

    }

    public ProductImport(Product product, double weight, double costPrice, int quantity, Timestamp dateCreated) {
        this.product = product;
        this.weight = weight;
        this.costPrice = costPrice;
        this.quantity = quantity;
        this.dateCreated = dateCreated;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public double getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(double costPrice) {
        this.costPrice = costPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    @Override
    public String toString() {
        return "ProductImport{" +
                "weight=" + weight +
                ", costPrice=" + costPrice +
                ", quantity=" + quantity +
                ", dateCreated=" + dateCreated +
                ", product=" + product +
                '}';
    }
}