package com.donut.prokindonutsweb.home.controller;

import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Collection;

@Log4j2
@Controller
public class HomeController {

        // 루트화면 요청 시 권한 확인 후 로그인/권한별 화면으로 이동
        // 루트 요청 시 index.jsp로 이동
        @GetMapping("/")
        public String index() {
            return "index"; // => /WEB-INF/views/index.jsp
        }

    // 로그인 페이지
    @GetMapping("/login")
    public String login() {
        return "home/login"; // => /WEB-INF/views/home/login.jsp
    }



    //개발 안된 페이지
    @GetMapping("/wm/outbound")
    public void Woutbound(){}

    @GetMapping("/qh/outbound")
    public void Qoutbound(){}

}
