package com.donut.prokindonutsweb.dashboard.mapper;

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
class QhDashboardMapperTest {
    @Autowired
    private QhDashboardMapper qhDashboardMapper;

    @Test
    void countApprovedInboundStatus() {
        int count = qhDashboardMapper.countApprovedInboundStatus("GG1");
        log.info(count);
    }

    @Test
    void countTotalInbound() {
        int count = qhDashboardMapper.countTotalInbound("GG1");
        log.info(count);

    }

    @Test
    void countApprovedOrderStatus() {
        int count = qhDashboardMapper.countApprovedOrderStatus("GG1");
        log.info(count);
    }

    @Test
    void countTotalOrder() {
        int count = qhDashboardMapper.countTotalOrder("GG1");
        log.info(count);
    }
}