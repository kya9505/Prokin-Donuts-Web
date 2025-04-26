package com.donut.prokindonutsweb.outbound.mapper;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class OutboundMapperTest {

    @Autowired(required = false)
    private OutboundMapper outboundMapper;

    @Test
    @DisplayName("출고 목록 반환 메서드 테스트")
    void selectAllOutboundList() {
        outboundMapper.selectAllOutboundList("GG1").forEach(System.out::println);
    }

    @Test
    @DisplayName("출고상세 목록 반환 메서드 테스트")
    void selectAllOutboundDetailList() {
        outboundMapper.selectAllOutboundDetailList().forEach(System.out::println);
    }

    @Test
    @DisplayName("재고 존재 여부 반환 메서드 ")
    void checkInventory() {
        boolean ord2 = outboundMapper.checkInventory("ORD6");
        log.info(String.valueOf(ord2));
    }
}
