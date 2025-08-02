package com.donut.prokindonutsweb.inbound.vo;

import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InventoryVO {
    private Integer inventoryCode;
    private Integer quantity;
    private String productCode;
    private String warehouseCode;
    private String barcode;
    private LocalDate expirationDate;

}
