package com.donut.prokindonutsweb.dashboard.service;

import com.donut.prokindonutsweb.dashboard.dto.CategoryProductInventoryDTO;
import com.donut.prokindonutsweb.dashboard.dto.CountStatDTO;
import com.donut.prokindonutsweb.dashboard.dto.InventoryStatisticDTO;
import com.donut.prokindonutsweb.dashboard.dto.SectionUsageDTO;

import java.util.List;

public interface WmDashboardService {
  // 창고코드 조회
  List<String> findWarehouseCodesByMember(String memberCode);
  
  // 섹션별 온도 조회
  int findSectionTemperature(String warehouseCode, String storedType);
  
  // 섹션 온도 업데이트
  void updateSectionTemperature(String warehouseCode, String storedType, int temperature);
  
  // 오늘 미승인 입고요청 수
  int findTodayWaitingInboundCount(String warehouseCode);
  
  // 오늘 미승인 출고요청 수
  int findTodayWaitingOrderCount(String warehouseCode);
  
  // 입고 완료 (월별)
  List<CountStatDTO> findInboundCountByMonth(int year, String warehouseCode);
  
  // 입고 완료 (주별)
  List<CountStatDTO> findInboundCountByWeek(int year, String warehouseCode);
  
  // 출고 완료 (월별)
  List<CountStatDTO> findOrderCountByMonth(int year, String warehouseCode);
  
  // 출고 완료 (주별)
  List<CountStatDTO> findOrderCountByWeek(int year, String warehouseCode);
  
  // 창고 총 자산 금액
  Long findTotalInventoryPrice(String warehouseCode);
  
  // 제품별 재고 수량
//  List<InventoryStatisticDTO> findProductInventoryByWarehouse(String warehouseCode);
  
  // 카테고리별 재고 수량
  List<InventoryStatisticDTO> findCategoryInventoryByWarehouse(String warehouseCode);
  List<CategoryProductInventoryDTO> findCategoryProductInventoryByWarehouse(String warehouseCode);
  
  // ❗ 주석 처리된 기능 (필요 시 복구 가능)
//    List<InventoryStatisticDTO> findSectionInventoryByStoredType(String warehouseCode, String storedType);
  
  // 섹션별 사용률
  List<SectionUsageDTO> findSectionUsageRateByWarehouse(String warehouseCode);
}
