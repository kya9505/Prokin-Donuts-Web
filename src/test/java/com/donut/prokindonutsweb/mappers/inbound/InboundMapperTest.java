package com.donut.prokindonutsweb.mappers.inbound;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

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
}