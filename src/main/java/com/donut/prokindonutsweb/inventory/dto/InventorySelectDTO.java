package com.donut.prokindonutsweb.inventory.dto;

import lombok.*;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class InventorySelectDTO {
  private String barcode; // 재고 바코드
  private String warehouseName;
  private String storedType;
  private String categoryMid;
  private String categorySub;
  private String productName;
  private int quantity;
  private LocalDate expirationDate; // 재고 유통기한
}
