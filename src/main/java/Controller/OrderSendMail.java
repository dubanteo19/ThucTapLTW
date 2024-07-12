package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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
import Model.*;
import Services.ICartService;
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
	@Inject
	ICartService cartService;
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
		Discounts discounts = (Discounts) request.getSession().getAttribute("discount");
		List<CartItem> cartItems = cart.getCartItems();
		List<Order_details> order_details = new ArrayList<Order_details>();
		Orders orders = new Orders();
		orders.setStatus(new Status(4, ""));
		orders.setUser(user);
		double shipping = 40000;
		String totalPrice = request.getParameter("totalPrice");
		System.out.println(totalPrice + "===================");
		orders.setTotalPrice(Double.parseDouble(totalPrice));
		orders.setDiscountId(discounts.getId());
		orders.setPaymentMethod("COD");
		orders.setShippingFee(shipping);
		String selectedAddress = request.getParameter("selectedAddress");
		String province = request.getParameter("Province");
		String district = request.getParameter("District");
		String ward = request.getParameter("Ward");
		String note = request.getParameter("note");
		if ("other".equals(selectedAddress)) {
			String customAddress = province + ", " + district + ", " + ward;
			orders.setAddress(customAddress);
		} else {
			orders.setAddress(selectedAddress);
		}
		orders.setNote(note);
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
		cartService.delete(user.getId());
		user = userdao.findUserById(user.getId());
		request.getSession().setAttribute("user", user);
		request.setAttribute("orders", orders);
		request.getRequestDispatcher("hoa-don.jsp").forward(request, response);
	}

}
