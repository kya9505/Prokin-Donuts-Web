package com.donut.prokindonutsweb.product.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.List;

@NoArgsConstructor
@Data  // 이미 있을 수도 있음
public class ProductListWrapper {
  private List<ProductInsertDTO> productList;
}