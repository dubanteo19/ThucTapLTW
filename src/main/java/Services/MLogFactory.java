package Services;

import Model.Log;

import javax.servlet.http.HttpServletRequest;

public class MLogFactory {
    public static Log getLog(HttpServletRequest httpServletRequest) {
        Log log = new Log();
        log.setIpAddress(httpServletRequest.getRemoteAddr());
        return log;
    }
}
