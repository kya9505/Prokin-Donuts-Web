package com.donut.prokindonutsweb.warehouse.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class WarehouseDTO {
  private String warehouseCode;
  private String warehouseName;
  private int capacityLimit;
  private String address;
  private String memberCode;
  private String memberName;
  private String memberEmail;
  private String status;
}
