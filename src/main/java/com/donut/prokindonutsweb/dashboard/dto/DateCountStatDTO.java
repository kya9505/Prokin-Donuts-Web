package com.donut.prokindonutsweb.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DateCountStatDTO {
  /** 집계 날짜 (YYYY-MM-DD) */
  private LocalDate period;
  /** 건수 */
  private int count;
  /** 화면 표시용 레이블 (예: "06-07") */
  private String label;
}