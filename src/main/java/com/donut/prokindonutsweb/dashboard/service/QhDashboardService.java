package com.donut.prokindonutsweb.dashboard.service;


import com.donut.prokindonutsweb.dashboard.dto.OrderInventoryDTO;

import java.util.List;

public interface QhDashboardService {
    int CountNewRequest();
    int CountNewInbound();
    int TotalFranchise();
    int TotalWarehouse();
    // QhDashboardService.java
    List<OrderInventoryDTO> getOrderRequestVsInventory();


}
