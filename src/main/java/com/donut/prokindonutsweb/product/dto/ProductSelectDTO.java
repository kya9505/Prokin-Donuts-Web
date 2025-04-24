package com.donut.prokindonutsweb.product.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductSelectDTO {
  private String productCode;   // 제품 코드
  private String categoryMid;   // 중분류명
  private String categorySub;   // 소분류명
  private String storedType;    // 보관 타입
  private String productName;   // 제품명
  private int productPrice;     // 제품 단가
  private String productStatus; // 제품 상태
}
