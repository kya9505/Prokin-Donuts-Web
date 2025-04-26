package com.donut.prokindonutsweb.outbound.controller;

import com.donut.prokindonutsweb.inbound.dto.InboundDTO;
import com.donut.prokindonutsweb.inbound.dto.InboundDetailDTO;
import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.dto.OutboundDetailDTO;
import com.donut.prokindonutsweb.outbound.service.OutboundService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
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
public class OutboundController {

    private final OutboundService outboundService;

    @GetMapping("/approval")
    public void getOutboundList(Model model) {


        /*String memberCode = user.getMemberCode();
        String warehouseCode = inboundService.getWarehouseCode(memberCode);
        log.info(memberCode);
        log.info(warehouseCode);*/

        List<OutboundDTO> outboundList = outboundService.findOutboundList("GG1");
        List<OutboundDetailDTO> outboundDetailList = outboundService.findOutboundDetailList();
        model.addAttribute("outboundList", outboundList);
        model.addAttribute("outboundDetailList", outboundDetailList);
    }

    @PostMapping("/approval")
    public String approveOutbound(@RequestParam String outboundCode, RedirectAttributes redirectAttributes) {
        log.info(outboundCode);

        // 재고 존재 확인
        boolean check = outboundService.checkInventory(outboundCode);
        log.info(String.valueOf(check));
        // 존재하면 출고 처리
        if(check) {
            // 상태 변경 ( -> 출고 완료)
            outboundService.approveOutbound(outboundCode);
            // 재고 반영
            outboundService.updateInventory(outboundCode);
            redirectAttributes.addFlashAttribute("errorMessage", "출고가 완료되었습니다.");

        } else {
            // 출고 X 에러 메시지 반환
            redirectAttributes.addFlashAttribute("errorMessage", "재고가 부족해 출고할 수 없습니다.");
        }


        return "redirect:/wm/outbound/approval";
    }
}
