package com.donut.prokindonutsweb.login.service;

import com.donut.prokindonutsweb.login.dto.VerificationCodeDTO;
import com.donut.prokindonutsweb.login.mapper.FindIdMapper;
import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import javax.mail.MessagingException;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RequiredArgsConstructor
public class FindIdServiceTest {
    @Autowired
    private FindService findService;

    @Test
    @DisplayName("이메일로 회원찾기")
    public void findEmail() {
        MemberAccountDTO member = findService.findEmail("fire123@gmail.com").orElseThrow();
        assertNotNull(member);
        log.info(member);
    }

    @Test
    @DisplayName("아이디로 회원찾기")
    public void findId() {
        MemberAccountDTO member = findService.findId("fire123").orElseThrow();
        assertNotNull(member);
        log.info(member);
    }

    @Test
    @DisplayName("이메일 발송 테스트")
    public void sendEmail() throws MessagingException, IOException {
        //30초 후 인증번호 만료
        VerificationCodeDTO code = VerificationCodeDTO.builder().code("12345").build();
        findService.sendEmail("dbsdk4211@naver.com", code);
    }

    @Test
    @DisplayName("6자리 랜덤한 코드 생성, 유효시간 10분 테스트")
    public void randomCode() {
        VerificationCodeDTO verificationCode = findService.randomCode();
        assertNotNull(verificationCode);
        log.info(verificationCode);

// Duration 계산
        long minutes = Duration.between(LocalDateTime.now(), verificationCode.getExpireTime()).toMinutes();
// 10분 이내 유효성 검증
        assertTrue(minutes <= 10 && minutes > 0);
    }


    @Test
    @DisplayName("생성된 코드와 발송 이메일, 회원객체 세션저장 테스트")
    public void testSaveCodeToSession() throws MessagingException, IOException {

        MemberAccountDTO member = MemberAccountDTO.builder()
                .id("test123")
                .email("dbsdk4211@naver.com")
                .name("홍길동")
                .build();

        String email = member.getEmail();
        //목세션
        MockHttpSession session = new MockHttpSession();


        findService.saveCodeToSession(member, email, session);

        // then
        VerificationCodeDTO authCode = (VerificationCodeDTO) session.getAttribute("authCode");
        String authEmail = (String) session.getAttribute("authEmail");
        MemberAccountDTO sessionMember = (MemberAccountDTO) session.getAttribute("member");

        assertNotNull(authCode);
        assertEquals(email, authEmail);
        assertEquals(member, sessionMember);

        VerificationCodeDTO code = (VerificationCodeDTO) authCode;
        assertFalse(code.isExpired()); // 생성 직후엔 당연히 유효해야 함
    }
}



