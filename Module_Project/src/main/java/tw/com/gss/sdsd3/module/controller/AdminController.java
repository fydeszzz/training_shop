package tw.com.gss.sdsd3.module.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.service.MemberService;

@Slf4j
@Controller
public class AdminController {

	public static final String URL_CONTROLLER_PREFIX = "/backend";

	private final String URL_HOME = "/admin";

	@Autowired private MemberService memberService;
	
	// 導入登入頁
	@GetMapping(URL_CONTROLLER_PREFIX)
	public String showAdminLoginPage() {
		return "adminLogin";
	}

	// 登入驗證
	@PostMapping(URL_CONTROLLER_PREFIX)
	public String checkAdminLogin(@RequestParam("account") String account, @RequestParam("password") String password,
			HttpSession session) {

		// 先寫死一組管理者帳號(admin / root)
		if (account.equals("admin") && password.equals("root")) {
			session.setAttribute("adminAccount", account);
			return "redirect:/backend/admin";
		} else {
			return "redirect:/backend";
		}
	}
	
	// 導入後台管理首頁
	@GetMapping(URL_CONTROLLER_PREFIX + URL_HOME)
	public String showAdminPage() {
		return "admin";
	}

//	// 導入網站首頁與查詢條Model
//	@RequestMapping(value = URL_HOME_PREFIX, method = RequestMethod.GET)
//	public String showIndexPage(@ModelAttribute(ATTRIBUTE_MODEL) ProductQueryCriteria queryCriteria,
//			HttpServletRequest request, Map<String, Object> model, HttpSession session) throws IOException {
//
//		if (session.getAttribute("account") == null) {
//			session.setAttribute("login_btn", "登入/註冊");
//		}
//		model.put("queryResult", productService.findBy(queryCriteria));
//		List<Product_tag> tagList = tagService.findAllTag();
//		request.setAttribute("tagList", tagList);
//		
//		return "index";
//	}

}
