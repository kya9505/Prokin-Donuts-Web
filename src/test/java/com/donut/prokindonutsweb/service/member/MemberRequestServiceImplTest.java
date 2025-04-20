package com.donut.prokindonutsweb.service.member;

import com.donut.prokindonutsweb.dto.member.MemberRequestDTO;
import com.donut.prokindonutsweb.vo.member.MemberRequestVO;
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

import static org.springframework.test.util.AssertionErrors.assertNotNull;

@Log4j2
@ExtendWith(SpringExtension.class)
@RequiredArgsConstructor
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml")
class MemberRequestServiceImplTest {
    @Autowired
    private MemberRequestService requestService;

    @Test
    @DisplayName("Service 회원가입 요청 조회 테스트")
    void findRequestMember() {
        List<MemberRequestDTO> list = requestService.findRequestMember().get();
        assertNotNull("List 정상 조회 ",list);
        list.forEach(log::info);
    }

    @Test
    @DisplayName("Service 회원가입 요청 코드 생성 테스트")
    void memberRequestCode() {
        String requestCode = requestService.memberRequestCode();
        log.info(requestCode);
    }

    @Test
    @DisplayName("Service 회원가입 요청 승인 테스트")
    void approvalMember() {
        List<String> approvalList = new ArrayList<>(Arrays.asList("RQ06","RQ07","RQ08"));
        requestService.approvalMember(approvalList);
    }
}