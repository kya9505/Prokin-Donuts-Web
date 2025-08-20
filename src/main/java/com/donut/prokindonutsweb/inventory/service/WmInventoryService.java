package com.donut.prokindonutsweb.inventory.service;

import com.donut.prokindonutsweb.inbound.dto.ProductDTO;
import com.donut.prokindonutsweb.inventory.dto.InventoryExpiredDTO;
import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;
import com.donut.prokindonutsweb.inventory.dto.MinStockDTO;

import java.util.List;
import java.util.Map;

public interface WmInventoryService {
  List<InventorySelectDTO> findInventoryList(String warehouseCode);
  String findWarehouseCodeByMemberCode(String memberCode);
  String findWarehouseNameByWarehouseCode(String warehouseCode);
  
  List<InventoryExpiredDTO> getExpiredItems(String warehouseCode);
  void discardExpiredItems(String warehouseCode);
  
  List<MinStockDTO> getMinStockList(String warehouseCode);
  void saveMinStockList(List<MinStockDTO> minStockList);
  
  List<ProductDTO> searchProducts(String keyword);
  
  List<Map<String, Object>> suggestMinStock(String warehouseCode, Integer L, Double z, Integer packSize);
}
