package com.donut.prokindonutsweb.outbound.controller;

import com.donut.prokindonutsweb.outbound.dto.OutboundCompletionResult;
import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.service.OutboundService;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/wm/outbound")
public class OutboundCompletionController {

    private final OutboundService outboundService;

    @GetMapping("/completion")
    public String getCompletionOutboundList(Model model, @AuthenticationPrincipal CustomUserDetails user) {

        String memberCode = user.getMemberCode();
        log.info(memberCode);
        String warehouseCode = outboundService.getWarehouseCode(memberCode);


        List<OutboundDTO> outboundList = outboundService.findCompletionOutboundList(warehouseCode);

        model.addAttribute("outboundList", outboundList);
        return "wm/outbound/completion";
    }


    @PostMapping("/completion")
    public String completionOutbound(@RequestParam("outboundCodeList") List<String> outboundCodeList,  @AuthenticationPrincipal CustomUserDetails user,RedirectAttributes redirectAttributes) {

        String warehouseCode = outboundService.getWarehouseCode(user.getMemberCode());
        OutboundCompletionResult result = outboundService.processCompletion(outboundCodeList, warehouseCode);

        if (result.getSuccessCount() > 0) {
            redirectAttributes.addFlashAttribute("successMessage",
                    result.getSuccessCount() + "건 출고 완료, " + result.getFailCount() + "건 섹션 미존재");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "출고 처리에 실패했습니다. 섹션을 확인해주세요.");
        }
        return "redirect:/wm/outbound/completion";
    }
}
