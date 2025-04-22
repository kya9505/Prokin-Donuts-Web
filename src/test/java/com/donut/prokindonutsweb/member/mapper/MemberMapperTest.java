package com.donut.prokindonutsweb.member.mapper;

import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
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

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RequiredArgsConstructor
class MemberMapperTest {

    @Autowired
    private MemberMapper mapper;


    //loadMember MapperTest
    @Test
    @DisplayName("DB의 전체 회원조회 테스트")
    public void selectMember(){
        List<MemberAccountVO> memberList = mapper.selectMember();
        memberList.forEach(log::info);
    }

    @Test
    @DisplayName("회원등록 DB 반영 테스트")
    public void insertMember(){
        MemberAccountVO memberAccountVO = MemberAccountVO.builder().memberCode("QH100")
                .authorityCode("QH")
                .name("100")
                .phoneNumber("100")
                .email("100")
                .address("100")
                .id("100")
                .password("100").build();

        mapper.insertMember(memberAccountVO);
    }

    @Test
    @DisplayName("회원수정 DB 반영 테스트")
    public void updateMember(){
        MemberAccountVO memberAccountVO = MemberAccountVO.builder()
                .memberCode("QH100")
                .authorityCode("QH")
                .name("200")
                .phoneNumber("200")
                .email("200")
                .address("200")
                .id("200")
                .password("200").build();


        mapper.updateMember(memberAccountVO);
    }

    @Test
    @DisplayName("회원 삭제 DB 반영 테스트")
    public void deleteMember(){
        List<String> memberCodeList = new ArrayList<>(Arrays.asList("QH100"));
        mapper.deleteMember(memberCodeList);
    }

    @Test
    @DisplayName("DB의 가장 높은 수의 회원 코드 select 테스트")
    void memberCode() {
        String maxRequestCode = mapper.memberCode();
        assertEquals("QH100", maxRequestCode);
        log.info(maxRequestCode);
    }

    @Test
    @DisplayName("회원 Id 중복체크 테스트")
    public void memberIdCheck(){
        int idCheck = mapper.memberIdCheck("ahyun90");
        assertEquals(idCheck,1);
        log.info(idCheck);
    }

    @Test
    @DisplayName("회원 Email 중복체크 테스트")
    public void memberEmailCheck(){
        int emailCheck = mapper.memberEmailCheck("gayoung_fm4@gmail.com");
        assertEquals(emailCheck,1);
        log.info(emailCheck);
    }
}