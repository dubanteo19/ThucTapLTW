package Controller.Admin;

import Model.ProductStatistics;
import Services.IProductService;
import Services.IProductStatisticsService;
import Utils.JsonUtils;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/warehouse-management")
public class AdminWarehouseProductController extends HttpServlet {
    @Inject
    IProductService productService;

    @Inject
    IProductStatisticsService productStatisticsService;

    private int totalRecords;
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        totalRecords = productService.getCount();
        req.getRequestDispatcher("/admin/warehouse-products-data-table.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int limit = Integer.parseInt(req.getParameter("length"));
        int offset = Integer.parseInt(req.getParameter("start"));
        String searchValue = req.getParameter("search[value]");
        String orderBy = req.getParameter("order[0][column]");
        String orderDir = req.getParameter("order[0][dir]");
        int duration = -1;

        if(orderBy != null) {
            orderBy = req.getParameter(MessageFormat.format("columns[{0}][name]", Integer.parseInt(orderBy)));
        }

        Map<String, Object> filters = new HashMap<>();

        if (!searchValue.isEmpty()) {
            filters.put("search", searchValue);
        }

        JsonObject jsonObject = new JsonObject();
        List<ProductStatistics> data = productStatisticsService
                .findProductStatisticsByFilter(filters, limit, offset, orderBy, orderDir, duration);

        if (data != null && !data.isEmpty()) {
            jsonObject.addProperty("recordsFiltered", data.size());
            jsonObject.add("data", new Gson().toJsonTree(data).getAsJsonArray());
        }

        jsonObject.addProperty("recordsTotal", totalRecords);

        JsonUtils.sendJsonResponse(resp, HttpServletResponse.SC_OK, jsonObject.toString());
    }
}