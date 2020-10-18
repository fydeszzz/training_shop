package tw.com.gss.sdsd3.module.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.Members;
import tw.com.gss.sdsd3.module.query.MemberQueryCriteria;
import tw.com.gss.sdsd3.module.service.MemberService;

@Slf4j
@Controller
@SessionAttributes(names = "account")
@RequestMapping(MemberController.URL_CONTROLLER_PREFIX)
public class MemberController {
		
		public static final String URL_CONTROLLER_PREFIX = "/backend/members";

		private final String ATTRIBUTE_ID = "id";
		private final String ATTRIBUTE_MODEL = "modelAttribute2";
		
		private final String URL_QUERY = "/query";
		private final String URL_ADD = "/add";
		private final String URL_UPDATE = "/update";
		private final String URL_DELETE = "/delete";
		private final String URL_VIEW = "/view";
		
		@Autowired private MemberService memberService;

		// 查詢所有會員資料(進首頁立即顯示)
		@GetMapping(value = { "", URL_QUERY })
		public String showQueryPage(Map<String, Object> model) {

			model.put("queryResult", memberService.findAll());
			
			return "memberCenter";
		}
		
		// 依帳號查詢會員資料(不跳轉)
		@PostMapping(value = { "", URL_QUERY })
		public String Query(
				@ModelAttribute(ATTRIBUTE_MODEL) MemberQueryCriteria queryCriteria, 
				Map<String, Object> model) {

			model.put("queryResult", memberService.findByAccount(queryCriteria));
			
			return "memberCenter";
		}
		
		// 新增會員資料- 導入新增頁
		@GetMapping(URL_ADD)
		public String showInsertPage() {
			return "memberCreate";
		}
		
		// 新增會員資料- 新增資料
		@PostMapping(URL_ADD)
		public String insert(@ModelAttribute(ATTRIBUTE_MODEL) Members member) {
			memberService.insert(member);

			return "memberCenter";
		}
		// 判斷帳號是否重複
		@ResponseBody
		@GetMapping("/check")
		public String checkRepeat(@RequestParam("account") String account) {
			// 若新增帳號重複
			if (!memberService.checkAccount(account)) {
				return "exist";
			}
				return "done";
		}
		
		// 檢查密碼是否相同(前後台修改會員密碼用)
		@ResponseBody
		@GetMapping("/checkPassword")
		public String checkPassword(@RequestParam("id") Integer id, @RequestParam("password") String password) {
			
			if (memberService.checkPassword(id, password)) {
				return "done";
			}
				return "notmatch";
		}
		
		// 修改會員資料- 導入修改頁 (AJAX?)
		@GetMapping("/{" + ATTRIBUTE_ID + "}" + URL_UPDATE)
		public String showUpdatePage() {
			
			return "memberInfo";
		}
		
		// 修改會員資料- 修改後更新
		@PostMapping("/{" + ATTRIBUTE_ID + "}" + URL_UPDATE)
		public String update(@ModelAttribute(ATTRIBUTE_MODEL) Members member) {
			memberService.update(member);

			return "processResult";
		}

		// 刪除會員資料
		@PostMapping("/{" + ATTRIBUTE_ID + "}" + URL_DELETE)
		public String delete(@PathVariable(ATTRIBUTE_ID) String id) {
			memberService.deleteById(NumberUtils.toInt(id));

			return "processResult";
		}
		
		// modelAttribute build
		 @ModelAttribute(ATTRIBUTE_MODEL)
		    protected Object prepareModelAttribute(
		    		@PathVariable(value = ATTRIBUTE_ID, required = false) String id,
		    		HttpServletRequest request) {

		        Object modelAttribute2 = null;

		        String requestURI = request.getRequestURI();
		        log.info("[prepareModelAttribute] request URI = {}", requestURI);

		        if (StringUtils.isBlank(requestURI)) {
		            log.warn("incoming request URI is null.");
		        } else {
		            String urlPrefix = request.getContextPath() + URL_CONTROLLER_PREFIX;
		            try {
		            	if (requestURI.endsWith(urlPrefix) || requestURI.startsWith(urlPrefix + URL_QUERY)) {
		            		modelAttribute2 = new MemberQueryCriteria();

		            	} else if (requestURI.startsWith(urlPrefix + URL_ADD)) {
		            		modelAttribute2 = new Members();

		                } else if (requestURI.startsWith(urlPrefix) &&
		                		(requestURI.endsWith(URL_UPDATE) || requestURI.endsWith(URL_VIEW))) {

		                    modelAttribute2 = memberService.findById(NumberUtils.toInt(id));
		                }
		            } catch(Exception cause)  {
		                log.error(cause.getMessage(), cause);
		            }
		        }

		        log.debug("The attribute, {} = {}", ATTRIBUTE_MODEL, modelAttribute2);

		        return modelAttribute2;
		    }
	
}
