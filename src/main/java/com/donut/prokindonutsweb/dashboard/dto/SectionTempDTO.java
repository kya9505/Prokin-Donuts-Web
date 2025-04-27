package com.donut.prokindonutsweb.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SectionTempDTO {
  private String warehouseCode;
  private String storedType;  // '냉장', '냉동', '상온'
  private int temperature;
}