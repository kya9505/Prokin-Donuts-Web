package com.donut.prokindonutsweb.outbound.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;

@Data
@Builder
public class VehicleScheduleDTO {
    private String vehicleCode;
    private LocalDate dispatchDate;
    private int quantity;

}
