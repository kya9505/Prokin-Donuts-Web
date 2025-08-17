package com.donut.prokindonutsweb.inventory.mapper;

import com.donut.prokindonutsweb.inbound.dto.ProductDTO;
import com.donut.prokindonutsweb.inventory.dto.InventoryExpiredDTO;
import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;
import com.donut.prokindonutsweb.inventory.dto.MinStockDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface WmInventoryMapper {
  List<InventorySelectDTO> selectInventoryList(String warehouseCode);
  String selectWarehouseCodeByMemberCode(String memberCode);
  String selectWarehouseNameByWarehouseCode(String warehouseCode);
  
  List<InventoryExpiredDTO> selectExpiredItems(String warehouseCode);
  void deleteExpiredItems(String warehouseCode);
  
  List<MinStockDTO> selectByWarehouse(String warehouseCode);
  void upsert(MinStockDTO dto);
  void deleteMissingItems(@Param("warehouseCode") String warehouseCode,
                          @Param("productCodes") List<String> productCodes);
  
  List<ProductDTO> searchProducts(@Param("keyword") String keyword);
  
  List<Map<String, Object>> selectSuggestedMinStock(
      @Param("warehouseCode") String warehouseCode,
      @Param("L") int L,
      @Param("z") double z,
      @Param("packSize") int packSize
  );
}
