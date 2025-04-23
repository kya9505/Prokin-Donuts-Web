package com.donut.prokindonutsweb.inbound.controller;

import com.donut.prokindonutsweb.inbound.dto.InboundDTO;
import com.donut.prokindonutsweb.inbound.dto.InboundDetailDTO;
import com.donut.prokindonutsweb.inbound.dto.InboundStatusDTO;
import com.donut.prokindonutsweb.inbound.service.InboundService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/qh/inbound")
public class QhInboundController {

    private final InboundService inboundService;
    // 본사관리자 입고현황
    @GetMapping("/status")
    public void getInboundStatus(Model model) {
        List<InboundStatusDTO> inboundStatusList = inboundService.findInboundStatusList().get();
        model.addAttribute("inboundStatusList", inboundStatusList);
    }

    // 본사관리자 입고요청에 대한 승인 페이지 (입고관리)
    /*
        모든 창고의 입고요청을 보여준다.
     */
    @GetMapping("/request")
    public void getInboundList(Model model) {
        List<InboundDTO> inboundList = inboundService.findQhInboundList().get();
        List<InboundDetailDTO> inboundDetailList = inboundService.findInboundDetailList();
        model.addAttribute("inboundList", inboundList);
        model.addAttribute("inboundDetailList", inboundDetailList);
    }

    // 입고요청에 대한 승인 완료 (본사관리자)
    @PostMapping("/request/approve")
    public String approveInbound(@RequestParam String inboundCode) {
        inboundService.updateInboundStatus(inboundCode);
        return "redirect:/qh/inbound/request";
    }


}
