package com.donut.prokindonutsweb.inventory.service;

import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;
import com.donut.prokindonutsweb.inventory.mapper.WmInventoryMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
