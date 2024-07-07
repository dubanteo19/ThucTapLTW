package Controller.Admin;

import Model.Product;
import Services.IProductService;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/warehouse-management")
public class AdminWarehouseProductController extends HttpServlet {
    @Inject
    IProductService productService;
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

        Map<String, Object> filters = new HashMap<>();

        if (!searchValue.isEmpty()) {
            filters.put("search", searchValue);
        }

        if (orderBy == null || orderDir == null || orderBy.isEmpty() || orderDir.isEmpty()) {
            orderBy = "0";
            orderDir = "asc";
        }

        JsonObject jsonObject = new JsonObject();
        int totalRecordsFiltered = productService.getCount(filters);

        if (totalRecordsFiltered != 0) {
            List<Product> logList = productService
                    .findProductByFilter(filters, limit, offset, orderBy, orderDir);

            jsonObject.addProperty("recordsFiltered", totalRecordsFiltered);
            jsonObject.add("data", new Gson().toJsonTree(logList).getAsJsonArray());
        }

        jsonObject.addProperty("recordsTotal", totalRecords);
        System.out.println(jsonObject.toString());
        JsonUtils.sendJsonResponse(resp, HttpServletResponse.SC_OK, jsonObject.toString());
    }
}
