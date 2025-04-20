package com.donut.prokindonutsweb.vo.member;

import lombok.*;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class MemberRequestVO {
    private String requestCode;
    private String name;
    private String phoneNumber;
    private String email;
    private String id;
    private String password;
    private String address;
    private String request;
    private String authorityCode;
    private LocalDate requestDate;

}
