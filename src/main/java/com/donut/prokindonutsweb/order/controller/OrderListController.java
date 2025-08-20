package com.donut.prokindonutsweb.order.controller;

import com.donut.prokindonutsweb.order.dto.OrderDTO;
import com.donut.prokindonutsweb.order.dto.OrderDetailDTO;
import com.donut.prokindonutsweb.order.service.OrderService;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/fm")
public class OrderListController {

    private final OrderService orderService;


    @GetMapping("/list")
    public String getOrderList(Model model, @AuthenticationPrincipal CustomUserDetails user) {
        log.info("getOrderList() called");

        String memberCode = user.getMemberCode();
        log.info("memberCode: {}", memberCode);
        String franchiseCode = orderService.findFranchiseCode(memberCode);
        log.info("franchiseCode: {}",franchiseCode);

        List<OrderDTO> orderList = orderService.findOrderList(franchiseCode);
        model.addAttribute("orderList", orderList);

        return "/fm/list";
    }

    @GetMapping("/list/detail")
    @ResponseBody
    public List<OrderDetailDTO> getOrderDetailList(@RequestParam("orderCode") String orderCode) {
        log.info("orderCode: {}", orderCode);
        return orderService.findOrderDetailList(orderCode);
    }

}
