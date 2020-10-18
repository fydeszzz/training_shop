package tw.com.gss.sdsd3.module.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.OrderDetail;
import tw.com.gss.sdsd3.module.entity.Orders;
import tw.com.gss.sdsd3.module.entity.Product;
import tw.com.gss.sdsd3.module.query.OrderDetailQueryCriteria;
import tw.com.gss.sdsd3.module.query.OrdersQueryCriteria;
import tw.com.gss.sdsd3.module.service.OrderDetailService;
import tw.com.gss.sdsd3.module.service.OrdersService;
import tw.com.gss.sdsd3.module.service.ProductService;

@Slf4j
@Controller
@SessionAttributes(names = { "userid", "acount", "phone", "address", "cart" })
public class OrdersController {

	private final String URL_ORDER_PREFIX = "/order";
	private final String URL_BACKEND_PREFIX = "/backend";

	private final String ATTRIBUTE_ID = "id";
	private final String ATTRIBUTE_MODEL = "modelAttribute";

	private final String URL_BACKEND_INDEX = "/orderManage";
	private final String URL_ADD = "/add";
	private final String URL_VIEW = "/view";
	private final String URL_UPDATE = "/update";
	private final String URL_DELETE = "/delete";

	@Autowired
	private OrdersService ordersService;
	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private ProductService productService;

	// 導入訂單頁面
	@GetMapping(URL_ORDER_PREFIX)
	public String showOrderPage() {
		return "order";
	}

	// 訂單處理頁面
	@PostMapping(URL_ORDER_PREFIX + URL_ADD)
	public String insertByCostumer(@ModelAttribute(ATTRIBUTE_MODEL) Orders order, HttpSession session)
			throws Exception {

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat();
		String dateString = sdf.format(date);
		
		order.setAddress(order.getAddressPrefix() + order.getAddress()); // 地址前綴字
		order.setOrder_date(sdf.parse(dateString));

		ordersService.insert(order);
		
		// orderdetail
		LinkedList<Product> cart = (LinkedList<Product>) session.getAttribute("cart");
		Product product = new Product();
		OrderDetail detail = new OrderDetail();
		
		for (int i = 0; i < cart.size(); i++) {
			int productid = cart.get(i).getId();
			int nums = cart.get(i).getQuantity();
			int originStorage = productService.findById(productid).getStorage();
			
			detail.setOrder_id(order.getId());
			detail.setProduct_id(productid);
			detail.setQuantity(nums);
			detail.setSum(nums * productService.findById(productid).getPrice());
			orderDetailService.insertDetail(detail);
			
			// 庫存數量變動(下訂單後才改變)
			product = productService.findById(productid);
			product.setStorage(originStorage-nums);
			productService.update(product);
		}

		// 結帳後購物車清空
		LinkedList<Product> oldcart = (LinkedList<Product>) session.getAttribute("cart");
		oldcart.clear();

		return "orderSuccess";
	}

	// 導入訂單成功頁面
	@GetMapping(URL_ORDER_PREFIX + "/success")
	public String showSuccessPage() {
		return "orderSuccess";
	}

	// 導入訂單查詢頁面(以用戶id查詢)
	@GetMapping(URL_ORDER_PREFIX + URL_VIEW)
	public String orderRecordQuery(@ModelAttribute(ATTRIBUTE_MODEL) OrdersQueryCriteria queryCriteria,
			Map<String, Object> model, HttpSession session) throws Exception {

		int userid = (int) session.getAttribute("userid");
		queryCriteria.setMember_id(userid);
		List<Orders> record = ordersService.findByMemberid(queryCriteria);

			model.put("record", record);
			
			return "orderRecord";
	}

	// 訂單詳細查詢(以orderid查詢)
	@ResponseBody
	@GetMapping(value = URL_ORDER_PREFIX + "/query", produces = "application/json")
	public List<OrderDetail> showOrderDetail(@RequestParam("id") Integer id,
			@ModelAttribute(ATTRIBUTE_MODEL) OrderDetailQueryCriteria queryCriteria)
			throws Exception {
		
		queryCriteria.setOrder_id(id);
		List<OrderDetail> orderDetail = orderDetailService.findByOrderid(queryCriteria);
		
		return orderDetail;
	}

	// 導入後台訂單頁面&以訂單編號顯示全部訂單
	@GetMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX)
	public String showOrderBackend(Map<String, Object> model) {

		model.put("queryResult", ordersService.findAll());

		return "orderManage";
	}

	// 後台修改訂單頁面
	@GetMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX + "/{" + ATTRIBUTE_ID + "}" + URL_UPDATE)
	public String showUpdatePage() {
		return "orderUpdate";
	}

	// 修改訂單資料 - 修改後更新
	@PostMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX + "/{" + ATTRIBUTE_ID + "}" + URL_UPDATE)
	public String update(@ModelAttribute(ATTRIBUTE_MODEL) Orders order) {
		
		OrderDetailQueryCriteria queryCriteria = new OrderDetailQueryCriteria();
		queryCriteria.setOrder_id(order.getId());
		int orderQuantity = 0;
		int storage = 0;
		Product product = new Product();
		
		// 若取消的話庫存收回去
		if (order.getStatus() == 4) {
			List<OrderDetail> orderDetail = orderDetailService.findByOrderid(queryCriteria);
			
			for (int i = 0; i<orderDetail.size(); i++) {
				orderQuantity = orderDetail.get(i).getQuantity();
				product = productService.findById(orderDetail.get(i).getProduct_id());
				storage = product.getStorage();
				product.setStorage(storage + orderQuantity);
				productService.update(product);
			}
		}
		ordersService.update(order);

		return "processResult";
	}

	// 刪除訂單明細&訂單資料(一起刪)
	@PostMapping(URL_BACKEND_PREFIX + URL_BACKEND_INDEX + "/{" + ATTRIBUTE_ID + "}" + URL_DELETE)
	public String delete(@PathVariable(ATTRIBUTE_ID) String id) {

		orderDetailService.deleteByDetailId(NumberUtils.toInt(id));
		ordersService.deleteById(NumberUtils.toInt(id));

		return "processResult";
	}

	// modelAttribute build
	@ModelAttribute(ATTRIBUTE_MODEL)
	protected Object prepareModelAttribute(@PathVariable(value = ATTRIBUTE_ID, required = false) String id,
			OrderDetailQueryCriteria queryCriteria, HttpServletRequest request, HttpSession session) {

		Object modelAttribute = null;

		String requestURI = request.getRequestURI();
		log.info("[prepareModelAttribute] request URI = {}", requestURI);

		if (StringUtils.isBlank(requestURI)) {
			log.warn("incoming request URI is null.");
		} else {
			String urlPrefix = request.getContextPath() + URL_ORDER_PREFIX;
			try {
					// 新增訂單(客戶端)
				if (requestURI.startsWith(urlPrefix + URL_ADD) || requestURI.endsWith(urlPrefix)) {
					modelAttribute = new Orders();

					// 訂單查詢(客戶端)
				} else if (requestURI.endsWith(urlPrefix + URL_VIEW)) {
					modelAttribute = new OrdersQueryCriteria();

					// 訂單修改(後台)
				} else if (requestURI.endsWith(URL_UPDATE) || requestURI.endsWith(URL_DELETE)) {
					modelAttribute = ordersService.findById(NumberUtils.toInt(id));

					// 訂單明細查詢(客戶端&後台)
				} else {
					modelAttribute = new OrderDetailQueryCriteria();
				}

			} catch (Exception cause) {
				log.error(cause.getMessage(), cause);
			}
		}
		log.debug("The attribute, {} = {}", ATTRIBUTE_MODEL, modelAttribute);

		return modelAttribute;
	}

}
