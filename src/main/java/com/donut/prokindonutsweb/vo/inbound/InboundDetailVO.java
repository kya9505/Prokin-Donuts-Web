package com.donut.prokindonutsweb.vo.inbound;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class InboundDetailVO {
    private String productCode;
    private String productName;
    private Integer productPrice;
    private String storedType;
    private Integer quantity;
}
