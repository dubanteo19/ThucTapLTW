package Database;


import Model.Log;

import java.util.List;

public interface ILogDAO {

    List<Log> findAll();

    boolean update(Log log);

    int save(Log log);

    boolean delete(Log log);
}
