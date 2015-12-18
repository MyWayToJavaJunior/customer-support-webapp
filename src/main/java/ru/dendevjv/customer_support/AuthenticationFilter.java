package ru.dendevjv.customer_support;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class AuthenticationFilter implements Filter {
    private static final Logger log = LogManager.getLogger();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {
        log.entry();
        HttpSession session = ((HttpServletRequest) request).getSession();
        if (session != null && session.getAttribute("username") == null) {
            log.trace("redirect to login");
            ((HttpServletResponse)response).sendRedirect("login");
        } else {
            log.trace("chain.doFilter()");
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {}

}
