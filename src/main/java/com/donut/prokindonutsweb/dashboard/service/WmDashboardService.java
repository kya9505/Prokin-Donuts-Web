package com.donut.prokindonutsweb.dashboard.service;

import com.donut.prokindonutsweb.dashboard.dto.CountStatDTO;
import com.donut.prokindonutsweb.dashboard.dto.InventoryStatisticDTO;
import com.donut.prokindonutsweb.dashboard.dto.SectionUsageDTO;
import com.donut.prokindonutsweb.dashboard.dto.SubcategoryProductInventoryDTO;

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
  
  // 유통기한 지난 재고 갯수
  int findExpiredInventoryCount(String warehouseCode);
  
  // 적정재고량 미달 제품 갯수
  int findUnderMinStockCount(String warehouseCode);
  
  // 입고 완료 - 최근 12개월 (월별)
  List<CountStatDTO> findInboundCountLast12Months(String warehouseCode);
  // 출고 완료 - 최근 12개월 (월별)
  List<CountStatDTO> findOrderCountLast12Months(String warehouseCode);
  // 입고 완료 - 최근 4주 (주별)
  List<CountStatDTO> findInboundCountLast4Weeks(String warehouseCode);
  // 출고 완료 - 최근 4주 (주별)
  List<CountStatDTO> findOrderCountLast4Weeks(String warehouseCode);
  // 입고 완료 - 최근 5년 (연도별)
  List<CountStatDTO> findInboundCountRecentYears(String warehouseCode);
  // 출고 완료 - 최근 5년 (연도별)
  List<CountStatDTO> findOrderCountRecentYears(String warehouseCode);
  
  // 창고 총 자산 금액
  Long findTotalInventoryPrice(String warehouseCode);
  
  // 카테고리별 재고 수량
  List<InventoryStatisticDTO> findCategoryInventoryByWarehouse(String warehouseCode);
  List<SubcategoryProductInventoryDTO> findSubcategoryProductInventoryByWarehouse(String warehouseCode);
  
  // 섹션별 사용률
  List<SectionUsageDTO> findSectionUsageRateByWarehouse(String warehouseCode);
}
