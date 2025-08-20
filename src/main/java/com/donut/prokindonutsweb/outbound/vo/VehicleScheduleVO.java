package com.donut.prokindonutsweb.outbound.vo;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;

@Data
@Builder
public class VehicleScheduleVO {
    private String vehicleScheduleCode;
    private String vehicleCode;
    private LocalDate dispatchDate;
    private int remainingCapacity;

}
