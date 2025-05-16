package com.donut.prokindonutsweb.dashboard.mapper;

import com.donut.prokindonutsweb.dashboard.dto.OrderInventoryDTO;

import java.util.List;

public interface QhDashboardMapper {
    int CountNewRequest();
    int CountNewInbound();
    int TotalFranchise();
    int TotalWarehouse();
    List<OrderInventoryDTO> getOrderRequestVsInventory();
    int countApprovedInboundStatus(String warehouseCode);
    int countTotalInbound(String warehouseCode);
    int countApprovedOrderStatus(String warehouseCode);
    int countTotalOrder(String warehouseCode);
    String getWarehouseCode(String warehouseCode);
}
