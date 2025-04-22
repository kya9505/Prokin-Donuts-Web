package com.donut.prokindonutsweb.login.service;

import com.donut.prokindonutsweb.login.dto.VerificationCodeDTO;
import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;

import javax.servlet.http.HttpSession;
import java.util.Optional;

public interface FindService {
    Optional<MemberAccountDTO> findId(String inputEmail);
    Optional<MemberAccountDTO> findPassword(String inputId);
    void sendEmail(String toEmail,VerificationCodeDTO code);
    VerificationCodeDTO randomCode();

   void saveCodeToSession(MemberAccountDTO member,String email, HttpSession session);
}
