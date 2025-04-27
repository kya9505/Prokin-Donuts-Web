package com.donut.prokindonutsweb.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CategoryProductInventoryDTO {
  private String categoryName; // 카테고리 이름 (ex: 도넛, 베이글)
  private String productName;  // 제품 이름 (ex: 초코 도넛, 플레인 베이글)
  private int quantity;        // 재고 수량
}