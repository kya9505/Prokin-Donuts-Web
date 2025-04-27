package com.donut.prokindonutsweb.dashboard.mapper;

import com.donut.prokindonutsweb.dashboard.dto.CategoryProductInventoryDTO;
import com.donut.prokindonutsweb.dashboard.dto.CountStatDTO;
import com.donut.prokindonutsweb.dashboard.dto.InventoryStatisticDTO;
import com.donut.prokindonutsweb.dashboard.dto.SectionUsageDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

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
  
  // 입고 완료 월별 집계
  List<CountStatDTO> selectInboundCountByMonth(@Param("year") int year,
                                               @Param("warehouseCode") String warehouseCode);
  
  // 입고 완료 주별 집계
  List<CountStatDTO> selectInboundCountByWeek(@Param("year") int year,
                                              @Param("warehouseCode") String warehouseCode);
  
  // 출고 완료 월별 집계
  List<CountStatDTO> selectOrderCountByMonth(@Param("year") int year,
                                             @Param("warehouseCode") String warehouseCode);
  
  // 출고 완료 주별 집계
  List<CountStatDTO> selectOrderCountByWeek(@Param("year") int year,
                                            @Param("warehouseCode") String warehouseCode);
  
  // 창고의 현재 총 자산
  Long selectTotalInventoryPrice(String warehouseCode);
  
  // 제품별 재고 현황
//  List<InventoryStatisticDTO> selectProductInventoryByWarehouse(String warehouseCode);
  
  // 카테고리별 재고 현황
  List<InventoryStatisticDTO> selectCategoryInventoryByWarehouse(String warehouseCode);
  List<CategoryProductInventoryDTO> selectCategoryProductInventoryByWarehouse(String warehouseCode);
  
  
  // ❗ 주석 처리된 거라 주석 형태로 같이 둠
//    List<InventoryStatisticDTO> selectSectionInventoryByStoredType(@Param("warehouseCode") String warehouseCode,
//                                                                   @Param("storedType") String storedType);
  
  // 섹션 사용률 (percent)
  List<SectionUsageDTO> selectSectionUsageRateByWarehouse(String warehouseCode);
}
