package com.donut.prokindonutsweb.product.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class CategoryMainVO {
  private String categoryCode; // 카테고리 코드
  private String categoryMid;  // 중분류명
  private String categorySub;  // 소분류명
}
