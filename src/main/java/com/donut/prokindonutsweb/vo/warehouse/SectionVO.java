package com.donut.prokindonutsweb.vo.warehouse;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class SectionVO {
  private String sectionCode;
  private String warehouseCode;
  private int storageCapacity;
  private String storedType;
  private int temperature;
}
