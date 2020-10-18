package tw.com.gss.sdsd3.module.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class LoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		boolean hasLogin = false;

		// 判斷使用者是否已登入, 預設為false
		if (!hasLogin){
			String contextPath = request.getContextPath();

			if (request.getSession().getAttribute("account") == null) {	
				request.setAttribute("message", "請先登入");
//				request.getRequestDispatcher("/login").forward(request, response);
				response.sendRedirect(contextPath + "/login");
			} else {
				hasLogin = true;
			}
		}
		
		return hasLogin;	
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
