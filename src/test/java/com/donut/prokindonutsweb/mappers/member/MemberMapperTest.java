package com.donut.prokindonutsweb.mappers.member;

import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.ArrayList;
import java.util.List;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RequiredArgsConstructor
class MemberMapperTest {

    @Autowired
    private MemberMapper mapper;


    //loadMember MapperTest
    @Test
    public void loadMember(){
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

        List<MemberAccountVO> list = new ArrayList<>();
        list.add(memberAccountVO);

        mapper.updateMember(list);
    }

    @Test
    @DisplayName("회원 삭제 DB 반영 테스트")
    public void deleteMember(){
        mapper.deleteMember("QH100");
    }
}