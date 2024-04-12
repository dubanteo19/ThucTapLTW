package Controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.LogInfor;
import Model.LogLevel;
import Model.User;
import Model.Wishlist;
import Services.IUserService;
import Utils.BHash;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Inject
    IUserService userService;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String error = "";
        User user = null;
        user = userService.findUserByEmail(email);
        String url = "/login.jsp";
        HttpSession session = request.getSession();
        if (user != null) {
            if (userService.login(password, user.getPasswordHash(),
                    new LogInfor(LogLevel.INFO, request.getRemoteAddr()))) {
                request.setAttribute("second", 60);
                if (user.getStatus().getId() != 1) {
                    error = "Tài khoản của bạn đã bị cấm";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher(url).forward(request, response);
                    destroy();
                }
                if (user.getRoleId() == 1) {
                    url = "/admin/DashboardController";
                    session.setAttribute("user", user);

                } else if (user.getStatus().getId() == 1 && user.getRoleId() == 2) {
                    url = "/tai-khoan.jsp";
                    session.setAttribute("user", user);
                    session.setAttribute("wishlist", new Wishlist(userService.getWishlist(user.getId())));
                } else {
                    request.setAttribute("email", email);
                    String href = "ResendVerification?userId=" + user.getId();
                    error = "Email chưa kích hoạt. Vui lòng bấm vào <a href=" + href + ">đây</a> để kích hoạt!";
                }
            } else {
                request.setAttribute("email", email);
                error = "Sai mật khẩu";
            }
        } else {
            error = "Email chưa đăng kí. Vui lòng đăng kí email!";
        }
        request.setAttribute("error", error);
        request.getRequestDispatcher(url).forward(request, response);
    }

}
