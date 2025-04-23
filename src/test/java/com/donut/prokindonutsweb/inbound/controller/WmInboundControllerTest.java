package com.donut.prokindonutsweb.inbound.controller;


import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

@Log4j2
@ExtendWith(SpringExtension.class)
@Transactional
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
class WmInboundControllerTest {
    @Autowired
    private WmInboundController wmInboundController;

    @Test
    void wmApproveInbound() {

    }

}