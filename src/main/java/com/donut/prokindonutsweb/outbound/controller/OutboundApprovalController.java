package com.donut.prokindonutsweb.outbound.controller;

import com.donut.prokindonutsweb.common.mapper.UserInfoMapper;
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

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/wm/outbound")
public class OutboundApprovalController {

    private final OutboundService outboundService;
    private final UserInfoMapper userInfoMapper;

    @GetMapping("/approval")
    public String getOutboundList(Model model, @AuthenticationPrincipal CustomUserDetails user) {

        String memberCode = user.getMemberCode();
        log.info(memberCode);
        String warehouseCode = outboundService.getWarehouseCode(memberCode);


        List<OutboundDTO> outboundList = outboundService.findApprovalOutboundList(warehouseCode);

        model.addAttribute("outboundList", outboundList);
        return "wm/outbound/approval";
    }

    @PostMapping("/approval")
    public String approveOutbound(@AuthenticationPrincipal CustomUserDetails user,@RequestParam("outboundCodeList") List<String> outboundCodeList, RedirectAttributes redirectAttributes) {
        String warehouseCode = userInfoMapper.getWarehouseCode(user.getMemberCode());

        List<String> successList = new ArrayList<>();
        List<String> failList = new ArrayList<>();
        List<String> noVehicleList = new ArrayList<>();

        for (String outboundCode : outboundCodeList) {
            try {
                // 1. 승인 처리
                boolean vehicleAssigned = outboundService.processOutbound(outboundCode, warehouseCode);
                if (vehicleAssigned) successList.add(outboundCode);
                else noVehicleList.add(outboundCode);
            } catch (Exception e) {
                log.info("출고 처리 중 오류 발생: {}", e.getMessage());
                failList.add(outboundCode);
            }
        }
        if (!successList.isEmpty()) redirectAttributes.addFlashAttribute("successMessage", successList.size() + "건 출고 완료했습니다.");
        if (!noVehicleList.isEmpty()) redirectAttributes.addFlashAttribute("vehicleFailMessage", noVehicleList.size() + "건 출고실패(배차 불가, 이미 처리중인 출고건 일 수 있으니 잠시 후 다시 시도해주세요. )");
        if (!failList.isEmpty()) redirectAttributes.addFlashAttribute("errorMessage", failList.size() + "건 출고 실패 (재고 부족 등)");

        return "redirect:/wm/outbound/approval";
    }

}