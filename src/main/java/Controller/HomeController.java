package Controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Database.IProductDAO;
import Database.UserDAO;
import Model.User;
import Model.Product;
import Services.ICarouselServices;
import Services.ICategoryService;
import Services.IProductService;
import Services.ProductService;

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

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HomeController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
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
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
