package com.donut.prokindonutsweb.dto.warehouse;

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
