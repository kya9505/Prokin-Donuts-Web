package com.donut.prokindonutsweb.member.dto;

import lombok.*;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class MemberRequestDTO {


    @NotBlank
    private String name;

    private String phoneNumber;

    @NotBlank
    @Email
    private String email;

    @NotBlank
    private String id;

    @NotBlank
    private String password;

    private String address;

    //requestCode 서비스단에서 로직으로 등록처리
    private String requestCode;
    
    //DB 삽입 시 default 값
    private String request;
    private String authorityCode;
    private LocalDate requestDate;

}
