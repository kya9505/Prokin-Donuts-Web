package com.donut.prokindonutsweb.dto.member;

import lombok.*;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class MemberAccountDTO {

    @NotEmpty
    private String memberCode;

    @NotEmpty
    private String authorityCode;

    @NotEmpty
    private String name;

   private String phoneNumber;

    @NotEmpty
    @Email
    private String email;

    @NotEmpty
    private String address;

    @NotEmpty
    private String id;

    @NotEmpty
    private String password;
}
