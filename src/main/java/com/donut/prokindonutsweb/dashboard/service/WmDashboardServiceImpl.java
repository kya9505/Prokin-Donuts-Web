package com.donut.prokindonutsweb.dashboard.service;

import com.donut.prokindonutsweb.dashboard.dto.CountStatDTO;
import com.donut.prokindonutsweb.dashboard.dto.InventoryStatisticDTO;
import com.donut.prokindonutsweb.dashboard.dto.SectionUsageDTO;
import com.donut.prokindonutsweb.dashboard.mapper.WmDashboardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class WmDashboardServiceImpl implements WmDashboardService {
  private final WmDashboardMapper wmDashboardMapper;
  private final ModelMapper modelMapper;
  
  // ─── 창고 코드 조회 ─────────────────────
  @Override
  public List<String> findWarehouseCodesByMember(String memberCode) {
    return wmDashboardMapper.selectWarehouseCodesByMember(memberCode);
  }
  
  // ─── 섹션 온도 조회/수정 ─────────────────
  @Override
  public int findSectionTemperature(Map<String, Object> paramMap) {
    return wmDashboardMapper.selectSectionTemperature(paramMap);
  }

  @Override
  public int updateSectionTemperature(Map<String, Object> paramMap) {
    return wmDashboardMapper.updateSectionTemperature(paramMap);
  }

  // ─── 오늘 미승인 입고요청/출고요청 수 ──────
  @Override
  public int findTodayWaitingInboundCount(String warehouseCode) {
    return wmDashboardMapper.selectTodayWaitingInboundCount(warehouseCode);
  }

  @Override
  public int findTodayWaitingOrderCount(String warehouseCode) {
    return wmDashboardMapper.selectTodayWaitingOrderCount(warehouseCode);
  }

  // ─── Inbound 건수 집계 (년/월/주) ──────────
  @Override
  public List<CountStatDTO> findInboundCountByYear(String warehouseCode) {
    return wmDashboardMapper.selectInboundCountByYear(warehouseCode);
  }

  @Override
  public List<CountStatDTO> findInboundCountByMonth(Map<String, Object> paramMap) {
    return wmDashboardMapper.selectInboundCountByMonth(paramMap);
  }

  @Override
  public List<CountStatDTO> findInboundCountByWeek(Map<String, Object> paramMap) {
    return wmDashboardMapper.selectInboundCountByWeek(paramMap);
  }

  // ─── Order 건수 집계 (년/월/주) ────────────
  @Override
  public List<CountStatDTO> findOrderCountByYear(String warehouseCode) {
    return wmDashboardMapper.selectOrderCountByYear(warehouseCode);
  }

  @Override
  public List<CountStatDTO> findOrderCountByMonth(Map<String, Object> paramMap) {
    return wmDashboardMapper.selectOrderCountByMonth(paramMap);
  }

  @Override
  public List<CountStatDTO> findOrderCountByWeek(Map<String, Object> paramMap) {
    return wmDashboardMapper.selectOrderCountByWeek(paramMap);
  }
  
  // ─── 재고/자산 현황 ──────────────────────
  @Override
  public Long findTotalInventoryPrice(String warehouseCode) {
    return wmDashboardMapper.selectTotalInventoryPrice(warehouseCode);
  }

  @Override
  public List<InventoryStatisticDTO> findProductInventoryByWarehouse(String warehouseCode) {
    // Mapper가 VO 리턴한다고 가정할 때
    var voList = wmDashboardMapper.selectProductInventoryByWarehouse(warehouseCode);
    return voList.stream()
        .map(vo -> modelMapper.map(vo, InventoryStatisticDTO.class))
        .collect(Collectors.toList());
  }

  @Override
  public List<InventoryStatisticDTO> findCategoryInventoryByWarehouse(String warehouseCode) {
    var voList = wmDashboardMapper.selectCategoryInventoryByWarehouse(warehouseCode);
    return voList.stream()
        .map(vo -> modelMapper.map(vo, InventoryStatisticDTO.class))
        .collect(Collectors.toList());
  }

  @Override
  public List<InventoryStatisticDTO> findSectionInventoryByStoredType(Map<String, Object> paramMap) {
    var voList = wmDashboardMapper.selectSectionInventoryByStoredType(paramMap);
    return voList.stream()
        .map(vo -> modelMapper.map(vo, InventoryStatisticDTO.class))
        .collect(Collectors.toList());
  }

  // ─── 섹션 사용률 (percent) ─────────────────
  @Override
  public List<SectionUsageDTO> findSectionUsageRateByWarehouse(String warehouseCode) {
    var voList = wmDashboardMapper.selectSectionUsageRateByWarehouse(warehouseCode);
    return voList.stream()
        .map(vo -> modelMapper.map(vo, SectionUsageDTO.class))
        .collect(Collectors.toList());
  }
}