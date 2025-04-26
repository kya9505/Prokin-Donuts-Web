package com.donut.prokindonutsweb.inbound.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductVO {
    private String categoryMid;
    private String categorySub;
    private String productCode;
    private String productName;
    private Integer productPrice;
    private String storedType;
}
