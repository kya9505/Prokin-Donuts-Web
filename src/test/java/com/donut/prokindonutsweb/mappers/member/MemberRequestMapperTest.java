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
import static org.junit.jupiter.api.Assertions.assertNotNull;

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
    @DisplayName("회원 가입요청 삭제 DB 반영 테스트")
    void deleteRequestMember() {
        mapper.deleteRequestMember("RQ06");
    }

    @Test
    @DisplayName("DB의 가장 높은 수의 가입요청코드 select 테스트")
    void requestCode() {
        String maxRequestCode = mapper.requestCode();
        assertEquals("RQ06", maxRequestCode);
        log.info(maxRequestCode);
    }

    @Test
    @DisplayName("회원가입 요청 코드로 객체 조회 테스트")
    public void selectByMemberRequest(){
        MemberRequestVO memberRequestVO = mapper.selectByMemberRequest("RQ06");
        assertNotNull(memberRequestVO);
        log.info(memberRequestVO);
    }
}