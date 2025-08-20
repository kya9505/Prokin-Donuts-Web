package com.donut.prokindonutsweb.inventory.dto;

import lombok.Data;

@Data
public class InventoryExpiredDTO {
  private int inventoryCode;
  private String productCode;
  private String productName;
}