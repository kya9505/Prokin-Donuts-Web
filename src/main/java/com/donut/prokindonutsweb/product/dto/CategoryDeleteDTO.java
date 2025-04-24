package com.donut.prokindonutsweb.product.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CategoryDeleteDTO {
  private String categoryCode; // 카테고리 코드
}
