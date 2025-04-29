package com.donut.prokindonutsweb.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SubcategoryProductInventoryDTO {
  private String subcategoryName;  // 소분류 이름
  private String productName;      // 제품명
  private int    quantity;         // 수량
}