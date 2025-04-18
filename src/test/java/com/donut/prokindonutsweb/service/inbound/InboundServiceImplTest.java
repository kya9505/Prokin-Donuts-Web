package com.donut.prokindonutsweb.service.inbound;

import com.donut.prokindonutsweb.dto.inbound.ProductDTO;
import com.donut.prokindonutsweb.dto.inbound.ProductVO;
import com.donut.prokindonutsweb.mappers.inbound.InboundMapper;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
class InboundServiceImplTest {

    @Autowired
    private InboundService inboundService;
    @Test
    @DisplayName("findAllProductList service 호출(VO->DTO)")
    void findAllProductList() {
        inboundService.findAllProductList()
                .stream()
                .flatMap(List::stream)
                .forEach(dto -> log.info("DTO: {}", dto));
    }

    @Test
    @DisplayName("다음 입고코드 번호 반환 기능")
    void findNextInboundCode() {
        String nextInboundCode = inboundService.findNextInboundCode();
        log.info(nextInboundCode);
    }
}