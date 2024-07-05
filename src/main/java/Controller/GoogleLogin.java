package Controller;

import Model.GoogleAccount;
import Model.Status;
import Model.User;
import Model.Wishlist;
import Services.UserServices;
import Utils.BHash;
import Utils.GoogleLoginHelper;

import javax.inject.Inject;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "GoogleLogin", value = "/GoogleLogin")
public class GoogleLogin extends HttpServlet {
    @Inject
    UserServices userServices;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        String error = request.getParameter("error");
        //neu nguoi dung huy uy quyen
        if (error != null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        GoogleLoginHelper gg = new GoogleLoginHelper();
        String accessToken = gg.getToken(code);
        GoogleAccount acc = gg.getUserInfo(accessToken);
        User user = userServices.findUserByEmail(acc.getEmail());
        if (user == null) {
            user = new User();
            user.setEmail(acc.getEmail());
            user.setFullName(acc.getName());
            user.setPasswordHash(BHash.hashWithSalt(acc.getId()));
            user.setRoleId(2);
            user.setPhone("");
            user.setStatus(new Status(1, ""));
            session.setAttribute("wishlist", new Wishlist());
            userServices.save(user);
        } else {
            session.setAttribute("wishlist", new Wishlist(userServices.getWishlist(user.getId())));
        }
        session.setAttribute("user", user);
        String url = "tai-khoan.jsp";
        response.sendRedirect(url);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}