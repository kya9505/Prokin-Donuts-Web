package com.donut.prokindonutsweb.home.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {


    // 루트 요청 시 "/home/login"으로 리다이렉트
    @GetMapping("/")
    public String redirectToLogin() {
        return "redirect:/home/login";
    }

    @GetMapping("/fm/order")
    public void Forder(){}

    @GetMapping("/wm/outbound")
    public void Woutbound(){}
  
   /* @GetMapping("/wm/inbound/request")
    public void Wrequest(){}*/
   @GetMapping("/wm/Dashboard")
   public void WDashboard() {
   }
    @GetMapping("/qh/Dashboard")
    public void QDashboard(){}
  
    @GetMapping("/qh/outbound")
    public void Qoutbound(){}

}
