package com.donut.prokindonutsweb.home.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {


    @GetMapping("/fm/order")
    public void Forder(){}

    @GetMapping("/wm/outbound")
    public void Woutbound(){}
  
   /* @GetMapping("/wm/inbound/request")
    public void Wrequest(){}*/
    @GetMapping("/wm/Dashboard")
    public void WDashboard(){}

    @GetMapping("/qh/Dashboard")
    public void QDashboard(){}
  
    @GetMapping("/qh/outbound")
    public void Qoutbound(){}

    @GetMapping("/qh/product")
    public void Qproduct(){}

}
