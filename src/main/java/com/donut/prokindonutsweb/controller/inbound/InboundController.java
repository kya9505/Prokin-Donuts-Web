package com.donut.prokindonutsweb.controller.inbound;

import com.donut.prokindonutsweb.dto.inbound.ProductDTO;
import com.donut.prokindonutsweb.service.inbound.InboundService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
