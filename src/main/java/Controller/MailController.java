package Controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import EmailService.IEmailService;

/**
 * Servlet implementation class MailController
 */
@WebServlet("/MailController")
public class MailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Inject
	IEmailService mailEmailService;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MailController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
		int orderId = request.getParameter("orderId") != null ? Integer.valueOf(request.getParameter("orderId")) : 0;
		String email = request.getParameter("email");
		String message = request.getParameter("html");
		mailEmailService.send(email, "Xác nhận đơn hàng #" + orderId + " từ Lương Thực Việt", message);

	}

}
