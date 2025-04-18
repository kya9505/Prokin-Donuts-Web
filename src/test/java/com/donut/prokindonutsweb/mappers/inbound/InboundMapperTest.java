package com.donut.prokindonutsweb.mappers.inbound;

import com.donut.prokindonutsweb.dto.inbound.InboundDetailVO;
import com.donut.prokindonutsweb.dto.inbound.InboundVO;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml")
class InboundMapperTest {

    @Autowired(required = false)
    private InboundMapper inboundMapper;
    @Test
    void mapper() {
        inboundMapper.selectAllProductList().forEach(System.out::println);
    }

    @Test
    @DisplayName("입고 내역 DB 저장 테스트")
    void insertInbound() {
        InboundVO vo = InboundVO.builder()
                .inboundCode("IN7")
                .inboundDate(Date.valueOf("2025-04-20"))
                .inboundStatus("입고대기")
                .warehouseCode("GG1")
                .build();

        inboundMapper.insertInbound(vo);
    }

    @Test
    @DisplayName("입고상세 내역 List DB 저장 테스트")
    void insertInboundDetail() {
        InboundDetailVO dto1 = InboundDetailVO.builder()
                .inboundDetailCode("In1-7")
                .quantity(200)
                .inboundCode("In1")
                .productCode("DPN1")
                .sectionCode("GG1-R")
                .build();

        InboundDetailVO dto2 = InboundDetailVO.builder()
                .inboundDetailCode("In1-8")
                .quantity(300)
                .inboundCode("In1")
                .productCode("DPN3")
                .sectionCode("GG1-R")
                .build();
        List<InboundDetailVO> list = new ArrayList<>();
        list.add(dto1);
        list.add(dto2);

        inboundMapper.insertInboundDetailList(list);
    }

    @Test
    @DisplayName("다음 입고 코드 반환 테스트")
    void selectInboundCode() {
        String s = inboundMapper.selectInboundCode();
        System.out.println(s);
    }
}