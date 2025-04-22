package com.donut.prokindonutsweb.product.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class ProductMainVO {
  private String productCode;   // 제품 코드
  private String productName;   // 제품명
  private int productPrice;     // 제품 단가
  private String categoryCode;  // 카테고리 코드
  private String storedType;    // 보관 타입
}
