package tw.com.gss.sdsd3.module.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class BackendInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		boolean hasLogin = false;

		// 判斷使用者是否已登入, 預設為false
		if (!hasLogin){
			String contextPath = request.getContextPath();

			if (request.getSession().getAttribute("adminAccount") == null) {	
				response.sendRedirect(contextPath + "/backend");
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
