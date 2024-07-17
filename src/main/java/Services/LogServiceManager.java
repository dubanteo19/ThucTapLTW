package Services;

public class LogServiceManager {
    private static ILogService logService;

    static {
        logService = new LogService();
    }
    public static ILogService getLogService() {
        
    }
}
