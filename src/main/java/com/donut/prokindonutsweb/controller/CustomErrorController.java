package com.donut.prokindonutsweb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/error")
public class CustomErrorController {
    @GetMapping("/404")
    public String error404(Model model) {
        model.addAttribute("statusCode", 404);
        model.addAttribute("message", "페이지를 찾을 수 없습니다.");
        return "error/404"; // -> /WEB-INF/views/error/404.jsp
    }

    @GetMapping("/500")
    public String error500(Model model) {
        model.addAttribute("statusCode", 500);
        model.addAttribute("message", "서버 오류가 발생했습니다.");
        return "error/500";
    }

    @RequestMapping("/default")
    public String defaultError(HttpServletRequest request, Model model) {
        model.addAttribute("statusCode", request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE));
        model.addAttribute("message", "알 수 없는 오류입니다.");
        return "error/default";
    }
}
