package com.donut.prokindonutsweb.inbound.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InboundDTO {
    private String inboundCode;
    private LocalDate inboundDate;
    private String inboundStatus;
    private String warehouseCode;
}
