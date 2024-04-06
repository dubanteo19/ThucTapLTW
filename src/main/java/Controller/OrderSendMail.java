	package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Controller.cart.Cart;
import Database.IUserDAO;
import Model.CartItem;
import Model.Order_details;
import Model.Orders;
import Model.Status;
import Model.User;
import Services.IOrderService;

/**
 * Servlet implementation class OrderSendMail
 */
@WebServlet("/OrderSendMail")
public class OrderSendMail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Inject
	IOrderService orderService;
	@Inject
	IUserDAO userdao;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OrderSendMail() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User user = (User) request.getSession().getAttribute("user");
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		List<CartItem> cartItems = cart.getCartItems();
		List<Order_details> order_details = new ArrayList<Order_details>();
		Orders orders = new Orders();
		orders.setStatus(new Status(4, ""));
		orders.setUser(user);
		double shipping = 40000;
		orders.setTotalPrice(cart.getTotalPrice() + shipping);
		orders.setDiscountId(0);
		orders.setPaymentMethod("COD");
		orders.setShippingFee(shipping);
		orders.setAddress(user.getAddresses().get(0).getDescription() + user.getAddresses().get(0).getWards()
				+ user.getAddresses().get(0).getDistricts() + user.getAddresses().get(0).getProvince());
		int orderId = orderService.save(orders);
		orders.setId(orderId);
		for (CartItem cartItem : cartItems) {
			Order_details order_detail = new Order_details(orderId, cartItem.getProduct(), cartItem.getProductPrice(),
					cartItem.getQuantity());
			order_details.add(order_detail);
		}
		orders.setDetails(order_details);
		orderService.save(order_details);
		session.removeAttribute("cart");
		user = userdao.findUserById(user.getId());
		request.getSession().setAttribute("user", user);
		request.setAttribute("orders", orders);
		request.getRequestDispatcher("hoa-don.jsp").forward(request, response);
	}

}
