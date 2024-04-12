package Model;

public class LogInfor {
    private LogLevel logLevel;
    private String ipAddress;

    public LogInfor(LogLevel logLevel, String ipAddress) {
        this.logLevel = logLevel;
        this.ipAddress = ipAddress;
    }

    public LogLevel getLogLevel() {
        return logLevel;
    }

    public void setLogLevel(LogLevel logLevel) {
        this.logLevel = logLevel;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }
}
