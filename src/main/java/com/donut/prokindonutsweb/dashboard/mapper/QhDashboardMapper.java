package com.donut.prokindonutsweb.dashboard.mapper;

import com.donut.prokindonutsweb.dashboard.dto.OutboundInventoryDTO;

import java.util.List;

public interface QhDashboardMapper {
    int countNewRequest();
    int countNewInbound();
    int totalFranchise();
    int totalWarehouse();
    List<OrderInventoryDTO> getOrderRequestVsInventory();
    int countApprovedInboundStatus(String warehouseCode);
    int countTotalInbound(String warehouseCode);
    int countApprovedOrderStatus(String warehouseCode);
    int countTotalOrder(String warehouseCode);
    String getWarehouseCode(String warehouseCode);
}
