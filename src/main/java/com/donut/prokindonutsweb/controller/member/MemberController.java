package com.donut.prokindonutsweb.controller.member;

import com.donut.prokindonutsweb.dto.member.MemberAccountDTO;
import com.donut.prokindonutsweb.service.member.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;

import javax.validation.Valid;
import java.util.Collections;
import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;

    @GetMapping("/wm/member")
    public void wmGetMember( Model model){
        List<MemberAccountDTO> wmMemberList = memberService.findMember().orElse(Collections.emptyList());
        model.addAttribute("wmMemberList",wmMemberList);
    }

    @GetMapping("/qh/member/list")
    public void qhGetMemberList(Model model){
        List<MemberAccountDTO> qhMemberList = memberService.findMember().orElse(Collections.emptyList());
        model.addAttribute("qhMemberList",qhMemberList);
    }
}
