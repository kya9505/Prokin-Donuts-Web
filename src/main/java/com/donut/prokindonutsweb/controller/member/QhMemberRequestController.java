package com.donut.prokindonutsweb.controller.member;

import com.donut.prokindonutsweb.dto.member.MemberRequestDTO;
import com.donut.prokindonutsweb.dto.member.RequestCodeListForm;
import com.donut.prokindonutsweb.service.member.MemberRequestService;
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
@RequestMapping("/qh/member")
public class QhMemberRequestController {
    private final MemberRequestService requestService;

    @GetMapping("/request")
    public void qhGetMemberRequestList(Model model){
        List<MemberRequestDTO> requestList = requestService.findRequestMember().orElse(Collections.emptyList());
        model.addAttribute("requestList",requestList);
    }

    @GetMapping("/approval")
    public String qhApprovalMemberRequests(RequestCodeListForm requestCode){
        requestService.approvalMember(requestCode.getRequestList());
        return "";
    }
}
