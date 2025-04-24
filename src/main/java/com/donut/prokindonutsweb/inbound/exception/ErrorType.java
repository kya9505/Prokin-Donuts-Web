package com.donut.prokindonutsweb.inbound.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
public enum ErrorType {
    PRODUCT_NOT_FOUND("입고 가능한 제품이 존재하지 않습니다.", "/wm/inbound/request"),
    NOT_FOUND_INBOUND_DETAIL("해당 입고 내역은 존재하지 않습니다.", "/wm/inbound/approval"),
    NOT_FOUND_INBOUND_STATUS("현재 입고현황이 존재하지 않습니다.", "/wm/inbound/status"),
    NOT_FOUND_INBOUND_STATUS_QA("현재 입고현황이 존재하지 않습니다.", "/qh/inbound/status"),
    NOT_FOUND_INBOUND_REQUEST("현재 입고 요청이 존재하지 않습니다.", "/qh/inbound/request"),
    ;

    private final String message;
    private final String redirectUrl;

    ErrorType(String message, String redirectUrl) {
        this.message = message;
        this.redirectUrl = redirectUrl;
    }
}
