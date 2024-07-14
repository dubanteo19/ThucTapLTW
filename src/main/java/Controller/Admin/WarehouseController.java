package Controller.Admin;

import Model.Product;
import Services.IProductService;
import Utils.JsonUtils;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/nhap-kho")
public class WarehouseController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Inject
    IProductService productService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/admin/warehouse-management.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action.toLowerCase()) {
            case "search":
                search(req, resp);
                break;

            case "import":
                importProducts(req, resp);
                break;
        }
    }

    private void importProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String jsonData = req.getParameter("data");
        System.out.println(jsonData);
//        Gson gson = new Gson();
//        List<Product> productList = gson.fromJson(jsonData, new TypeToken<List<Product>>(){}.getType());
    }

    private void search(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String request = req.getParameter("request").trim();
        String id = req.getParameter("id").trim();

        JsonObject jsonObject = new JsonObject();

        switch (request.toLowerCase()) {
            case "find-id-list":
                List<Integer> idList = productService.findId(id);
                jsonObject.add("data", new Gson().toJsonTree(idList).getAsJsonArray());
                break;

            case "find-product":
                Product product = productService.findProductById(Integer.parseInt(id));
                jsonObject.add("data", new Gson().toJsonTree(product));
                break;
        }
        JsonUtils.sendJsonResponse(resp, HttpServletResponse.SC_OK, jsonObject.toString());
    }
}
