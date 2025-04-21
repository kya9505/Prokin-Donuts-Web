package com.donut.prokindonutsweb.login.service;

import com.donut.prokindonutsweb.member.dto.MemberRequestDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import static org.junit.jupiter.api.Assertions.*;
@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RequiredArgsConstructor
class SignupServideImplTest {
    @Autowired
    private SignupService signupService;

    @Test
    @DisplayName("Service 회원가입 요청 테스트")
    void saveMemberRequset() {
        MemberRequestDTO dto = MemberRequestDTO.builder()
                .id("test2")
                .email("test2")
                .name("test2")
                .address("test2")
                .phoneNumber("test2")
                .password("test2")
                .build();
        signupService.saveMemberRequset(dto);
    }

    @Test
    @DisplayName("Service 회원가입 요청 코드 생성 테스트")
    void memberRequestCode() {
        String requestCode = signupService.memberRequestCode();
        log.info(requestCode);
    }

}