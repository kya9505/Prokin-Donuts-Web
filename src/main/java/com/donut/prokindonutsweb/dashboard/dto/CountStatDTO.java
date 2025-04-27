package com.donut.prokindonutsweb.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CountStatDTO {
  private int period;  // 연: 2025, 월: 4, 주: 16 등
  private int count;   // 건수
}