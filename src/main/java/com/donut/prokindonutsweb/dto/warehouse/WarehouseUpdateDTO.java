package com.donut.prokindonutsweb.dto.warehouse;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WarehouseUpdateDTO {
  private String warehouseCode;
  private String warehouseName;
  private String memberCode;
}
