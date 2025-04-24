package com.donut.prokindonutsweb.order.vo;

import lombok.*;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class OrderVO {
    private String orderCode;
    private LocalDate orderDate;
    private String orderStatus;
    private String franchiseCode;
    private String warehouseCode;
}
