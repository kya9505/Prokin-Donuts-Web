package com.donut.prokindonutsweb.home.controller;

import com.donut.prokindonutsweb.home.service.SignupService;
import com.donut.prokindonutsweb.member.dto.MemberRequestDTO;
import com.donut.prokindonutsweb.member.service.MemberRequestService;
import com.donut.prokindonutsweb.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/home")
public class SignupController {
    private final SignupService signupService;
    private final MemberService memberService;
    private final MemberRequestService requestService;

    @GetMapping("/signup")
    public  void signup(Model model){
    }

    @PostMapping("/signup")
    public String signup(@Valid @ModelAttribute("memberRequestDTO")MemberRequestDTO memberRequestDTO,
                         BindingResult bindingResult,
                         RedirectAttributes redirectAttributes){
// 유효성 검사 실패 시, 첫 번째 에러 메시지와 입력 값을 플래시 속성으로 전달하고 목록 페이지로 리다이렉트
        if (bindingResult.hasErrors()) {
            String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
            redirectAttributes.addFlashAttribute("errorMessage", errorMessage);
            redirectAttributes.addFlashAttribute("memberRequestDTO", memberRequestDTO);
            return "redirect:signup";
        }
        signupService.saveMemberRequset(memberRequestDTO);

        return "redirect:login";
    }

    @GetMapping(value ="/idCheck",  produces = "text/plain")
    @ResponseBody
    public String checkId(@RequestParam("id") String id){
        int check = memberService.memberIdCheck(id) + requestService.requestIdCheck(id);
        return check > 0 ? "true" : "false";
    }

    @GetMapping(value ="/emailCheck",  produces = "text/plain")
    @ResponseBody
    public String checkEmail(@RequestParam("email") String email){
        int Check = memberService.memberEmailCheck(email) + requestService.requestEmailCheck(email) ;
        return Check > 0 ? "true" : "false";
    }


}
