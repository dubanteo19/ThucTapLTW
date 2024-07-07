package Controller;

import Model.Log;
import Model.LogLevel;
import Services.ICarouselServices;
import Services.ICategoryService;
import Services.ILogService;
import Services.IProductService;
import com.mysql.cj.log.LogFactory;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class HomeController
 */
@WebServlet("/Home")
public class HomeController extends HttpServlet {
    @Inject
    IProductService productService;
    @Inject
    ICarouselServices carouselServices;
    @Inject
    ICategoryService categoryService;
    @Inject
    ILogService logService;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeController() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        Log log = new Log();
        log.setUrl("Home");
        log.setDescription("View home page");
        log.setIpAddress(request.getRemoteAddr());
        log.setAfterValue("");
        log.setNation("");
        log.setCurrentValue("");
        log.setLevel(LogLevel.INFO);
        logService.saveLog(log);
        request.setAttribute("productsSale", productService.findProductSales(30, 0));

        request.setAttribute("dsCuQua", productService.findProductByCategoryId(7, 16, 0));
        request.setAttribute("dsGao", productService.findProductByCategoryId(1, 16, 0));
        request.setAttribute("dsHat", productService.findProductByCategoryId(9, 16, 0));

        request.setAttribute("dsDau", productService.findProductByCategoryId(11, 16, 0));
        request.setAttribute("dsNguCoc", productService.findProductByCategoryId(8, 16, 0));
        request.setAttribute("dsSanPhamKhac", productService.findProductByCategoryId(10, 16, 0));
        request.setAttribute("categories", categoryService.findAll());

        request.setAttribute("carousels", carouselServices.findAll());

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }
}
