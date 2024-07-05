package Controller.Admin;

import Model.Log;
import Model.Order_details;
import Model.Orders;
import Model.Status;
import Services.ILogService;
import Services.IOrderDetailsService;
import Services.IOrderService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class OrderController
 */
@WebServlet("/admin/LogController")
public class LogController extends HttpServlet {
	@Inject
	ILogService logService;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action") != null ? request.getParameter("action") : "get";
		switch (action) {
		case "get" -> get(request, response);

		default -> throw new IllegalArgumentException("Unexpected value: " + action);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void get(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Log> logs = logService.findAllLogs();
		request.setAttribute("logs",logs);
		request.getRequestDispatcher("/admin/logs-data-table.jsp").forward(request, response);
	}

	protected void detail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		int orderId = request.getParameter("orderId") != null ? Integer.valueOf(request.getParameter("orderId")) : 0;
//		Orders order = orderService.findById(orderId);
//		List<Order_details> order_details = orderDetailsService.findAllOrderId(orderId);
//		order.setDetails(order_details);
//		request.setAttribute("order", order);
//		request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
