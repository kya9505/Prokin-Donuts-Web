package com.donut.prokindonutsweb.home.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class LoginRequestDTO {
    private String username;
    private String password;
}
