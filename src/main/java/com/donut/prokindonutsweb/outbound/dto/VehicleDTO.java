package com.donut.prokindonutsweb.outbound.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;

@Data
@Builder
public class VehicleDTO {
    private String outboundCode;
    private String warehouseCode;
    private String storedType;
    private int quantity;
    private LocalDate outboundDate;
}
