package com.donut.prokindonutsweb.warehouse.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class WarehouseVO {
  private String warehouseCode;
  private String warehouseName;
  private int capacityLimit;
  private String address;
  private String memberCode;
}
