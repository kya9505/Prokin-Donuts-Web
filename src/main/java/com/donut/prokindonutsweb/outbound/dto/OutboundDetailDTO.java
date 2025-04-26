package com.donut.prokindonutsweb.outbound.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class OutboundDetailDTO {
    private String outboundDetailCode;
    private String quantity;
    private String outboundCode;
    private String productCode;
}
