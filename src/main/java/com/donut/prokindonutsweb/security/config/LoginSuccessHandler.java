package com.donut.prokindonutsweb.security.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        //Authentication에서 권한 목록(Authorities) 가져오기 (UserDetails가 권한을 List로 관리)
            Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        //기본 경로(권한 없을 시)
            String redirectUrl ="/";
        //권한 별 메인 화면 으로 이동
            if(authorities.stream().anyMatch(a->a.getAuthority().equals("QH"))) redirectUrl = "/qh/Dashboard";
            else if (authorities.stream().anyMatch(a->a.getAuthority().equals("WM"))) redirectUrl ="wm/Dashboard";
            else if (authorities.stream().anyMatch(a->a.getAuthority().equals("FM"))) redirectUrl ="fm/order";

            response.sendRedirect(redirectUrl);

    }
}
