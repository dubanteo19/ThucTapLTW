package Services;

import Model.Log;
import Model.LogLevel;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class MLogFactory {
    public static Map<Integer, LogLevel> logMap = new HashMap<Integer, LogLevel>();

    static {
        logMap.put(1, LogLevel.INFO);
        logMap.put(2, LogLevel.ALERT);
        logMap.put(3, LogLevel.WARNING);
        logMap.put(4, LogLevel.DANGER);
    }

    public static LogLevel getLogLevel(int level) {
        return logMap.get(level);
    }

    public static Log getLog(HttpServletRequest hquest, HttpServlet httpServlet, int logLevel) {
        Log log = new Log();
        String ipAddress = filterLocalIpAddress(hquest.getRemoteAddr());
        log.setIpAddress(ipAddress);
        String url = hquest.getRequestURI();
        log.setUrl(url);
        log.setDescription("View");
        log.setAfterValue("");
        log.setCurrentValue("");
        log.setNation(getNation(ipAddress));
        log.setLevel(getLogLevel(logLevel));
        return log;
    }

    private static String filterLocalIpAddress(String remoteAddr) {
        return remoteAddr.equals("0:0:0:0:0:0:0:1") ? "Local host" : remoteAddr;
    }


    private static String getNation(String ipAddress) {
        return "Viet Nam";
    }
}
