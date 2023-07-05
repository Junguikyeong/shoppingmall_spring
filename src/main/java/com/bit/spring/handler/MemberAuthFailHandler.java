package com.bit.spring.handler;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Service
public class MemberAuthFailHandler implements AuthenticationFailureHandler {


    @Override
    public void onAuthenticationFailure(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {
        String loginFailMsg = null;

        if (e instanceof InternalAuthenticationServiceException) {
            loginFailMsg = "존재하지 않는 사용자입니다.";
//            System.out.println(loginFailMsg);
        } else if (e instanceof BadCredentialsException) {
            loginFailMsg = "\"아이디 또는 비밀번호가 틀립니다.\"";
//            System.out.println(loginFailMsg);
        }

        HttpSession session = httpServletRequest.getSession();
        session.setAttribute("loginFailMsg", loginFailMsg);
//        e.printStackTrace();
        httpServletResponse.sendRedirect("/member/logIn");

//        httpServletRequest.setAttribute("loginFailMsg",loginFailMsg);
//        httpServletRequest.getRequestDispatcher("/member/auth").forward(httpServletRequest,httpServletResponse);
    }
}