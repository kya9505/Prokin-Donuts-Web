package com.donut.prokindonutsweb.inventory.service;

import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;

import java.util.List;

public interface WmInventoryService {
  List<InventorySelectDTO> findInventoryList(String warehouseCode);
  String findWarehouseCodeByMemberCode(String memberCode);
}
