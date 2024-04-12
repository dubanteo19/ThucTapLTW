package Model;

import java.sql.Timestamp;

public class Log extends Model {
    private int id;
    private String ipAddress;
    private LogLevel logLevel;
    private String address;
    private String currentValue;
    private String updatedValue;

    public Log(Timestamp dateCreated, Timestamp lastUpdated, String ipAddress,
               LogLevel logLevel, String address, String currentValue, String updatedValue, int id) {
        super(dateCreated, lastUpdated);
        this.ipAddress = ipAddress;
        this.logLevel = logLevel;
        this.address = address;
        this.currentValue = currentValue;
        this.updatedValue = updatedValue;
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Log() {
    }

    ;

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public LogLevel getLogLevel() {
        return logLevel;
    }

    public void setLogLevel(LogLevel logLevel) {
        this.logLevel = logLevel;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCurrentValue() {
        return currentValue;
    }

    public void setCurrentValue(String currentValue) {
        this.currentValue = currentValue;
    }

    public String getUpdatedValue() {
        return updatedValue;
    }

    public void setUpdatedValue(String updatedValue) {
        this.updatedValue = updatedValue;
    }

    @Override
    public String toString() {
        return "Log{" +
                "id=" + id +
                ", ipAddress='" + ipAddress + '\'' +
                ", logLevel=" + logLevel +
                ", address='" + address + '\'' +
                ", currentValue='" + currentValue + '\'' +
                ", updatedValue='" + updatedValue + '\'' +
                '}';
    }
}
