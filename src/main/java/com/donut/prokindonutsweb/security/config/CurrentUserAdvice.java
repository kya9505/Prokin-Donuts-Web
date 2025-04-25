package com.donut.prokindonutsweb.security.config;

import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
@Log4j2

/**
 * 모든 컨트롤러가 실행될 때마다,
 * model에 "member"라는 이름으로 현재 로그인 정보를 담아줍니다.
 */
public class CurrentUserAdvice {

    //jsp에서 'member'로 attribute
    @ModelAttribute("member")
    public MemberAccountVO currentUser(@AuthenticationPrincipal CustomUserDetails user) {
        return (user != null) ? user.getMember() : null;
    }
}

