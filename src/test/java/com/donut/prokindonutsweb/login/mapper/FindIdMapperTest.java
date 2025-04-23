package com.donut.prokindonutsweb.login.mapper;

import com.donut.prokindonutsweb.home.mapper.FindIdMapper;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import static org.junit.jupiter.api.Assertions.*;


@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
class FindIdMapperTest {
    @Autowired
    private FindIdMapper mapper;

    @Test
    void searchId() {
        MemberAccountVO member = mapper.searchId("fire123");
        assertEquals(member.getMemberCode(),"FM1");
        log.info(member);
    }

    @Test
    void searchEmail() {
        MemberAccountVO member = mapper.searchEmail("fire123@gmail.com");
        assertEquals(member.getMemberCode(),"FM1");
        log.info(member);
    }
}