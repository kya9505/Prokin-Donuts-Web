package com.donut.prokindonutsweb.inventory.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class InventorySelectDTO {
  private String inventoryCode;
  private String warehouseName;
  private String storedType;
  private String categoryMid;
  private String categorySub;
  private String productName;
  private int quantity;
}
