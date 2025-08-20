package com.donut.prokindonutsweb.order.service;

import com.donut.prokindonutsweb.inbound.dto.InboundDTO;
import com.donut.prokindonutsweb.inbound.dto.InboundDetailDTO;
import com.donut.prokindonutsweb.order.dto.OrderDTO;
import com.donut.prokindonutsweb.order.dto.OrderDetailDTO;
import com.donut.prokindonutsweb.order.vo.OrderDetailVO;

import java.util.List;

public interface OrderService {

    void addOrder(OrderDTO orderDTO, List<OrderDetailDTO> orderDetailDTO, String franchiseCode);

    String findNextOrderCode();
    String findFranchiseCode(String memberCode);

    List<OrderDTO>findOrderList(String FranchiseCode);

    List<OrderDetailDTO>findOrderDetailList(String orderCode);
    String findWarehouseCodeToFranchise(String franchiseCode);
    String findNextOutboundCode();
    void addOutbound(String warehouseCode, OrderDTO orderDTO, List<OrderDetailDTO> orderDetailList);

}
