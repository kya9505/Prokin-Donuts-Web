package com.donut.prokindonutsweb.member.controller;

import com.donut.prokindonutsweb.member.dto.MemberRequestDTO;
import com.donut.prokindonutsweb.member.dto.RequestCodeListForm;
import com.donut.prokindonutsweb.member.service.MemberRequestService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Collections;
import java.util.List;
@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/qh/member")
public class QhMemberRequestController {
    private final MemberRequestService requestService;

    @GetMapping("/request")
    public void qhGetMemberRequestList(Model model){
        List<MemberRequestDTO> requestList = requestService.findRequestMember().orElse(Collections.emptyList());
        model.addAttribute("requestList",requestList);
    }

    @PostMapping("/approval")
    public String qhApprovalMemberRequests(RequestCodeListForm requestCodeList){
        requestService.approvalMember(requestCodeList.getRequestCodeList());
        return "redirect:request";
    }
}
