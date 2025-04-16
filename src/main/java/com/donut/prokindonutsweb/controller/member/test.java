package com.donut.prokindonutsweb.controller.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class test {

    @GetMapping("/home/login")
    public void login(){}

    @GetMapping("/home/signup")
    public void signup(){}

    @GetMapping("/home/findId")
    public void findId(){}

    @GetMapping("/home/findPassword")
    public void findPassword(){}

    @GetMapping("/fm/order")
    public void Forder(){}

    @GetMapping("/wm/outbound")
    public void Woutbound(){}


    @GetMapping("/wm/inbound/status")
    public void Wstatus(){}


    @GetMapping("/wm/inbound/approval")
    public void Wapproval(){}

    @GetMapping("/wm/warehouse")
    public void Wwarehouse(){}

    @GetMapping("/wm/inbound/request")
    public void Wrequest(){}

    @GetMapping("/wm/member")
    public void Wmember(){}
    @GetMapping("/wm/Dashboard")
    public void WDashboard(){}



}
