package com.donut.prokindonutsweb.inventory.service;

import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;
import com.donut.prokindonutsweb.inventory.mapper.QhInventoryMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class QhInventoryServiceImpl implements QhInventoryService {
  private final QhInventoryMapper qhInventoryMapper;
  
  // 전체 재고 목록 조회
  @Override
  public List<InventorySelectDTO> findInventoryList() {
    return qhInventoryMapper.selectInventoryList();
  }
  
  // 재고가 존재하는 창고명 목록 조회
  @Override
  public List<String> findWarehouseList() {
    return qhInventoryMapper.selectWarehouseList();
  }
}
