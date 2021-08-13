package com.bberzhou.filter;

import javax.servlet.*;
import java.io.IOException;

/**
 * @description:
 * @author: bberzhou@gmail.com
 * @date: 8/13/2021
 * Create By Intellij IDEA
 */
public class Filter1 implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("Filter1 前置代码");
        System.out.println("Filter1  线程名:"+Thread.currentThread().getName());
        System.out.println("Filter1  " + servletRequest.getParameter("username"));
        filterChain.doFilter(servletRequest,servletResponse);
        System.out.println("Filter1  线程名:"+Thread.currentThread().getName());
        System.out.println("Filter1 后置代码");
    }

    @Override
    public void destroy() {

    }
}
