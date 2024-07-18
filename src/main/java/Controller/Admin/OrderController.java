package Controller.Admin;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Order_details;
import Model.Orders;
import Model.Status;
import Services.IDiscountService;
import Services.IOrderDetailsService;
import Services.IOrderService;

/**
 * Servlet implementation class OrderController
 */
@WebServlet("/admin/OrderController")
public class OrderController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Inject
    IOrderService orderService;
    @Inject
    IOrderDetailsService orderDetailsService;
    @Inject
    IDiscountService discountService;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "get";
        switch (action) {
            case "get" -> get(request, response);
            case "getFilter" -> getFilter(request, response);
            case "detail" -> detail(request, response);
            case "put" -> put(request, response);

            default -> throw new IllegalArgumentException("Unexpected value: " + action);
        }

    }

    protected void getFilter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Orders> orders = orderService.findAll();
        String statusCodeParameter = request.getParameter("status");
        System.out.println(statusCodeParameter);
        int statusCode = Integer.parseInt(statusCodeParameter);
        var filterOrders = orders.stream()
                .filter(o -> o.getStatus().getId() == statusCode)
                .toList();
        request.setAttribute("orders", filterOrders);
        request.setAttribute("statusCode", statusCodeParameter);
        request.getRequestDispatcher("/admin/orders-data-table.jsp").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void get(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Orders> orders = orderService.findAll();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/admin/orders-data-table.jsp").forward(request, response);
    }

    protected void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int orderId = request.getParameter("orderId") != null ? Integer.valueOf(request.getParameter("orderId")) : 0;
        Orders order = orderService.findById(orderId);
        List<Order_details> order_details = orderDetailsService.findAllOrderId(orderId);
        var discount = discountService.findById(order.getDiscountId());
        order.setDetails(order_details);
        request.setAttribute("discount", discount);
        request.setAttribute("order", order);
        request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);

    }

    protected void put(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int statusId = request.getParameter("statusId") != null ? Integer.valueOf(request.getParameter("statusId")) : 0;
        int orderId = request.getParameter("orderId") != null ? Integer.valueOf(request.getParameter("orderId")) : 0;
        Orders order = orderService.findById(orderId);
        order.setStatus(new Status(statusId, ""));
        boolean re = orderService.updateStatus(order);
        String result = re ? "Cập nhập trạng thái đơn hàng thành công" : "Cập nhập trạng thái đơn hàng thất bại";
        request.setAttribute("result", result);
        detail(request, response);
        System.out.println(order);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
