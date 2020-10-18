package tw.com.gss.sdsd3.module.controller;

import java.util.LinkedList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.OrderDetail;
import tw.com.gss.sdsd3.module.entity.Product;
import tw.com.gss.sdsd3.module.service.ProductService;

@Slf4j
@Controller
@SessionAttributes(names = { "userid", "cart" })
public class ShopCartController {

	private final String URL_CONTROLLER_PREFIX = "/shopcart";

	private final String ATTRIBUTE_ID = "id";
	private final String ATTRIBUTE_MODEL = "modelAttribute";

	private final String URL_ADD = "/add";
	private final String URL_UPDATE = "/update";
	private final String URL_DELETE = "/delete";

	@Autowired
	private ProductService productService;

	// 導入購物車頁面
	@GetMapping(URL_CONTROLLER_PREFIX)
	public String showCartPage() {

		return "shopcart";
	}

	// 購物車內商品增減與價格計算
	@ResponseBody
	@GetMapping(URL_CONTROLLER_PREFIX + URL_ADD)
	public String addToCart(@RequestParam("id") Integer id, @RequestParam("quantity") Integer quantity,
			@ModelAttribute(ATTRIBUTE_MODEL) Product product, HttpSession session) {

		Product newproduct = productService.findById(id);
		LinkedList<Product> cart = (LinkedList<Product>) session.getAttribute("cart");

		// 先判斷欲加入購物車的商品數量是否小於庫存
			if (quantity > productService.findById(id).getStorage()) {
				return "soldout";
			}

			if (cart == null) {
				LinkedList<Product> newcart = new LinkedList<Product>();
				
					newproduct.setQuantity(quantity);
					newcart.add(newproduct);
					session.setAttribute("cart", newcart);
			} else {
				// 判斷商品有無重複, 重複的話增加到舊的
				
				for (Product allProduct : cart) {
					if (allProduct.getId() == newproduct.getId()) {
						
						// 如果湯底重複
						if (allProduct.getTag() == 1) {
							return "done";
						}
						int oldnum = allProduct.getQuantity();
						allProduct.setQuantity(quantity + oldnum);

						return "done";
					}
				}
				newproduct.setQuantity(quantity);
				cart.add(newproduct);
			}	

				return "done";
	}

	// 修改購物車商品數量(更新到Session)
	@ResponseBody
	@GetMapping(URL_CONTROLLER_PREFIX + URL_UPDATE)
	public String sendTotal(@RequestParam("id") Integer id, @RequestParam("quantity") Integer quantity,
			@ModelAttribute(ATTRIBUTE_MODEL) Product product, HttpSession session) {

		Product oldproduct = productService.findById(id);
		LinkedList<Product> cart = (LinkedList<Product>) session.getAttribute("cart");

		for (int i = 0; i < cart.size(); i++) {
			if (cart.get(i).getId() == oldproduct.getId()) {
				oldproduct = cart.get(i);
				oldproduct.setQuantity(quantity);
				cart.set(i, oldproduct);
				
			}
		}
		return "done";
	}

	// 刪除購物車商品與重新計算價格
	@ResponseBody
	@GetMapping(URL_CONTROLLER_PREFIX + URL_DELETE)
	public String deleteFromCart(@RequestParam("id") Integer id, @ModelAttribute(ATTRIBUTE_MODEL) Product product,
			HttpSession session) {

		LinkedList<Product> cart = (LinkedList<Product>) session.getAttribute("cart");

		for (int i = 0; i < cart.size(); i++) {
			if (cart.get(i).getId() == id) {
				cart.remove(i);
			}
		}
		return "done";
	}
	
	// 判斷是否小於庫存
	@ResponseBody
	@GetMapping(URL_CONTROLLER_PREFIX + "/storage")
	public String storageJudge(@RequestParam("id") Integer id, @RequestParam("quantity") Integer quantity) {
		// 先判斷購物車內欲增加的商品數量是否小於庫存
			if (quantity >= productService.findById(id).getStorage()) {
				return "soldout";	
			} else {
				return "done";
			}
	}

	// modelAttribute build
	@ModelAttribute(ATTRIBUTE_MODEL)
	protected Object prepareModelAttribute(@PathVariable(value = ATTRIBUTE_ID, required = false) String id,
			HttpServletRequest request, HttpSession session) {

		Object modelAttribute = null;

		String requestURI = request.getRequestURI();
		log.info("[prepareModelAttribute] request URI = {}", requestURI);

		if (StringUtils.isBlank(requestURI)) {
			log.warn("incoming request URI is null.");
		} else {
			String urlPrefix = request.getContextPath() + URL_CONTROLLER_PREFIX;
			try {
				if (requestURI.endsWith(urlPrefix)) {
					modelAttribute = new OrderDetail();

				} else {
					int productid = (int) session.getAttribute("productid");
					modelAttribute = productService.findById(productid);
				}
			} catch (Exception cause) {
				log.error(cause.getMessage(), cause);
			}
		}
		log.debug("The attribute, {} = {}", ATTRIBUTE_MODEL, modelAttribute);

		return modelAttribute;
	}

}
