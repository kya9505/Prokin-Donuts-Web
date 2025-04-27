package com.donut.prokindonutsweb.dashboard.controller;

import com.donut.prokindonutsweb.dashboard.service.QhDashboardService;
import com.donut.prokindonutsweb.dashboard.dto.OrderInventoryDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
public class QhDashboardController{
    private final QhDashboardService qhDashboardService;

    @GetMapping("/qh/Dashboard")
    public void QDashboard(Model model){
        try {
            model.addAttribute("CountNewRequest",qhDashboardService.CountNewRequest());
            model.addAttribute("CountNewInbound",qhDashboardService.CountNewInbound());
            model.addAttribute("TotalFranchise",qhDashboardService.TotalFranchise());
            model.addAttribute("TotalWarehouse",qhDashboardService.TotalWarehouse());
        } catch (Exception e) {
            throw new RuntimeException("불러오기 실패");
        }
    }

    @GetMapping("/qh/order-vs-inventory")
    @ResponseBody
    public List<OrderInventoryDTO> getOrderRequestVsInventory() {
        return qhDashboardService.getOrderRequestVsInventory();
    }

}

