package Services;

import Database.ILogDAO;
import Model.Log;

import javax.inject.Inject;
import java.util.List;

public interface ILogService {
    List<Log> findAllLogs();
    void saveLog(Log log);
    Log findLogById(int id);
    boolean deleteLogById(int id);
}
