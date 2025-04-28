package com.donut.prokindonutsweb.dashboard.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Data
@Log4j2
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderInboundRateDTO {
    //입고승인/총입고요청
    private double inboundRate;
    //발주승인/총발주요청(출고승인/총 출고요청)
    private double orderRate;
}
