package com.donut.prokindonutsweb.security.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;
// 로그인 성공 후 추가 작업을 처리하는 핸들러 (Spring Security 기본 성공 핸들러 상속)
public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    // 로그인 성공 시 호출되는 메서드
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        // 로그인한 사용자의 권한(Authority) 목록
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        // 권한에 따라 이동할 기본 URL을 설정
        if (authorities.stream().anyMatch(a -> a.getAuthority().equals("QH"))) {
            setDefaultTargetUrl("/qh/Dashboard");
        } else if (authorities.stream().anyMatch(a -> a.getAuthority().equals("WM"))) {
            setDefaultTargetUrl("/wm/Dashboard");
        } else if (authorities.stream().anyMatch(a -> a.getAuthority().equals("FM"))) {
            setDefaultTargetUrl("/fm/order");
        } else {
            // 권한이 없는 경우 메인 홈("/")으로 이동
            setDefaultTargetUrl("/");
        }


        // super 호출! (remember-me 쿠키 발급 + 리다이렉트 처리)
        super.onAuthenticationSuccess(request, response, authentication);

    }
}
