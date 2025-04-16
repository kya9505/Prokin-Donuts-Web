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
    public void order(){}

    @GetMapping("/wm/outbound")
    public void outbound(){}


    @GetMapping("/wm/inbound/status")
    public void status(){}


}
