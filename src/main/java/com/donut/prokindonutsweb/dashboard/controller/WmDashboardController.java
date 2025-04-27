package com.donut.prokindonutsweb.dashboard.controller;

import com.donut.prokindonutsweb.dashboard.dto.CountStatDTO;
import com.donut.prokindonutsweb.dashboard.dto.InventoryStatisticDTO;
import com.donut.prokindonutsweb.dashboard.dto.SectionUsageDTO;
import com.donut.prokindonutsweb.dashboard.service.WmDashboardService;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Map;

@Log4j2
@Controller
@RequiredArgsConstructor
@RequestMapping("/wm/Dashboard")
public class WmDashboardController {

  private final WmDashboardService wmDashboardService;

  // 메인 대시보드 화면 (창고코드 조회 + 기타 통계 조회용)
  @GetMapping
  public void wmGetDashboardStatus(Model model, @AuthenticationPrincipal CustomUserDetails user) {
    log.info("Controller : wmGetDashboardStatus called");
    
    String memberCode = user.getMemberCode();
    log.info("memberCode: {}", memberCode);
    
    List<String> warehouseCodes = wmDashboardService.findWarehouseCodesByMember(memberCode);
    log.info("memberCode: {}, warehouseCodes: {}", memberCode, warehouseCodes);
    
    if (!warehouseCodes.isEmpty()) {
      String warehouseCode = warehouseCodes.get(0); // 첫 번째 창고코드 사용
      
      // 입고 데이터
      List<CountStatDTO> inboundYearData = wmDashboardService.findInboundCountByYear(warehouseCode);
      List<CountStatDTO> inboundMonthData = wmDashboardService.findInboundCountByMonth(
          Map.of("year", 2025, "warehouseCode", warehouseCode)
      );
      List<CountStatDTO> inboundWeekData = wmDashboardService.findInboundCountByWeek(
          Map.of("year", 2025, "warehouseCode", warehouseCode)
      );
      log.info("Inbound Data - Year: {}, Month: {}, Week: {}", inboundYearData, inboundMonthData, inboundWeekData);
      
      // 출고 데이터
      List<CountStatDTO> orderYearData = wmDashboardService.findOrderCountByYear(warehouseCode);
      List<CountStatDTO> orderMonthData = wmDashboardService.findOrderCountByMonth(
          Map.of("year", 2025, "warehouseCode", warehouseCode)
      );
      List<CountStatDTO> orderWeekData = wmDashboardService.findOrderCountByWeek(
          Map.of("year", 2025, "warehouseCode", warehouseCode)
      );
      log.info("Order Data - Year: {}, Month: {}, Week: {}", orderYearData, orderMonthData, orderWeekData);
      
      // 재고 데이터
      Integer totalInventoryPrice = Math.toIntExact(wmDashboardService.findTotalInventoryPrice(warehouseCode));
      List<InventoryStatisticDTO> productInventoryList = wmDashboardService.findProductInventoryByWarehouse(warehouseCode);
      List<InventoryStatisticDTO> categoryInventoryList = wmDashboardService.findCategoryInventoryByWarehouse(warehouseCode);
      List<SectionUsageDTO> sectionUsageList = wmDashboardService.findSectionUsageRateByWarehouse(warehouseCode);
      log.info("Inventory - TotalPrice: {}, ProductList: {}, CategoryList: {}, SectionUsage: {}",
          totalInventoryPrice, productInventoryList, categoryInventoryList, sectionUsageList);
      
      // 오늘 미승인 입고요청/출고요청 수
      int todayWaitingInboundCount = wmDashboardService.findTodayWaitingInboundCount(warehouseCode);
      int todayWaitingOrderCount = wmDashboardService.findTodayWaitingOrderCount(warehouseCode);
      log.info("Today's Waiting - Inbound: {}, Order: {}", todayWaitingInboundCount, todayWaitingOrderCount);
      
      // 모델에 추가
      model.addAttribute("inboundYearData", inboundYearData);
      model.addAttribute("inboundMonthData", inboundMonthData);
      model.addAttribute("inboundWeekData", inboundWeekData);
      
      model.addAttribute("orderYearData", orderYearData);
      model.addAttribute("orderMonthData", orderMonthData);
      model.addAttribute("orderWeekData", orderWeekData);
      
      model.addAttribute("totalInventoryPrice", totalInventoryPrice);
      model.addAttribute("productInventoryList", productInventoryList);
      model.addAttribute("categoryInventoryList", categoryInventoryList);
      model.addAttribute("sectionUsageList", sectionUsageList);
      
      model.addAttribute("todayWaitingInboundCount", todayWaitingInboundCount);
      model.addAttribute("todayWaitingOrderCount", todayWaitingOrderCount);
    } else {
      log.warn("No warehouseCode found for member: {}", memberCode);
    }
  }
}