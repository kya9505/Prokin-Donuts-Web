package com.donut.prokindonutsweb.dashboard.controller;

import com.donut.prokindonutsweb.dashboard.dto.OrderInboundDTO;
import com.donut.prokindonutsweb.dashboard.dto.OrderInboundRateDTO;
import com.donut.prokindonutsweb.dashboard.service.QhDashboardService;
import com.donut.prokindonutsweb.dashboard.dto.OrderInventoryDTO;
import com.donut.prokindonutsweb.inventory.service.QhInventoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
public class QhDashboardController{
    private final QhDashboardService qhDashboardService;
    private final QhInventoryService qhInventoryService;


    @GetMapping("/qh/Dashboard")
    public void QDashboard(Model model, @ModelAttribute("warehouseCode") String warehouseCode){
     model.addAttribute("CountNewRequest",qhDashboardService.countNewRequest());
            model.addAttribute("CountNewInbound",qhDashboardService.countNewInbound());
            model.addAttribute("TotalFranchise",qhDashboardService.totalFranchise());
            model.addAttribute("TotalWarehouse",qhDashboardService.totalWarehouse());
            model.addAttribute("warehouseList",qhInventoryService.findWarehouseList());
    }

    //최근 한달 발주량 대비 재고량
    @GetMapping("/qh/order-vs-inventory")
    @ResponseBody
    public List<OrderInventoryDTO> getOrderRequestVsInventory() {
        return qhDashboardService.getOrderRequestVsInventory();
    }

    // 창고 코드별 입고/출고 승인율 데이터 리턴
    @GetMapping("/qh/inbound-order-rate")
    @ResponseBody
    public OrderInboundRateDTO getOrderInboundRate(@RequestParam("warehouse") String warehouse) {
        //창고 명을 코드로 변환
        String warehouseCode = qhDashboardService.getWarehouseCode(warehouse);
        //입출고 객체에 저장
        OrderInboundDTO dto = qhDashboardService.getOrderInbound(warehouseCode);
        //입출고 진행량 객체 반환
        return new OrderInboundRateDTO(
                (int)Math.round(dto.inboundApprovalRate() * 100),
                (int)Math.round(dto.orderedRate() * 100));
    }

}

