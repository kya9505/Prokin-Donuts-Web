package com.donut.prokindonutsweb.order.service;

import com.donut.prokindonutsweb.order.dto.OrderDTO;
import com.donut.prokindonutsweb.order.dto.OrderDetailDTO;
import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.mapper.OutboundMapper;
import com.donut.prokindonutsweb.outbound.service.OutboundService;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class OrderServiceImplTest {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OutboundMapper outboundMapper;

    @Test
    @DisplayName("Service 창고배치")
    void findWarehouseCodeToFranchise(){
       String warehouseCode1 = orderService.findWarehouseCodeToFranchise("SLF1");
        log.info(warehouseCode1);
       String warehouseCode2 = orderService.findWarehouseCodeToFranchise("JBF1");
        log.info(warehouseCode2);
       String warehouseCode3 = orderService.findWarehouseCodeToFranchise("ICF1");
        log.info(warehouseCode3);
       String warehouseCode4 = orderService.findWarehouseCodeToFranchise("GWF1");
        log.info(warehouseCode4);
       String warehouseCode5 = orderService.findWarehouseCodeToFranchise("GGF1");
        log.info(warehouseCode5);
       String warehouseCode6 = orderService.findWarehouseCodeToFranchise("DJF1");
        log.info(warehouseCode6);
       String warehouseCode7 = orderService.findWarehouseCodeToFranchise("CBF1");
        log.info(warehouseCode7);
    }


    @Test
    @DisplayName("Service 출고코드 생성")
    void findNextOutboundCode(){
        String lastOutboundCode = outboundMapper.selectOutboundCode();
        String outboundCode = orderService.findNextOutboundCode();
        log.info(lastOutboundCode);
        log.info(outboundCode);

    }
    @Test
    @DisplayName("Service 출고삽입")
    void addOutbound(){
        OrderDTO orderDTO = OrderDTO.builder()
                .orderCode("test100")
                .orderDate(LocalDate.now())
                .franchiseCode("test100")
                .build();
        OrderDetailDTO orderDetailDTO = OrderDetailDTO.builder()
                .OrderDetailCode("test100")
                .OrderCode("test100")
                .quantity(100)
                .storedType("냉동")
                .productCode("BGL1")
                .productName("test100")
                .orderStatus("배송준비")
                .productPrice(100)
                .build();
        List<OrderDetailDTO> orderDetailList = new ArrayList<>();
        orderDetailList.add(orderDetailDTO);

        orderService.addOutbound("BS1",orderDTO,orderDetailList);

    }
}