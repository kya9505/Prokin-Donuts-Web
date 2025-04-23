package com.donut.prokindonutsweb.config;

import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class CurrentUserAdvice {

    /**
     * 모든 컨트롤러가 실행될 때마다,
     * model에 "user"라는 이름으로 현재 로그인 정보를 담아줍니다.
     */
    @ModelAttribute("user")
    public CustomUserDetails currentUser(
            @AuthenticationPrincipal CustomUserDetails user
    ) {
        return user;
    }
}
