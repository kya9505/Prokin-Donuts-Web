package com.donut.prokindonutsweb.dashboard.service;

import com.donut.prokindonutsweb.dashboard.dto.CategoryProductInventoryDTO;
import com.donut.prokindonutsweb.dashboard.dto.CountStatDTO;
import com.donut.prokindonutsweb.dashboard.dto.InventoryStatisticDTO;
import com.donut.prokindonutsweb.dashboard.dto.SectionUsageDTO;
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
  public List<CountStatDTO> findInboundCountByMonth(int year, String warehouseCode) {
    return wmDashboardMapper.selectInboundCountByMonth(year, warehouseCode);
  }
  
  @Override
  public List<CountStatDTO> findInboundCountByWeek(int year, String warehouseCode) {
    return wmDashboardMapper.selectInboundCountByWeek(year, warehouseCode);
  }
  
  @Override
  public List<CountStatDTO> findOrderCountByMonth(int year, String warehouseCode) {
    return wmDashboardMapper.selectOrderCountByMonth(year, warehouseCode);
  }
  
  @Override
  public List<CountStatDTO> findOrderCountByWeek(int year, String warehouseCode) {
    return wmDashboardMapper.selectOrderCountByWeek(year, warehouseCode);
  }
  
  @Override
  public Long findTotalInventoryPrice(String warehouseCode) {
    Long price = wmDashboardMapper.selectTotalInventoryPrice(warehouseCode);
    return price != null ? price : 0L;
  }
  
//  @Override
//  public List<InventoryStatisticDTO> findProductInventoryByWarehouse(String warehouseCode) {
//    return wmDashboardMapper.selectProductInventoryByWarehouse(warehouseCode);
//  }
  
  @Override
  public List<InventoryStatisticDTO> findCategoryInventoryByWarehouse(String warehouseCode) {
    return wmDashboardMapper.selectCategoryInventoryByWarehouse(warehouseCode);
  }
  @Override
  public List<CategoryProductInventoryDTO> findCategoryProductInventoryByWarehouse(String warehouseCode) {
    return wmDashboardMapper.selectCategoryProductInventoryByWarehouse(warehouseCode);
  }

//    @Override
//    public List<InventoryStatisticDTO> findSectionInventoryByStoredType(String warehouseCode, String storedType) {
//        return wmDashboardMapper.selectSectionInventoryByStoredType(warehouseCode, storedType);
//    }
  
  @Override
  public List<SectionUsageDTO> findSectionUsageRateByWarehouse(String warehouseCode) {
    return wmDashboardMapper.selectSectionUsageRateByWarehouse(warehouseCode);
  }
}