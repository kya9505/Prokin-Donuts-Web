package com.donut.prokindonutsweb.warehouse.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WarehouseUpdateDTO {
  private String warehouseCode;
  private String warehouseName;
  private String memberCode;
}
