package com.donut.prokindonutsweb.outbound.controller;

import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.service.OutboundService;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/wm/outbound")
public class OutboundStatusController {

    private final OutboundService outboundService;

    @GetMapping("/status")
    public String getOutboundList(Model model, @AuthenticationPrincipal CustomUserDetails user) {
        log.info("check");

        String memberCode = user.getMemberCode();
        log.info(memberCode);
        String warehouseCode = outboundService.getWarehouseCode(memberCode);


        List<OutboundDTO> outboundList = outboundService.findOutboundList(warehouseCode);

        model.addAttribute("outboundList", outboundList);
        return "wm/outbound/status";
    }
}