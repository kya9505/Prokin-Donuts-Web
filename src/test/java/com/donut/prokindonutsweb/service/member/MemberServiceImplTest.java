package com.donut.prokindonutsweb.service.member;

import com.donut.prokindonutsweb.dto.member.MemberAccountDTO;
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
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
class MemberServiceImplTest {
    @Autowired
    private MemberService memberService;

    @Test
    @DisplayName("Service 회원 조회 테스트")
    public void loadMember(){
        Optional<List<MemberAccountDTO>> OmemberList = memberService.findMember();
        List<MemberAccountDTO> memberList = OmemberList.get();
        assertNotNull(memberList);
        memberList.forEach(log::info);
    }

    @Test
    @DisplayName("Service 회원 등록 DB 반영 테스트")
    public void saveMember(){
        MemberAccountDTO memberDTO = MemberAccountDTO.builder().memberCode("QH100")
                .authorityCode("QH")
                .name("100")
                .phoneNumber("100")
                .email("100")
                .address("100")
                .id("100")
                .password("100").build();
        memberService.saveMember(memberDTO);
    }

    @Test
    @DisplayName("Service 회원 수정 DB 반영 테스트")
    public void updateMember(){
        MemberAccountDTO memberDTO = MemberAccountDTO.builder()
                .memberCode("QH100")
                .authorityCode("QH")
                .name("200")
                .phoneNumber("200")
                .email("200")
                .address("200")
                .id("200")
                .password("200").build();

        List<MemberAccountDTO> list = new ArrayList<>();
        list.add(memberDTO);

        memberService.updateMember(list);
    }

    @Test
    @DisplayName("Service 회원 삭제 DB 반영 테스트")
    public void deleteMember(){
        List<String> memberCodeList = new ArrayList<>(Arrays.asList("QH100"));
        memberService.deleteMember(memberCodeList);
    }

    @Test
    @DisplayName("Service 회원 코드 생성 테스트")
    public void memberCode(){
        String qhMemberCode = memberService.memberCode("QH");
        String wmMemberCode = memberService.memberCode("WM");
        String fmMemberCode = memberService.memberCode("FM");
        log.info("qhMemberCode = " + qhMemberCode +
                "| wmMemberCode = " + wmMemberCode +
                "| fmMemberCode = " + fmMemberCode);
    }

}