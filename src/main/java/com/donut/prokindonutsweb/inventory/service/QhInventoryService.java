package com.donut.prokindonutsweb.inventory.service;

import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;

import java.util.List;

public interface QhInventoryService {
  List<InventorySelectDTO> findInventoryList();
  List<String> findWarehouseList();
}
