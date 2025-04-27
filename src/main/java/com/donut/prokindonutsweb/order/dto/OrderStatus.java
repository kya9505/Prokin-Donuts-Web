package com.donut.prokindonutsweb.order.dto;

import lombok.Getter;

@Getter
public enum OrderStatus {
    REQUEST("출고대기");


    private final String status;

    OrderStatus(String status) {
        this.status = status;
    }
}
