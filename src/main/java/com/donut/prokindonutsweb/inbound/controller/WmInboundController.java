package com.donut.prokindonutsweb.inbound.controller;

import com.donut.prokindonutsweb.inbound.dto.*;
import com.donut.prokindonutsweb.inbound.exception.ErrorType;
import com.donut.prokindonutsweb.inbound.exception.UserException;
import com.donut.prokindonutsweb.inbound.service.InboundService;
import com.donut.prokindonutsweb.inbound.vo.InventoryVO;
import com.donut.prokindonutsweb.product.service.CategoryFilterService;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/wm/inbound")
public class WmInboundController {

    private final InboundService inboundService;

    private final CategoryFilterService categoryFilterService;

    /**
     * O
     * 입고 할 수 있는 제품 정보 리스트를 반환한다.
     * [제품 리스트가 존재 하지 않으면 예외 발생]
     * @param '제품리스트'
     */
    @GetMapping("/request")
    public void getProductList(Model model, @AuthenticationPrincipal CustomUserDetails user) {
        log.info(String.valueOf(user));
        List<ProductDTO> productList = inboundService.findProductList()
                .orElseThrow(() -> new UserException(ErrorType.PRODUCT_NOT_FOUND));
        List<String> categoryMidList = categoryFilterService.findCategoryMidList();

        model.addAttribute("categoryMidList", categoryMidList);
        model.addAttribute("product", productList);
    }

    /**
     * X 로그인 한 사용자 정보를 통해 창고 코드 입력하는 기능 구현 필요
     *
     * 입고 요청 정보를 저장한다.
     * 입고 정보 + 입고 상세 정보
     * @param '입고 날짜'
     * @param '입고 상세 리스트'
     * @return '입고요청 페이지'
     */
    @PostMapping("/request")
    public String addInbound(@RequestParam String inboundDate, InboundForm inboundForm,
                             @AuthenticationPrincipal CustomUserDetails user,
                             RedirectAttributes redirectAttributes,
                             BindingResult bindingResult) {
        log.info(String.valueOf(user));
        log.info("입고요청 호출");
        String memberCode = user.getMemberCode();
        String warehouseCode = inboundService.getWarehouseCode(memberCode);
        log.info(memberCode);
        log.info(warehouseCode);

        if(bindingResult.hasErrors()) {
            String error = bindingResult.getAllErrors().get(0).getDefaultMessage();
            redirectAttributes.addFlashAttribute("errorMessage", error);
            redirectAttributes.addFlashAttribute("InboundForm", inboundForm);
            redirectAttributes.addFlashAttribute("showModal", true);

            return "redirect:wm/inbound/request";
        }

        List<InboundDetailDTO> inboundDetailList = inboundForm.getProductList();

        // 입고요청 저장
        String inboundCode = inboundService.findNextInboundCode();
        InboundDTO dto = InboundDTO.builder()
                .inboundCode(inboundCode)
                .inboundDate(LocalDate.parse((inboundDate)))
                .inboundStatus(InboundStatus.REQUEST.getStatus())
                .warehouseCode(warehouseCode)   // 로그인 한 사용자 정보 가져와서 창고 코드 입력!
                .build();
        log.info(InboundStatus.REQUEST.getStatus());
        inboundService.addInbound(dto, inboundDetailList);
        redirectAttributes.addFlashAttribute("successMessage", "입고 요청이 완료되었습니다!");
        return "redirect:/wm/inbound/request";
    }

//    창고관리자 - 입고관리 페이지
    @GetMapping("/approval")
    public void getInboundList(Model model, @AuthenticationPrincipal CustomUserDetails user) {
       log.debug("현재 사용자 정보: {}", user.getMemberCode());

        String memberCode = user.getMemberCode();
        String warehouseCode = inboundService.getWarehouseCode(memberCode);
        log.info(memberCode);
        log.info(warehouseCode);

        List<InboundDTO> inboundList = inboundService.findInboundList(warehouseCode);
        List<InboundDetailDTO> inboundDetailList = inboundService.findInboundDetailList();
        model.addAttribute("inboundList", inboundList);
        model.addAttribute("inboundDetailList", inboundDetailList);
    }

    /**
     * 입고를 승인한다!
     * 입고상태 변경 (-> 입고완료)
     * 재고에 반영
     * @param inboundCode
     * @return
     */
    @PostMapping("/approve")
    public String approveInbound(@RequestParam String inboundCode, RedirectAttributes redirectAttributes) {
        // 입고 상태 ( -> 입고완료!)
        inboundService.approveInbound(inboundCode);
        log.info("입고상태 변경 완료!");

        // 입고상세 목록 재고에 반영

        List<InventoryDTO> inventoryList = inboundService.findInboundDetailList(inboundCode)
                .orElseThrow(()->new UserException(ErrorType.NOT_FOUND_INBOUND_DETAIL));
        log.info("입고상세 반영!");

        inboundService.updateInventory(inventoryList);

        // 재고에 반영안됨!

        redirectAttributes.addFlashAttribute("approveSuccessMessage", "입고가 완료되었습니다.");

        return "redirect:/wm/inbound/approval";
    }

    // 입고 수정
    @PostMapping("/edit")
    public String updateInbound(
            @ModelAttribute InboundUpdateWrapperDTO wrapper,
            @RequestParam("inboundDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inboundDate,
            RedirectAttributes redirectAttributes)
    {
        List<InboundUpdateDTO> list = wrapper.getItems();
        inboundService.updateInbound(list, inboundDate);
        redirectAttributes.addFlashAttribute("editSuccessMessage", "입고 수정이 완료되었습니다.");

        return "redirect:/wm/inbound/approval";
    }



    @PostMapping("/cancel")
    public String deleteInbound(@RequestParam String inboundCode, RedirectAttributes redirectAttributes) {
        inboundService.deleteInbound(inboundCode);
        redirectAttributes.addFlashAttribute("deleteSuccessMessage", "입고 취소가 완료되었습니다");
        return "redirect:/wm/inbound/approval";
    }

    // 입고현황

    @GetMapping("/status")
    public void getInboundStatusList(Model model, @AuthenticationPrincipal CustomUserDetails user) {

        String memberCode = user.getMemberCode();
        String warehouseCode = inboundService.getWarehouseCode(memberCode);

        List<InboundStatusDTO> inboundStatusList = inboundService.findWMInboundStatusList(warehouseCode)
                        .orElseThrow(() -> new UserException(ErrorType.NOT_FOUND_INBOUND_STATUS));
        model.addAttribute("inboundStatusList", inboundStatusList);
    }
}
