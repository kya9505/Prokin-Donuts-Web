package com.donut.prokindonutsweb.controller.inbound;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.*;

@Log4j2
@ExtendWith(SpringExtension.class)
@Transactional
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
class InboundControllerTest {
    @Autowired
    private InboundController inboundController;

    @Test
    void wmApproveInbound() {

    }

}