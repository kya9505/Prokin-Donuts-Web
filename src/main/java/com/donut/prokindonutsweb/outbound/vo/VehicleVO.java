package com.donut.prokindonutsweb.outbound.vo;

import lombok.Builder;
import lombok.Data;


@Data
@Builder
public class VehicleVO {
    private String vehicleCode;
    private String warehouseCode;
    private String type;
    private int capacity;
    private String vehicleNum;

}
