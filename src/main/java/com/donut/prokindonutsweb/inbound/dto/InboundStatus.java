package com.donut.prokindonutsweb.inbound.dto;

import lombok.Getter;

@Getter
public enum InboundStatus {
    REQUEST("입고요청"),
    APPROVE("승인대기");

    private final String status;

    InboundStatus(String status) {
        this.status = status;
    }

}
