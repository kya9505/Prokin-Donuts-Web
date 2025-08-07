package com.donut.prokindonutsweb.inventory.service;

import com.donut.prokindonutsweb.inbound.dto.ProductDTO;
import com.donut.prokindonutsweb.inventory.dto.InventoryExpiredDTO;
import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;
import com.donut.prokindonutsweb.inventory.dto.MinStockDTO;
import com.donut.prokindonutsweb.inventory.mapper.WmInventoryMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class WmInventoryServiceImpl implements WmInventoryService {
  
  private final WmInventoryMapper wmInventoryMapper;
  
  @Override
  public List<InventorySelectDTO> findInventoryList(String warehouseCode) {
    return wmInventoryMapper.selectInventoryList(warehouseCode);
  }
  
  @Override
  public String findWarehouseCodeByMemberCode(String memberCode) {
    return wmInventoryMapper.selectWarehouseCodeByMemberCode(memberCode);
  }
  
  @Override
  public String findWarehouseNameByWarehouseCode(String WarehouseCode) {
    return wmInventoryMapper.selectWarehouseNameByWarehouseCode(WarehouseCode);
  }
  
  @Override
  public List<InventoryExpiredDTO> getExpiredItems(String warehouseCode) {
    return wmInventoryMapper.selectExpiredItems(warehouseCode);
  }
  
  @Override
  public void discardExpiredItems(String warehouseCode) {
    wmInventoryMapper.deleteExpiredItems(warehouseCode);
  }
  
  @Override
  public List<MinStockDTO> getMinStockList(String warehouseCode) {
    return wmInventoryMapper.selectByWarehouse(warehouseCode);
  }
  
  @Transactional
  @Override
  public void saveMinStockList(List<MinStockDTO> minStockList) {
    if (minStockList == null || minStockList.isEmpty()) return;
    
    // 1) 창고코드는 첫 항목 기준 (모두 동일해야 한다는 전제)
    String warehouseCode = minStockList.get(0).getWarehouseCode();
    
    // (예외) 전체 삭제 조건: productCode 없는 항목만 전달된 경우
    boolean isFullDelete = minStockList.size() == 1 && minStockList.get(0).getProductCode() == null;
    if (isFullDelete) {
      wmInventoryMapper.deleteMissingItems(warehouseCode, Collections.emptyList());
      return;
    }
    
    // 2) 전달된 항목 upsert
    for (MinStockDTO dto : minStockList) {
      wmInventoryMapper.upsert(dto);
    }
    
    // 3) 전달된 productCode 목록만 남기고 나머지 삭제
    List<String> productCodes = minStockList.stream()
        .map(MinStockDTO::getProductCode)
        .collect(Collectors.toList());
    
    if (!productCodes.isEmpty()) {
      wmInventoryMapper.deleteMissingItems(warehouseCode, productCodes);
    }
  }
  
  @Override
  public List<ProductDTO> searchProducts(String keyword) {
    return wmInventoryMapper.searchProducts("%" + keyword + "%");
  }
}
