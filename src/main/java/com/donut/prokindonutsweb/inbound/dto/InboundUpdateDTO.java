package com.donut.prokindonutsweb.inbound.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class InboundUpdateDTO {
    private String productCode;
    private Integer quantity;
    private String inboundCode;
}
