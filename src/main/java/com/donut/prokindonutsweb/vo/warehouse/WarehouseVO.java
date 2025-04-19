package com.donut.prokindonutsweb.vo.warehouse;

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
