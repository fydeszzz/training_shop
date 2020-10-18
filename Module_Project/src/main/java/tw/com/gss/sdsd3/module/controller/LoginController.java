package tw.com.gss.sdsd3.module.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.Members;
import tw.com.gss.sdsd3.module.entity.Product_tag;
import tw.com.gss.sdsd3.module.query.ProductQueryCriteria;
import tw.com.gss.sdsd3.module.service.MemberService;
import tw.com.gss.sdsd3.module.service.ProductService;
import tw.com.gss.sdsd3.module.service.Product_tagService;

@Slf4j
@Controller
public class LoginController {

	public static final String URL_CONTROLLER_PREFIX = "/login";
	public static final String URL_HOME_PREFIX = "/index";
	public static final String URL_REGISTER_PREFIX = "/register";
	public static final String URL_LOGOUT= "/logout";

	private final String ATTRIBUTE_MODEL = "modelAttribute";

	@Autowired private MemberService memberService;
	@Autowired private ProductService productService;
	@Autowired private Product_tagService tagService;

	// 導入網站首頁與查詢條Model
	@GetMapping(URL_HOME_PREFIX)
	public String showIndexPage(@ModelAttribute(ATTRIBUTE_MODEL) ProductQueryCriteria queryCriteria,
			HttpServletRequest request, Map<String, Object> model, HttpSession session) throws IOException {

		model.put("queryResult", productService.findBy(queryCriteria));
		
		List<Product_tag> tagList = tagService.findAllTag();
		request.setAttribute("tagList", tagList);
		
		return "index";
	}

	// 導入登入頁
	@GetMapping(URL_CONTROLLER_PREFIX)
	public String showLoginPage() {
		return "login";
	}

	// 登入驗證
	@PostMapping(URL_CONTROLLER_PREFIX)
	public String checkLogin(@RequestParam("account") String account, @RequestParam("password") String password,
			HttpSession session) {
		
		if (memberService.checkLogin(account, password) != null) {
			session.setAttribute("userid", memberService.checkLogin(account, password).get(0).getId());
			session.setAttribute("account", account);
			session.setAttribute("phone", memberService.checkLogin(account, password).get(0).getPhone());

			return "redirect:/index";
		}
			return "redirect:/login";
	}

	// 登出
	@GetMapping(URL_LOGOUT)
	public String logout(HttpSession session) {
		session.invalidate();

		return "redirect:/index";
	}
	
	// 導入註冊頁
	@GetMapping(URL_REGISTER_PREFIX)
	public String showRegisterPage() {
		return "register";
	}
	
	// 註冊新帳號
	@PostMapping(URL_REGISTER_PREFIX)
	public String register(@ModelAttribute(ATTRIBUTE_MODEL) Members member) {
		
		// 檢查帳號是否重複
		try {
			if (memberService.insert(member) == -1) {
				return "redirect:/register";
			}

		} catch(Exception cause) {
			log.error(cause.getMessage(), cause);
		}
			return "redirect:/login";
	}

	// 導入購物流程頁
	@GetMapping("/infomation")
	public String showInfoPage() {
		return "infomation";
	}

	// modelAttribute build
	@ModelAttribute(ATTRIBUTE_MODEL)
	protected Object prepareModelAttribute(HttpServletRequest request) {

		Object modelAttribute = null;

		String requestURI = request.getRequestURI();
		log.info("[prepareModelAttribute] request URI = {}", requestURI);

		if (StringUtils.isBlank(requestURI)) {
			log.warn("incoming request URI is null.");
		} else {
			try {
				if (requestURI.endsWith(URL_REGISTER_PREFIX)) {
					modelAttribute = new Members();

				} else {
					modelAttribute = new ProductQueryCriteria();
				}

			} catch (Exception cause) {
				log.error(cause.getMessage(), cause);
			}
		}
		log.debug("The attribute, {} = {}", ATTRIBUTE_MODEL, modelAttribute);

		return modelAttribute;
	}
}
