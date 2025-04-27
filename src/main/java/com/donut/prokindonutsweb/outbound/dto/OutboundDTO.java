package com.donut.prokindonutsweb.outbound.dto;

import lombok.*;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class OutboundDTO {
    private String outboundCode;
    private LocalDate outboundDate;
    private String outboundStatus;
    private String franchiseCode;
    private String warehouseCode;
}
