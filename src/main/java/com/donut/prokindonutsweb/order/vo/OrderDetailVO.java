package com.donut.prokindonutsweb.order.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class OrderDetailVO {
    private String orderDetailCode;
    private Integer quantity;
    private String orderCode;
    private String productCode;
    private String orderStatus;
}
