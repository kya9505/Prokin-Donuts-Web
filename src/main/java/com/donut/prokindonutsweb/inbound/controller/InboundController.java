package com.donut.prokindonutsweb.inbound.controller;

import com.donut.prokindonutsweb.inbound.dto.*;
import com.donut.prokindonutsweb.inbound.service.InboundService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/wm/inbound")
public class InboundController {

    private final InboundService inboundService;

    /**
     * 입고 할 수 있는 제품 정보 리스트를 반환한다.
     * @param '제품리스트'
     */
    @GetMapping("/request")
    public void getProductList(Model model) {
        List<ProductDTO> productList = inboundService.findAllProductList().orElseThrow();
        model.addAttribute("product", productList);
    }

    /**
     * 입고 요청 정보를 저장한다.
     * 입고 정보 + 입고 상세 정보
     * @param '입고 날짜'
     * @param '입고 상세 리스트'
     * @return '입고요청 페이지'
     */
    @PostMapping("/request")
    public String addInbound(@RequestParam String inboundDate,
                             @ModelAttribute InboundForm inboundForm) {
        List<InboundDetailDTO> inboundDetailList = inboundForm.getProductList();

        // 입고요청 저장
        String inboundCode = inboundService.findNextInboundCode();
        InboundDTO dto = InboundDTO.builder()
                .inboundCode(inboundCode)
                .inboundDate(LocalDate.parse((inboundDate)))
                .inboundStatus(InboundStatus.REQUEST.getStatus())
                .warehouseCode("GG1")
                .build();
        inboundService.saveInbound(dto);
        // 입고상세 저장 (service 단에서 VO 만들어서 반환)
        inboundService.saveInboundDetail(inboundDetailList);


        /*System.out.println(inboundDate);
        System.out.println(list.toString());*/

        return "redirect:/wm/inbound/request";
    }

//    창고관리자 - 입고관리 페이지
    @GetMapping("/approval")
    public void wmGetAllInboundList(Model model) {
        List<InboundDTO> inboundList = inboundService.findAllInboundList().get();
        List<InboundDetailDTO> inboundDetailList = inboundService.findAllInboundDetailList().get();
        model.addAttribute("inboundList", inboundList);
        model.addAttribute("inboundDetailList", inboundDetailList);
    }


    @PostMapping("/approve")
    public String wmApproveInbound(@RequestParam String inboundCode) {
        log.info(inboundCode);
        // 입고 상태 ( -> 입고완료!)
        inboundService.approveInbound(inboundCode);

        // 입고상세 목록 재고에 반영
        List<InventoryDTO> inventoryList = inboundService.findInboundDetailList(inboundCode).get();
        inventoryList.stream().forEach(
                dto -> {
                    InventoryVO vo = InventoryVO.builder()
                            .inventoryCode(dto.getWarehouseCode()+"-"+dto.getProductCode())
                            .quantity(dto.getQuantity())
                            .productCode(dto.getProductCode())
                            .warehouseCode(dto.getWarehouseCode())
                            .build();
                    inboundService.updateInventory(vo);
                }
        );

        return "redirect:/wm/inbound/approval";
    }

    // 입고 수정
    @PostMapping("/edit")
    public String updateInbound(
            @ModelAttribute InboundUpdateWrapperDTO wrapper,
            @RequestParam("inboundDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate inboundDate
    ) {
        List<InboundUpdateDTO> list = wrapper.getItems();
        inboundService.updateInbound(list, inboundDate);

        return "redirect:/wm/inbound/approval";
    }



    @PostMapping("/cancel")
    public String deleteInbound(@RequestParam String inboundCode) {
        inboundService.deleteInbound(inboundCode);

        return "redirect:/wm/inbound/approval";
    }

    // 입고현황

    @GetMapping("/status")
    public void wmGetAllInboundStatus(Model model) {
        List<InboundStatusDTO> inboundStatusList = inboundService.findAllInboundStatusList().get();
        model.addAttribute("inboundStatusList", inboundStatusList);
    }
}
