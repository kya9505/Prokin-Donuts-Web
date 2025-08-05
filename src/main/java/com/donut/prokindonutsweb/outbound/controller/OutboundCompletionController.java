package com.donut.prokindonutsweb.outbound.controller;

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
    @Transactional
    public String completionOutbound(@RequestParam("outboundCodeList") List<String> outboundCodeList,  @AuthenticationPrincipal CustomUserDetails user,RedirectAttributes redirectAttributes) {
        String memberCode = user.getMemberCode();
        log.info(memberCode);

        String warehouseCode = outboundService.getWarehouseCode(memberCode);

        for (String outboundCode : outboundCodeList) {
            log.info(outboundCode);
            //섹션 코드 생성
            String sectionCode = outboundService.getSectionCode(warehouseCode, outboundCode);
            log.info(sectionCode);
            //섹션코드 검증
            boolean check = outboundService.checkSectionCode(sectionCode);

            log.info(String.valueOf(check));

            // 섹션코드 존재하면 출고 완료처리후 섹션 용량 반영
            if (check) {
                // 상태 변경 ( -> 출고 완료)
                outboundService.completionOutbound(outboundCode);

                // 섹션반영
                int quantity = outboundService.getQuantity(outboundCode);
                outboundService.SectionUpdate(sectionCode, quantity);

                //발주상태변경
                outboundService.completionOrder(outboundCode);

                redirectAttributes.addFlashAttribute("errorMessage", "출고가 완료되었습니다.");

            } else {
                // 출고 완료 X 에러 메시지 반환
                redirectAttributes.addFlashAttribute("errorMessage", "섹션이 존재하지 않습니다.");
            }
        }
        return "redirect:/wm/outbound/completion";
    }
}
