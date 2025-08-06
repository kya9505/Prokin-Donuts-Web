package com.donut.prokindonutsweb.dashboard.mapper;

import com.donut.prokindonutsweb.dashboard.dto.CountStatDTO;
import com.donut.prokindonutsweb.dashboard.dto.InventoryStatisticDTO;
import com.donut.prokindonutsweb.dashboard.dto.SectionUsageDTO;
import com.donut.prokindonutsweb.dashboard.dto.SubcategoryProductInventoryDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface WmDashboardMapper {
  
  
  // 창고관리자(멤버) 코드로 창고 코드 조회
  List<String> selectWarehouseCodesByMember(String memberCode);
  
  // 창고코드에 해당하는 섹션별 온도 조회
  int selectSectionTemperature(@Param("warehouseCode") String warehouseCode,
                               @Param("storedType") String storedType);
  
  // 창고코드 & 섹션 타입에 해당하는 온도 수정
  void updateSectionTemperature(@Param("warehouseCode") String warehouseCode,
                               @Param("storedType") String storedType,
                               @Param("temperature") int temperature);
  
  // 오늘 미승인 입고요청 수
  int selectTodayWaitingInboundCount(String warehouseCode);
  
  // 오늘 미승인 출고요청 수
  int selectTodayWaitingOrderCount(String warehouseCode);
  
  // 유통기한 지난 재고 갯수
  int selectExpiredInventoryCount(String warehouseCode);
  
  // 적정재고량 미달 제품 갯수
  int selectUnderMinStockCount(String warehouseCode);
  
  // 입고 완료 - 최근 12개월 (월별)
  List<CountStatDTO> selectInboundCountLast12Months(@Param("warehouseCode") String warehouseCode);
  // 출고 완료 - 최근 12개월 (월별)
  List<CountStatDTO> selectOrderCountLast12Months(@Param("warehouseCode") String warehouseCode);
  // 입고 완료 - 최근 4주 (주별)
  List<CountStatDTO> selectInboundCountLast4Weeks(@Param("warehouseCode") String warehouseCode);
  // 출고 완료 - 최근 4주 (주별)
  List<CountStatDTO> selectOrderCountLast4Weeks(@Param("warehouseCode") String warehouseCode);
  // 입고 완료 - 최근 5년 (연도별)
  List<CountStatDTO> selectInboundCountRecentYears(@Param("warehouseCode") String warehouseCode);
  // 출고 완료 - 최근 5년 (연도별)
  List<CountStatDTO> selectOrderCountRecentYears(@Param("warehouseCode") String warehouseCode);
  // 창고의 현재 총 자산
  Long selectTotalInventoryPrice(String warehouseCode);
  
  // 카테고리별 재고 현황
  List<InventoryStatisticDTO> selectCategoryInventoryByWarehouse(String warehouseCode);
  List<SubcategoryProductInventoryDTO> selectSubcategoryProductInventoryByWarehouse(String warehouseCode);
  
  // 섹션 사용률 (percent)
  List<SectionUsageDTO> selectSectionUsageRateByWarehouse(String warehouseCode);
}
