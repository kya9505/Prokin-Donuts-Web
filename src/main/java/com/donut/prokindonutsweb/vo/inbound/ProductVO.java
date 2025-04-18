package com.donut.prokindonutsweb.vo.inbound;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductVO {
    private String productCode;
    private String productName;
    private Integer productPrice;
    private String storedType;
}
