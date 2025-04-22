package com.donut.prokindonutsweb.inventory.mapper;

import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;

import java.util.List;

public interface WmInventoryMapper {
  List<InventorySelectDTO> selectInventoryList(String warehouseCode);
  String selectWarehouseCodeByMemberCode(String memberCode);
  String selectWarehouseNameByWarehouseCode(String warehouseCode);
}
