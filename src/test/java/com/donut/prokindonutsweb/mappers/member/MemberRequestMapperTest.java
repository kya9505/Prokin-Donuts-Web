package com.donut.prokindonutsweb.mappers.member;

import com.donut.prokindonutsweb.vo.member.MemberRequestVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RequiredArgsConstructor
class MemberRequestMapperTest {

    @Autowired
    private MemberRequestMapper mapper;

    @Test
    @DisplayName("DB의 전체 회원가입요청 조회 테스트")
    void selectRequestMember() {
        List<MemberRequestVO> memberList = mapper.selectRequestMember();
        memberList.forEach(log::info);
    }

    @Test
    @DisplayName("회원 가입요청상태 승인 DB 반영 테스트 ")
    void approvalMember() {
        mapper.approvalMember("RQ06");
      }

    @Test
    @DisplayName("회원 삭제 DB 반영 테스트")
    void deleteRequestMember() {
        mapper.deleteRequestMember("RQ06");
    }

    @Test
    void requestCode() {
        String maxRequestCode = mapper.requestCode();
        assertEquals("RQ06", maxRequestCode);
        log.info(maxRequestCode);
    }
}