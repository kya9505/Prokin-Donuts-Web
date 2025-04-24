package com.donut.prokindonutsweb.product.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductCheckDTO {
  private String productCode;  // 제품 코드
  private String categoryMid;  // 중분류
  private String categorySub;  // 소분류
  private String categoryCode; // 카테고리 코드
  private String productName;  // 제품명
}
