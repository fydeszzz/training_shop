package tw.com.gss.sdsd3.module.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import lombok.extern.slf4j.Slf4j;
import tw.com.gss.sdsd3.module.entity.Members;
import tw.com.gss.sdsd3.module.query.MemberQueryCriteria;
import tw.com.gss.sdsd3.module.service.MemberService;

@Slf4j
@Controller
@SessionAttributes(names = {"userid","account"} )
public class ProfileController {
		
		public static final String URL_CONTROLLER_PREFIX = "/profile";

		private final String ATTRIBUTE_ID = "id";
		private final String ATTRIBUTE_MODEL = "modelAttribute";
		
		private final String URL_UPDATE = "/update";
		
		@Autowired private MemberService memberService;

		// 導入會員中心 (客戶)
		@GetMapping(URL_CONTROLLER_PREFIX)
		public String showProfileInsertPage() {
			return "profile";
		}

		// 修改會員資料 (客戶)
		@GetMapping(URL_CONTROLLER_PREFIX + URL_UPDATE)
		public String showUpdatePage() {
			return "profileInfo";
		}
		
		// 修改會員資料- 修改後更新
		@PostMapping(URL_CONTROLLER_PREFIX + URL_UPDATE)
		public String update(@ModelAttribute(ATTRIBUTE_MODEL) Members member, 
				HttpSession session) {
			memberService.update(member);
			session.setAttribute("phone", member.getPhone());
			return "profile";
		}

		// modelAttribute build
		 @ModelAttribute(ATTRIBUTE_MODEL)
		    protected Object prepareModelAttribute(
		    		@PathVariable(value = ATTRIBUTE_ID, required = false) String id,
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
		            		modelAttribute = new MemberQueryCriteria();

		            	} else{
		            		int userid = (int) session.getAttribute("userid");
		            		modelAttribute = memberService.findById(userid);
		                }
		            } catch(Exception cause)  {
		                log.error(cause.getMessage(), cause);
		            }
		        }

		        log.debug("The attribute, {} = {}", ATTRIBUTE_MODEL, modelAttribute);

		        return modelAttribute;
		    }
	
}
