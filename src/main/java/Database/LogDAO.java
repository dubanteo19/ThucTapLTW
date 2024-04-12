package Database;

import Model.Log;
import Model.LogLevel;
import RowMaper.LogMapper;

import java.util.List;

public class LogDAO extends AbtractDAO<Log> implements ILogDAO {

    @Override
    public List<Log> findAll() {
        String sql = "select * from logs";
        return querry(sql, new LogMapper());
    }

    @Override
    public boolean update(Log log) {
        return false;
    }

    @Override
    public int save(Log log) {
        String sql = """ 
                insert into logs(ipAddress,
                logLevel, address, currentValue, updatedValue)
                values(?,?,?,?,?)
                """;
        return save(sql, log.getIpAddress(),
                log.getLogLevel().toString(), log.getAddress(), log.getCurrentValue(), log.getUpdatedValue());
    }

    @Override
    public boolean delete(Log log) {
        return false;
    }

}
