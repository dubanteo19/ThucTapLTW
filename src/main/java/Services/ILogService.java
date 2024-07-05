package Services;

import Database.ILogDAO;
import Model.Log;

import javax.inject.Inject;
import java.util.List;

public interface ILogService {
    public List<Log> findAllLogs();
}
