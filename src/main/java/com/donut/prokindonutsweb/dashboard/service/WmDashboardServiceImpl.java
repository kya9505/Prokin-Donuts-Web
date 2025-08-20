package com.donut.prokindonutsweb.dashboard.service;

import com.donut.prokindonutsweb.dashboard.dto.CountStatDTO;
import com.donut.prokindonutsweb.dashboard.dto.InventoryStatisticDTO;
import com.donut.prokindonutsweb.dashboard.dto.SectionUsageDTO;
import com.donut.prokindonutsweb.dashboard.dto.SubcategoryProductInventoryDTO;
import com.donut.prokindonutsweb.dashboard.mapper.WmDashboardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class WmDashboardServiceImpl implements WmDashboardService {
  
  private final WmDashboardMapper wmDashboardMapper;
  
  @Override
  public List<String> findWarehouseCodesByMember(String memberCode) {
    return wmDashboardMapper.selectWarehouseCodesByMember(memberCode);
  }
  
  @Override
  public int findSectionTemperature(String warehouseCode, String storedType) {
    return wmDashboardMapper.selectSectionTemperature(warehouseCode, storedType);
  }
  
  @Override
  public void updateSectionTemperature(String warehouseCode, String storedType, int temperature) {
    wmDashboardMapper.updateSectionTemperature(warehouseCode, storedType, temperature);
  }
  
  @Override
  public int findTodayWaitingInboundCount(String warehouseCode) {
    return wmDashboardMapper.selectTodayWaitingInboundCount(warehouseCode);
  }
  
  @Override
  public int findTodayWaitingOrderCount(String warehouseCode) {
    return wmDashboardMapper.selectTodayWaitingOrderCount(warehouseCode);
  }
  
  @Override
  public int findExpiredInventoryCount(String warehouseCode) {
    return wmDashboardMapper.selectExpiredInventoryCount(warehouseCode);
  }
  
  @Override
  public int findUnderMinStockCount(String warehouseCode) {
    return wmDashboardMapper.selectUnderMinStockCount(warehouseCode);
  }
  
  @Override
  public List<CountStatDTO> findInboundCountLast12Months(String warehouseCode) {
    return wmDashboardMapper.selectInboundCountLast12Months(warehouseCode);
  }
  
  @Override
  public List<CountStatDTO> findOrderCountLast12Months(String warehouseCode) {
    return wmDashboardMapper.selectOrderCountLast12Months(warehouseCode);
  }
  
  @Override
  public List<CountStatDTO> findInboundCountLast4Weeks(String warehouseCode) {
    return wmDashboardMapper.selectInboundCountLast4Weeks(warehouseCode);
  }
  
  @Override
  public List<CountStatDTO> findOrderCountLast4Weeks(String warehouseCode) {
    return wmDashboardMapper.selectOrderCountLast4Weeks(warehouseCode);
  }
  
  @Override
  public List<CountStatDTO> findInboundCountRecentYears(String warehouseCode) {
    return wmDashboardMapper.selectInboundCountRecentYears(warehouseCode);
  }
  
  @Override
  public List<CountStatDTO> findOrderCountRecentYears(String warehouseCode) {
    return wmDashboardMapper.selectOrderCountRecentYears(warehouseCode);
  }
  
  @Override
  public Long findTotalInventoryPrice(String warehouseCode) {
    Long price = wmDashboardMapper.selectTotalInventoryPrice(warehouseCode);
    return price != null ? price : 0L;
  }
  
  @Override
  public List<InventoryStatisticDTO> findCategoryInventoryByWarehouse(String warehouseCode) {
    return wmDashboardMapper.selectCategoryInventoryByWarehouse(warehouseCode);
  }
  
  @Override
  public List<SubcategoryProductInventoryDTO> findSubcategoryProductInventoryByWarehouse(String warehouseCode) {
    return wmDashboardMapper.selectSubcategoryProductInventoryByWarehouse(warehouseCode);
  }
  
  @Override
  public List<SectionUsageDTO> findSectionUsageRateByWarehouse(String warehouseCode) {
    return wmDashboardMapper.selectSectionUsageRateByWarehouse(warehouseCode);
  }
}
