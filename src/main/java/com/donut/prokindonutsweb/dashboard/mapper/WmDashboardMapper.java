package com.donut.prokindonutsweb.dashboard.mapper;

import com.donut.prokindonutsweb.dashboard.dto.CountStatDTO;
import com.donut.prokindonutsweb.dashboard.dto.InventoryStatisticDTO;
import com.donut.prokindonutsweb.dashboard.dto.SectionUsageDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface WmDashboardMapper {
  // ─── 창고 코드 조회 ─────────────────────
  List<String> selectWarehouseCodesByMember(@Param("memberCode") String memberCode);
  
  // ─── 섹션 온도 조회/수정 ─────────────────
  int selectSectionTemperature(Map<String, Object> paramMap);
  int updateSectionTemperature(Map<String, Object> paramMap);

  // ─── 오늘 미승인 입고요청/출고요청 수 ──────
  int selectTodayWaitingInboundCount(@Param("warehouseCode") String warehouseCode);
  int selectTodayWaitingOrderCount(@Param("warehouseCode") String warehouseCode);

  // ─── Inbound 건수 집계 (년/월/주) ──────────
  List<CountStatDTO> selectInboundCountByYear(@Param("warehouseCode") String warehouseCode);
  List<CountStatDTO> selectInboundCountByMonth(Map<String, Object> paramMap);
  List<CountStatDTO> selectInboundCountByWeek(Map<String, Object> paramMap);

  // ─── Order 건수 집계 (년/월/주) ────────────
  List<CountStatDTO> selectOrderCountByYear(@Param("warehouseCode") String warehouseCode);
  List<CountStatDTO> selectOrderCountByMonth(Map<String, Object> paramMap);
  List<CountStatDTO> selectOrderCountByWeek(Map<String, Object> paramMap);

  // ─── 재고/자산 현황 ──────────────────────
  Long selectTotalInventoryPrice(@Param("warehouseCode") String warehouseCode);
  List<InventoryStatisticDTO> selectProductInventoryByWarehouse(@Param("warehouseCode") String warehouseCode);
  List<InventoryStatisticDTO> selectCategoryInventoryByWarehouse(@Param("warehouseCode") String warehouseCode);
  List<InventoryStatisticDTO> selectSectionInventoryByStoredType(Map<String, Object> paramMap);

  // ─── 섹션 사용률 (percent) ─────────────────
  List<SectionUsageDTO> selectSectionUsageRateByWarehouse(@Param("warehouseCode") String warehouseCode);
}
