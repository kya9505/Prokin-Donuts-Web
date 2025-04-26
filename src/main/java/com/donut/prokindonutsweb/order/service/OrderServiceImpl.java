package com.donut.prokindonutsweb.order.service;

import com.donut.prokindonutsweb.order.dto.OrderDTO;
import com.donut.prokindonutsweb.order.dto.OrderDetailDTO;
import com.donut.prokindonutsweb.order.mapper.OrderMapper;
import com.donut.prokindonutsweb.order.vo.OrderDetailVO;
import com.donut.prokindonutsweb.order.vo.OrderVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
    private final OrderMapper orderMapper;

    @Transactional
    @Override
    public void addOrder(OrderDTO orderDTO, List<OrderDetailDTO> orderDetailList, String franchiseCode) {
        OrderVO orderVO = OrderVO.builder()
                .orderCode(orderDTO.getOrderCode())
                .orderDate(orderDTO.getOrderDate())
                .orderStatus(orderDTO.getOrderStatus())
                .franchiseCode(franchiseCode)
                .warehouseCode(orderDTO.getWarehouseCode())
                .build();
        orderMapper.insertOrder(orderVO);
        log.info(orderDTO.getOrderCode());
        List<OrderDetailVO> orderDetailVOList = getOrderDetailList(orderDTO, orderDetailList);
        orderMapper.insertOrderDetailList(orderDetailVOList);
    }

    private static List<OrderDetailVO> getOrderDetailList(OrderDTO orderDTO, List<OrderDetailDTO> orderDetailList) {
        AtomicInteger i = new AtomicInteger(1);
        String orderCode = orderDTO.getOrderCode();

        return orderDetailList.stream()
                .map(dto -> OrderDetailVO.builder()
                        .orderDetailCode(orderCode + "-" + i.getAndIncrement())
                        .quantity(dto.getQuantity())
                        .orderCode(orderCode)
                        .productCode(dto.getProductCode())
                        .build()
                ).toList();
    }

    @Override
    public String findNextOrderCode() {
        String orderCode = orderMapper.selectOrderCode();
        int number = Integer.parseInt(orderCode.replaceAll("\\D", ""));
        return "ORD" + (number + 1);
    }

    @Override
    public String findFranchiseCode(String memberCode) {
        return orderMapper.selectFranchiseCode(memberCode);
    }
}
