package com.donut.prokindonutsweb.dashboard.service;

import com.donut.prokindonutsweb.dashboard.mapper.QhDashboardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@Log4j2
@RequiredArgsConstructor
public class QhDashboardServiceImpl implements QhDashboardService {
    private final QhDashboardMapper mapper;

    @Override
    public int CountNewRequest() {
       return mapper.CountNewRequest();
    }

    @Override
    public int CountNewInbound() {
        return mapper.CountNewInbound();
    }

    @Override
    public int TotalFranchise() {
        return mapper.TotalFranchise();
    }

    @Override
    public int TotalWarehouse() {
        return mapper.TotalWarehouse();
    }
}
