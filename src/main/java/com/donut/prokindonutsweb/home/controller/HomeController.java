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
        @GetMapping("/")
        public String redirectToLoginOrDashboard(Authentication authentication) {
            if (authentication != null && authentication.isAuthenticated()) {
                Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
                if (authorities.stream().anyMatch(a -> a.getAuthority().equals("QH"))) {
                    return "redirect:/qh/Dashboard";
                } else if (authorities.stream().anyMatch(a -> a.getAuthority().equals("WM"))) {
                    return "redirect:/wm/Dashboard";
                } else if (authorities.stream().anyMatch(a -> a.getAuthority().equals("FM"))) {
                    return "redirect:/fm/order";
                }
            }
            return "home/login";
        }



    //개발 안된 페이지
    @GetMapping("/wm/outbound")
    public void Woutbound(){}

    @GetMapping("/wm/Dashboard")
    public void WDashboard(){}

    @GetMapping("/qh/Dashboard")
    public void QDashboard(){
    }
  
    @GetMapping("/qh/outbound")
    public void Qoutbound(){}

}
