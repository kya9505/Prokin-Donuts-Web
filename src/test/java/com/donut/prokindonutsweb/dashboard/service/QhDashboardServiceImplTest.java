package com.donut.prokindonutsweb.dashboard.service;

import com.donut.prokindonutsweb.dashboard.mapper.QhDashboardMapper;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import static org.junit.jupiter.api.Assertions.*;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
class QhDashboardServiceImplTest {

    @Autowired
    private QhDashboardMapper mapper;

    @Test
    @DisplayName("미승인 회원가입 요청 건 수")
    void countNewRequest() {
        int countNewRequest = mapper.countNewRequest();
        assertNotNull(countNewRequest);
        log.info(countNewRequest);
    }

    @Test
    @DisplayName("미승인 입고 요청 건 수")
    void countNewInbound() {
        int countNewRequest = mapper.countNewInbound();
        assertNotNull(countNewRequest);
        log.info(countNewRequest);
    }

    @Test
    @DisplayName("총 가맹점 수 ")
    void totalFranchise() {
        int countNewRequest = mapper.totalFranchise();
        assertNotNull(countNewRequest);
        log.info(countNewRequest);
    }

    @Test
    @DisplayName("총 창고 수")
    void totalWarehouse() {
        int countNewRequest = mapper.totalWarehouse();
        assertNotNull(countNewRequest);
        log.info(countNewRequest);
    }
}