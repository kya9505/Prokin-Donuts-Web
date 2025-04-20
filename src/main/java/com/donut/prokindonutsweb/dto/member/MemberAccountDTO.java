package com.donut.prokindonutsweb.dto.member;

import lombok.*;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class MemberAccountDTO {

    private String memberCode;

    @NotBlank
    private String authorityCode;

    @NotBlank
    private String name;

   private String phoneNumber;

   @NotBlank
    @Email
    private String email;

    private String address;

    @NotBlank
    private String id;

    @NotBlank
    private String password;
}
