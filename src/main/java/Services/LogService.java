package Services;

import Database.ILogDAO;
import Model.Log;

import javax.inject.Inject;
import java.util.List;

public class LogService implements ILogService {
    @Inject
    ILogDAO logDAO;
    @Override
    public List<Log> findAllLogs() {
        return logDAO.findAll();
    }
}
