package com.donut.prokindonutsweb.order.service;

import com.donut.prokindonutsweb.inbound.dto.InboundDTO;
import com.donut.prokindonutsweb.inbound.dto.InboundDetailDTO;
import com.donut.prokindonutsweb.order.dto.OrderDTO;
import com.donut.prokindonutsweb.order.dto.OrderDetailDTO;

import java.util.List;

public interface OrderService {

    void addOrder(OrderDTO orderDTO, List<OrderDetailDTO> orderDetailDTO, String franchiseCode);

    String findNextOrderCode();

    String findFranchiseCode(String memberCode);
}
