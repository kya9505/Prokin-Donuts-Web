package com.donut.prokindonutsweb.dashboard.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class InboundChartVO {
  private String inboundCode;
  private LocalDateTime inboundDate;
  private String inboundStatus;
  private String warehouseCode;
}