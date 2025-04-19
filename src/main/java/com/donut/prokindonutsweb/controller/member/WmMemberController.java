package com.donut.prokindonutsweb.controller.member;

import com.donut.prokindonutsweb.dto.member.MemberAccountDTO;
import com.donut.prokindonutsweb.service.member.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Collections;
import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/wm/member")
public class WmMemberController {
    private final MemberService memberService;

    @GetMapping
    public void wmGetMember( Model model){
        List<MemberAccountDTO> wmMemberList = memberService.findMember().orElse(Collections.emptyList());
        model.addAttribute("wmMemberList",wmMemberList);
    }


}
