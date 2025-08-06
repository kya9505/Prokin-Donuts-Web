package com.donut.prokindonutsweb.outbound.vo;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;

@Data
@Builder
public class OutboundVO {
    private String outboundCode;
    private LocalDate outboundDate;
    private String outboundStatus;
    private int quantity;
    private String orderDetailCode;
    private String inventoryCode;
    private String vehicleCode;

}
