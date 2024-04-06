package Controller.cart;

import java.io.IOException;
import java.net.http.HttpResponse;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.google.gson.Gson;
import com.google.gson.JsonObject;

import Model.CartItem;
import Utils.JsonUtils;

/**
 * Servlet implementation class Cart
 */
@WebServlet("/CartController")
public class CartController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	private Cart cart;

	private final String PRODUCT_NOT_FOUND = "Lỗi, không tìm thấy sản phẩm";
	private final String ADD_SUCCESS = "Thêm vào giỏ hàng thành công";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		if (action != null) {
			action = action.trim().toUpperCase();
		} else
			action = "";

		switch (action) {
		case "ADD" -> addToCart(req, resp);
		case "UPDATE" -> update(req, resp);
		}
	}

	private void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();

		cart = (Cart) session.getAttribute("cart");

		if (cart == null)
			return;

		int idProduct = Integer.parseInt(req.getParameter("idProduct"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		JsonObject jsonResp = new JsonObject();
		int status;

		if (cart.update(idProduct, quantity)) {
			session.setAttribute("cart", cart);

			addJsonCart(cart.getItem(idProduct), jsonResp);

			status = HttpServletResponse.SC_OK;
		} else {
			jsonResp.addProperty("error", PRODUCT_NOT_FOUND);
			status = HttpServletResponse.SC_INTERNAL_SERVER_ERROR;
		}
		JsonUtils.sendJsonResponse(resp, status, jsonResp.toString());
	}

	private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		cart = (Cart) session.getAttribute("cart");
		if (cart == null) {
			cart = new Cart();
			session.setAttribute("cart", cart);
		}
		int quantity = 1;
		quantity = req.getParameter("quanlity") == null ? quantity : Integer.valueOf(req.getParameter("quanlity"));
		int idProduct = Integer.parseInt(req.getParameter("idProduct"));
		JsonObject jsonResp = new JsonObject();
		int status;
		if (cart.add(idProduct, quantity)) {
			session.setAttribute("cart", cart);

			addJsonCart(cart.getItem(idProduct), jsonResp);

			jsonResp.addProperty("success", ADD_SUCCESS);

			status = HttpServletResponse.SC_OK;
		} else {
			jsonResp.addProperty("error", PRODUCT_NOT_FOUND);
			status = HttpServletResponse.SC_INTERNAL_SERVER_ERROR;
		}

		JsonUtils.sendJsonResponse(resp, status, jsonResp.toString());
	}

	private void addJsonCart(CartItem item, JsonObject jsonResp) {
		jsonResp.addProperty("totalItems", cart.getTotalItems());
		jsonResp.addProperty("totalPrice", cart.getTotalPrice());
		jsonResp.addProperty("itemTotalPrice", item != null ? item.calculatePrice() : 0);

		jsonResp.add("item", new Gson().toJsonTree(item, CartItem.class));
	}
}