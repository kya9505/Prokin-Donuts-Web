package com.donut.prokindonutsweb.login.service;

import com.donut.prokindonutsweb.login.dto.VerificationCodeDTO;
import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import java.io.FileNotFoundException;
import java.util.Optional;

public interface FindService {
    Optional<MemberAccountDTO> findEmail(String inputEmail);
    Optional<MemberAccountDTO> findId(String inputId);
    void sendEmail(String toEmail,VerificationCodeDTO code) throws MessagingException, FileNotFoundException;
    VerificationCodeDTO randomCode();

   void saveCodeToSession(MemberAccountDTO member,String email, HttpSession session) throws MessagingException, FileNotFoundException;
}
