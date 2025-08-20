package com.donut.prokindonutsweb.inbound.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class InboundDetailVO {
    private String inboundDetailCode;
    private Integer quantity;
    private String inboundCode;
    private String productCode;
    private String sectionCode;
}
