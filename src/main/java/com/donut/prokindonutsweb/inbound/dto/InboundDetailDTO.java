package com.donut.prokindonutsweb.inbound.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class InboundDetailDTO {
    private String inboundCode;
    private String productCode;
    private String productName;
    private Integer productPrice;
    private String storedType;
    private Integer quantity;
}
