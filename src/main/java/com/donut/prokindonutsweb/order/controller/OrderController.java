package com.donut.prokindonutsweb.order.controller;


import com.donut.prokindonutsweb.inbound.dto.ProductDTO;
import com.donut.prokindonutsweb.inbound.service.InboundService;
import com.donut.prokindonutsweb.inbound.exception.ErrorType;
import com.donut.prokindonutsweb.inbound.exception.UserException;
import com.donut.prokindonutsweb.order.dto.OrderForm;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/fm")
public class OrderController {

    private final InboundService inboundService;

    // 발주 요청에 필요한 제품 목록 출력
    @GetMapping("/order")
    public void getProductList(Model model) {
        List<ProductDTO> productList = inboundService.findProductList()
                .orElseThrow(() -> new UserException(ErrorType.PRODUCT_NOT_FOUND)); // 추후 수정 필요
        model.addAttribute("product", productList);
    }

    @PostMapping("/order")
    public String addOrder(@RequestParam String orderDate, OrderForm orderForm,
                           RedirectAttributes redirectAttributes,
                           BindingResult bindingResult) {
        log.info("발주요청 호출");
        if(bindingResult.hasErrors()) {
            String error = bindingResult.getAllErrors().get(0).getDefaultMessage();
            redirectAttributes.addFlashAttribute("errorMessage", error);
            redirectAttributes.addFlashAttribute("orderForm", orderForm);
            redirectAttributes.addFlashAttribute("showModal", true);

            return "redirect:/fm/order";
        }
        log.info(orderDate);
        log.info(orderForm.toString());

        /*List<InboundDetailDTO> orderDetailList = orderForm.getProductList();

        // 발주 요청 저장
        String orderCode = orderService.findNextOrderCode();
        orderDTO dto = orderDTO.builder()
                .orderCode(orderCode)
                .orderDate(LocalDate.parse((orderDate)))
                .orderStatus(orderStatus.REQUEST.getStatus())
                .warehouseCode("GG1")   // 로그인 한 사용자 정보 가져와서 창고 코드 입력!
                .build();
        log.info(orderStatus.REQUEST.getStatus());
        orderService.addorder(dto, orderDetailList);
        redirectAttributes.addFlashAttribute("successMessage", "발주 요청이 완료되었습니다!");*/


        return "redirect:/fm/order";
    }
}
