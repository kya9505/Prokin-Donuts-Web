package com.donut.prokindonutsweb.home.dto;

import lombok.*;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class LoginResponseDTO {
    private boolean success;
    private String message;
    private Collection<? extends GrantedAuthority> authorities;
    private String redirectUrl;

    public LoginResponseDTO(boolean success,String message,String redirectUrl) {}
}
