package Model;

public class ProductStatistics {

    private Product product;
    private int totalSold;
    private double totalRevenue;
    private int status;

    public ProductStatistics() {

    }

    public ProductStatistics(Product product, int totalSold, double totalRevenue, int status) {
        this.product = product;
        this.totalSold = totalSold;
        this.totalRevenue = totalRevenue;
        this.status = status;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getTotalSold() {
        return totalSold;
    }

    public void setTotalSold(int totalSold) {
        this.totalSold = totalSold;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ProductStatistics{" +
                "product=" + product +
                ", totalSold=" + totalSold +
                ", totalRevenue=" + totalRevenue +
                ", status=" + status +
                '}';
    }
}
