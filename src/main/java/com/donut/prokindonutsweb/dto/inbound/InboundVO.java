package com.donut.prokindonutsweb.dto.inbound;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InboundVO {
    private String inboundCode;
    private LocalDate inboundDate;
    private String inboundStatus;
    private String warehouseCode;
}
