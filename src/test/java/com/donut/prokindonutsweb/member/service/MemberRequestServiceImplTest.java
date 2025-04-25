package com.donut.prokindonutsweb.member.service;

import com.donut.prokindonutsweb.home.service.SignupService;
import com.donut.prokindonutsweb.member.dto.MemberRequestDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.util.AssertionErrors.assertNotNull;

@Log4j2
@ExtendWith(SpringExtension.class)
@RequiredArgsConstructor
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml")
class MemberRequestServiceImplTest {
    @Autowired
    private MemberRequestService requestService;
    private SignupService signupService;

    @Test
    @DisplayName("Service 회원가입 요청 조회 테스트")
    void findRequestMember() {
        List<MemberRequestDTO> list = requestService.findRequestMember().get();
        assertNotNull("List 정상 조회 ",list);
        list.forEach(log::info);
    }

    @Test
    @DisplayName("Service 회원가입 요청 승인 테스트")
    void approvalMember() {
        List<String> approvalList = new ArrayList<>(Arrays.asList("RQ06","RQ07","RQ08"));
        requestService.approvalMember(approvalList);
    }

    @Test
    @DisplayName("Service 회원가입 요청테이블 아이디 중복 테스트")
    public void requestIdCheck(){
        int idCheck = requestService.requestIdCheck("100");

        log.info(idCheck);
    }

    @Test
    @DisplayName("Service 회원가입 요청테이블 이메일  중복 테스트")
    public void requestEmailCheck(){
        int emailCheck = requestService.requestEmailCheck("test@test.test");
        assertEquals(emailCheck,1);
        log.info(emailCheck);
    }
}