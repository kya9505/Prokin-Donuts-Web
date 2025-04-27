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
public class OrderInboundDTO {
    //창고 코드
    String warehouseCode;
    //입고승인량
    int receivedQuantity;
    //총 입고 요청량
    int totalInboundQuantity;
    //발주승인(출고진행)량
    int orderedQuantity;
    //종 발주요청량(출고요청량)
    int totalOrderQuantity;

    //입고승입 비율
    public double inboundApprovalRate() {
        if (totalInboundQuantity == 0) return 0;
        return (double) receivedQuantity / totalInboundQuantity;
    }

    //발주승인 비율
    public double orderedRate() {
        if (totalOrderQuantity == 0) return 0;
        return (double) orderedQuantity / totalOrderQuantity;
    }


}
