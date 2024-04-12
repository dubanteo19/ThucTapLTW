package RowMaper;

import Model.Log;
import Model.LogLevel;
import RowMaper.column.LogColumn;

import java.sql.ResultSet;
import java.sql.SQLException;

public class LogMapper implements RowMapper<Log> {
    @Override
    public Log map(ResultSet r) {
        Log log = new Log();
        try {
            log.setAddress(r.getString(LogColumn.Address.toString()));
            log.setIpAddress(r.getString(LogColumn.IpAddress.toString()));
            log.setLogLevel(LogLevel.valueOf(r.getString(LogColumn.LogLevel.toString())));
            log.setId(r.getInt(LogColumn.LogId.toString()));
            log.setCurrentValue(r.getString(LogColumn.CurrentValue.toString()));
            log.setUpdatedValue(r.getString(LogColumn.UpdatedValue.toString()));
            log.setDateCreated(r.getTimestamp(LogColumn.DateCreated.toString()));
            log.setLastUpdated(r.getTimestamp(LogColumn.LastUpdated.toString()));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return log;
    }
}
