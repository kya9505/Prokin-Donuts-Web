package com.donut.prokindonutsweb.login.dto;

import lombok.*;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class VerificationCodeDTO {
    private String code;                 // 실제 인증 코드
    private LocalDateTime expireTime;   // 유효 시간

    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expireTime);
    }

    public boolean matches(String inputCode) {
        return code.equals(inputCode);
    }
}
