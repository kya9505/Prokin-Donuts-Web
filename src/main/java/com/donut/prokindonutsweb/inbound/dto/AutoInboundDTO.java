package com.donut.prokindonutsweb.inbound.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AutoInboundDTO {
    private String productCode;
    private String productName;
    private Integer productPrice;
    private String storedType;
    private Integer suggestedQuantity;
} 