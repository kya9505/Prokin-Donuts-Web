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
public class OrderChartVO {
  private String orderCode;
  private LocalDateTime orderDate;
  private String orderStatus;
  private String franchiseCode;
  private String warehouseCode;
}