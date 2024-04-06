package Controller.Admin;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Database.IOrderDAO;
import Model.Orders;
import Model.User;
import Services.IOrderService;
import Services.IProductService;
import Services.IUserService;

/**
 * Servlet implementation class DashboardController
 */
@WebServlet("/admin/DashboardController")
public class DashboardController extends HttpServlet {
	@Inject
	IUserService userService;
	@Inject
	IProductService productService;
	@Inject
	IOrderService orderService;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DashboardController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int userCount = userService.findAll().size() - 1;
		int productCount = productService.getCount();
		int orderCount = orderService.findAll().size();
		List<Orders> orders = orderService.findAll();
		List<User> users = userService.findAll().subList(0, 5);
		request.setAttribute("userCount", userCount);
		request.setAttribute("productCount", productCount);
		request.setAttribute("orderCount", orderCount);
		request.setAttribute("orders", orders);
		request.setAttribute("users", users);
		request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
		;

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
