package com.donut.prokindonutsweb.warehouse.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WarehouseCheckDTO {
  private String warehouseCode;
  private String warehouseName;
}
