package com.donut.prokindonutsweb.dashboard.service;


import com.donut.prokindonutsweb.dashboard.dto.OrderInboundDTO;
import com.donut.prokindonutsweb.dashboard.dto.OutboundInventoryDTO;

import java.util.List;

public interface QhDashboardService {
    int countNewRequest();
    int countNewInbound();
    int totalFranchise();
    int totalWarehouse();
    // QhDashboardService.java
    List<OutboundInventoryDTO> getOrderRequestVsInventory();

    OrderInboundDTO getOrderInbound(String warehouseCode);

    String getWarehouseCode(String warehouse);

}