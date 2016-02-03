package com.secsm.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.secsm.info.AccountInfo;

public class loginFilter implements Filter {
	
	protected FilterConfig filterConfig;
    private static String LOGIN_URL = "index";
    
	private static final Logger logger = LoggerFactory.getLogger(loginFilter.class);

    public void init(FilterConfig filterConfig) throws ServletException {
    	 this.filterConfig = filterConfig;
    	 
    }
    
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
                throws java.io.IOException, ServletException {
	    // 세션 객체 생성
         HttpSession session = ((HttpServletRequest)request).getSession();
         AccountInfo member = (AccountInfo) session.getAttribute("currentmember");
         
         if(member != null) {
             logger.info(member.toString());
        	// 로그인을 했다면 다음 필터를 실행한다.
        	 chain.doFilter(request, response);
         }
         else{
             logger.info("member == null");
             // 로그인을 하지 않았을 경우 로그인 페이지로 이동한다.
             //((HttpServletResponse)response).sendRedirect(LOGIN_URL);
             RequestDispatcher dispatcher = request.getRequestDispatcher(LOGIN_URL);
             dispatcher.forward(request, response);
         }
    	 
    }
    
    public void destroy() {
        this.filterConfig = null;
    }
    
 }