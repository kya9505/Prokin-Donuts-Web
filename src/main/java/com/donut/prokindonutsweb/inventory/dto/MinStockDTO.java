package com.donut.prokindonutsweb.inventory.dto;

import lombok.Data;

@Data
public class MinStockDTO {
  private String warehouseCode;
  private String productCode;
  private String productName;
  private int minStock;
}