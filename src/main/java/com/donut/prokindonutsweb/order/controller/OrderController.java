package com.donut.prokindonutsweb.order.controller;


import com.donut.prokindonutsweb.common.EmailUtil;
import com.donut.prokindonutsweb.inbound.dto.ProductDTO;
import com.donut.prokindonutsweb.inbound.service.InboundService;
import com.donut.prokindonutsweb.inbound.exception.ErrorType;
import com.donut.prokindonutsweb.inbound.exception.UserException;
import com.donut.prokindonutsweb.order.dto.OrderDTO;
import com.donut.prokindonutsweb.order.dto.OrderDetailDTO;
import com.donut.prokindonutsweb.order.dto.OrderForm;
import com.donut.prokindonutsweb.order.dto.OrderStatus;
import com.donut.prokindonutsweb.order.service.OrderService;
import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.service.OutboundService;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/fm")
public class OrderController {

    private final EmailUtil emailUtil;
    private final JavaMailSender javaMailSender;
    private final InboundService inboundService;
    private final OrderService orderService;

    // 발주 요청에 필요한 제품 목록 출력
    @GetMapping("/order")
    public void getProductList(Model model) {
        List<ProductDTO> productList = inboundService.findProductList()
                .orElseThrow(() -> new UserException(ErrorType.PRODUCT_NOT_FOUND));
        model.addAttribute("product", productList);
    }

    //발주요청
    @PostMapping("/order")
    @Transactional
    public String addOrder(@RequestParam String orderDate, OrderForm orderForm,
                           RedirectAttributes redirectAttributes,
                           BindingResult bindingResult, @AuthenticationPrincipal CustomUserDetails user) {
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

        String memberCode = user.getMemberCode();


        try {
            //가맹점 코드 조회
            String franchiseCode = orderService.findFranchiseCode(memberCode);

            //인근 창고코드 조회
            String warehouseCode = orderService.findWarehouseCodeToFranchise(franchiseCode);

            if (warehouseCode == null || warehouseCode.isBlank()) {
                log.info("해당 가맹점({})에 연결된 창고코드를 찾을 수 없습니다.", franchiseCode);
                redirectAttributes.addFlashAttribute("errorMessage", "인근 창고가 존재하지 않습니다. 본사에 문의해주세요.");
                throw new IllegalStateException("창고코드 없음: " + franchiseCode);
            }

            // 발주 생성
            String orderCode = orderService.findNextOrderCode();

            OrderDTO dto = OrderDTO.builder()
                    .orderCode(orderCode)
                    .orderDate(LocalDate.parse((orderDate)))
                    .franchiseCode(franchiseCode)
                    .build();
            log.info("orderDto : {} ",dto);

            // 발주상세 코드 생성
            List<OrderDetailDTO> orderDetailList = Optional.ofNullable(orderForm.getProductList())
                    .orElseThrow(() -> new IllegalArgumentException("발주 상품이 없습니다."));
            AtomicInteger i = new AtomicInteger(1);

            orderDetailList.forEach(orderDetailDto -> {
                orderDetailDto.setOrderCode(orderCode);
                orderDetailDto.setOrderDetailCode(orderCode + "-" + i.getAndIncrement());
                orderDetailDto.setOrderStatus("배송준비");
            });
            orderDetailList.forEach(orderDetail -> log.info("orderDetail : {}", orderDetail));

            //발주 & 발주상세 저장
            orderService.addOrder(dto, orderDetailList, franchiseCode);

            //출고 저장 생성
            orderService.addOutbound(warehouseCode,dto,orderDetailList);

            //메일발송
            emailUtil.sendDeliveryStatusEmail(javaMailSender,memberCode,"배송준비" );


            redirectAttributes.addFlashAttribute("successMessage", "발주 요청이 완료되었습니다!");
        } catch (Exception e) {
            log.info("발주 요청 중 예외 발생", e);
            redirectAttributes.addFlashAttribute("errorMessage", "발주 요청중 문제가 발생했습니다. 다시시도해주세요. ");
            //예외시에도 모달 내용 유지
            redirectAttributes.addFlashAttribute("orderForm", orderForm);
            redirectAttributes.addFlashAttribute("showModal", true);
        }

        return "redirect:/fm/order";
    }
}
