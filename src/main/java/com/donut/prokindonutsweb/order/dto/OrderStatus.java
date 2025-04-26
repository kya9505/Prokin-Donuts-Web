package com.donut.prokindonutsweb.order.dto;

import lombok.Getter;

@Getter
public enum OrderStatus {
    REQUEST("발주요청");


    private final String status;

    OrderStatus(String status) {
        this.status = status;
    }
}
