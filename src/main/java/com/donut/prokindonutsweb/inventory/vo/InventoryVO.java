package com.donut.prokindonutsweb.inventory.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InventoryVO {
  private String inventoryCode;
  private int quantity;
  private String productCode;
  private String warehouseCode;
}
