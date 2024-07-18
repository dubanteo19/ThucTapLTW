package Controller.Admin;

import Model.Status;
import Model.User;
import Services.IAddressService;
import Services.IOrderDetailsService;
import Services.IUserService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/admin/StaffController")
public class StaffsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Inject
    IUserService userService;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "get";
        switch (action) {
            case "get" -> get(request, response);
            case "detail" -> detail(request, response);
            case "put" -> put(request, response);
            default -> throw new IllegalArgumentException("Unexpected value: " + action);
        }

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void get(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userService.findAll();
        List<User> staffs = users
                .stream()
                .filter(user -> user.getRoleId() == 3)
                .toList();
        request.setAttribute("users", staffs);
        request.getRequestDispatcher("/admin/staffs-data-table.jsp").forward(request, response);
    }

    protected void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = request.getParameter("userId") != null ? Integer.valueOf(request.getParameter("userId")) : 0;
        User user = userService.findUserById(userId);
        user = userService.findUserByEmail(user.getEmail());
        request.setAttribute("user", user);
        request.getRequestDispatcher("/admin/user-detail.jsp").forward(request, response);
    }

    protected void put(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
