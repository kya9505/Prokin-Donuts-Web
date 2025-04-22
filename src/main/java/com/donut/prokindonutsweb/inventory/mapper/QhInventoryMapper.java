package com.donut.prokindonutsweb.inventory.mapper;

import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;

import java.util.List;

public interface QhInventoryMapper {
  List<InventorySelectDTO> selectInventoryList();
  List<String> selectWarehouseList();
}
