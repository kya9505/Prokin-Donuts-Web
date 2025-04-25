package com.donut.prokindonutsweb.home.controller;

import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Log4j2
@Controller
public class HomeController {

    // 루트 요청 시 "/home/login"으로 리다이렉트
    @GetMapping("/")
    public String redirectToLogin() {
        return "redirect:/home/login";
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
