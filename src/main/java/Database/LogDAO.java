package Database;


import Model.Log;
import RowMaper.LogMapper;

import java.util.List;

public class LogDAO extends AbtractDAO<Log> implements ILogDAO {
    @Override
    public List<Log> findAll() {
        String sql ="SELECT * FROM logs";
        return querry(sql, new LogMapper());
    }

    @Override
    public int save(Log log) {
        return 0;
    }

    @Override
    public boolean update(Log log) {
        return false;
    }

    @Override
    public boolean delete(Log log) {
        return false;
    }
}
