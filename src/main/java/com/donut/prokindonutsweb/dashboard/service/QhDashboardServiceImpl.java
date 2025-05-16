package com.donut.prokindonutsweb.dashboard.service;

import com.donut.prokindonutsweb.dashboard.dto.OrderInboundDTO;
import com.donut.prokindonutsweb.dashboard.mapper.QhDashboardMapper;
import com.donut.prokindonutsweb.dashboard.dto.OrderInventoryDTO;
import com.donut.prokindonutsweb.warehouse.mapper.WarehouseMapper;
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
       return qhDashboardMapper.countNewRequest();
    }

    @Override
    public int CountNewInbound() {
        return qhDashboardMapper.countNewInbound();
    }

    @Override
    public int TotalFranchise() {
        return qhDashboardMapper.totalFranchise();
    }

    @Override
    public int TotalWarehouse() {
        return qhDashboardMapper.totalWarehouse();
    }

    //발주요청/입고량
    @Override
    public List<OrderInventoryDTO> getOrderRequestVsInventory() {
        return qhDashboardMapper.getOrderRequestVsInventory();
    }

    //입고/출고진행
    @Override
    public OrderInboundDTO getOrderInbound(String warehouseCode){
       return    OrderInboundDTO.builder()
                .receivedQuantity(qhDashboardMapper.countApprovedInboundStatus(warehouseCode))
                .totalInboundQuantity(qhDashboardMapper.countTotalInbound(warehouseCode))
                .orderedQuantity(qhDashboardMapper.countApprovedOrderStatus(warehouseCode))
                .totalOrderQuantity(qhDashboardMapper.countTotalOrder(warehouseCode))
                .build();
    }
    //창고이믈 -> 번호로 변환
    @Override
    public String getWarehouseCode(String warehouse) {
        return qhDashboardMapper.getWarehouseCode(warehouse);
    }


}
