package com.donut.prokindonutsweb.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SectionUsageDTO {
  private String storedType;  // 냉장/냉동/상온
  private double usedRate;    // 사용률 (%)
}