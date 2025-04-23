package com.donut.prokindonutsweb.inbound.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InventoryVO {
    private String inventoryCode;
    private Integer quantity;
    private String productCode;
    private String warehouseCode;
}
