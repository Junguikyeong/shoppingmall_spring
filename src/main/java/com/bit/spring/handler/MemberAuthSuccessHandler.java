package com.bit.spring.handler;

import com.bit.spring.model.MemberCustomDetails;
import com.bit.spring.model.MemberDTO;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Service
public class MemberAuthSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {
        MemberDTO memberDTO = ((MemberCustomDetails) authentication.getPrincipal()).getMemberDTO();
        memberDTO.setPassword(null);

        HttpSession session = httpServletRequest.getSession();
        session.setAttribute("logIn", memberDTO);

//        System.out.println(memberDTO);
//        System.out.println("로그인성공!");
        // 바꿀 예정
        httpServletResponse.sendRedirect("/");
    }
}
