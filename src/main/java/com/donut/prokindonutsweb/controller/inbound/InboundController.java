package com.donut.prokindonutsweb.controller.inbound;

import com.donut.prokindonutsweb.dto.inbound.InboundDTO;
import com.donut.prokindonutsweb.dto.inbound.InboundDetailDTO;
import com.donut.prokindonutsweb.dto.inbound.InboundForm;
import com.donut.prokindonutsweb.dto.inbound.ProductDTO;
import com.donut.prokindonutsweb.service.inbound.InboundService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/wm/inbound")
public class InboundController {

    private final InboundService inboundService;
    @GetMapping("/request")
    public void productList(Model model) {
        List<ProductDTO> list = inboundService.findAllProductList().orElseThrow();
        model.addAttribute("product", list);
        log.info(list.toString());
    }

    @PostMapping("/request")
    public String request(@RequestParam String inboundDate,
                          @ModelAttribute InboundForm inboundForm) {
        List<InboundDetailDTO> list = inboundForm.getProductList();

        // 입고요청 저장
        String inboundCode = inboundService.findNextInboundCode();
        InboundDTO dto = InboundDTO.builder()
                .inboundCode(inboundCode)
                .inboundDate(Date.valueOf(inboundDate))
                .inboundStatus("입고요청")
                .warehouseCode("GG1")
                .build();
        inboundService.saveInbound(dto);
        // 입고상세 저장 (service 단에서 VO 만들어서 반환)
        inboundService.saveInboundDetail(list);


        /*System.out.println(inboundDate);
        System.out.println(list.toString());*/

        return "redirect:/wm/inbound/request";
    }

//    창고관리자 - 입고관리 페이지
    @GetMapping("/manage")
    public void wmGetAllInboundList(Model model) {
        List<InboundDTO> inboundList = inboundService.findAllInboundList().get();
        List<InboundDetailDTO> inboundDetailList = inboundService.findAllInboundDetailList().get();
        model.addAttribute("inboundList", inboundList);
        model.addAttribute("inboundDetailList", inboundDetailList);
    }
}
