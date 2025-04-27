package com.donut.prokindonutsweb.dashboard.service;

import com.donut.prokindonutsweb.dashboard.dto.CountStatDTO;
import com.donut.prokindonutsweb.dashboard.dto.InventoryStatisticDTO;
import com.donut.prokindonutsweb.dashboard.dto.SectionUsageDTO;

import java.util.List;
import java.util.Map;

public interface WmDashboardService {
  // ─── 창고 코드 조회 ─────────────────────
  List<String> findWarehouseCodesByMember(String memberCode);

  // ─── 섹션 온도 조회/수정 ─────────────────
  int findSectionTemperature(Map<String, Object> paramMap);
  int updateSectionTemperature(Map<String, Object> paramMap);
  
  // ─── 오늘 미승인 입고요청/출고요청 수 ──────
  int findTodayWaitingInboundCount(String warehouseCode);
  int findTodayWaitingOrderCount(String warehouseCode);

  // ─── Inbound 건수 집계 (년/월/주) ──────────
  List<CountStatDTO> findInboundCountByYear(String warehouseCode);
  List<CountStatDTO> findInboundCountByMonth(Map<String, Object> paramMap);
  List<CountStatDTO> findInboundCountByWeek(Map<String, Object> paramMap);

  // ─── Order 건수 집계 (년/월/주) ────────────
  List<CountStatDTO> findOrderCountByYear(String warehouseCode);
  List<CountStatDTO> findOrderCountByMonth(Map<String, Object> paramMap);
  List<CountStatDTO> findOrderCountByWeek(Map<String, Object> paramMap);
  
  // ─── 재고/자산 현황 ──────────────────────
  Long findTotalInventoryPrice(String warehouseCode);
  List<InventoryStatisticDTO> findProductInventoryByWarehouse(String warehouseCode);
  List<InventoryStatisticDTO> findCategoryInventoryByWarehouse(String warehouseCode);
  List<InventoryStatisticDTO> findSectionInventoryByStoredType(Map<String, Object> paramMap);

  // ─── 섹션 사용률 (percent) ─────────────────
  List<SectionUsageDTO> findSectionUsageRateByWarehouse(String warehouseCode);
}
