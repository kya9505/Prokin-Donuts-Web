package com.donut.prokindonutsweb.dashboard.service;

import com.donut.prokindonutsweb.dashboard.mapper.QhDashboardMapper;
import com.donut.prokindonutsweb.dashboard.dto.OrderInventoryDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class QhDashboardServiceImpl implements QhDashboardService {
    private final QhDashboardMapper qhDashboardMapper;

    @Override
    public int CountNewRequest() {
       return qhDashboardMapper.CountNewRequest();
    }

    @Override
    public int CountNewInbound() {
        return qhDashboardMapper.CountNewInbound();
    }

    @Override
    public int TotalFranchise() {
        return qhDashboardMapper.TotalFranchise();
    }

    @Override
    public int TotalWarehouse() {
        return qhDashboardMapper.TotalWarehouse();
    }

    @Override
    public List<OrderInventoryDTO> getOrderRequestVsInventory() {
        return qhDashboardMapper.getOrderRequestVsInventory();
    }
}
