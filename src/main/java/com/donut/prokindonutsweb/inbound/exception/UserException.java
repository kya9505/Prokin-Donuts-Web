package com.donut.prokindonutsweb.inbound.exception;

import lombok.Getter;

@Getter
public class UserException extends RuntimeException{
    private final ErrorType errorType;

    public UserException(ErrorType errorType) {
        super(errorType.getMessage());
        this.errorType = errorType;
    }
}
