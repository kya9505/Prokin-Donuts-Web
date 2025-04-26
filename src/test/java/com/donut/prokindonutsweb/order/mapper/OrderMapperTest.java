package com.donut.prokindonutsweb.order.mapper;

import com.donut.prokindonutsweb.inbound.dto.InboundDetailVO;
import com.donut.prokindonutsweb.inbound.mapper.InboundMapper;
import com.donut.prokindonutsweb.inbound.vo.InboundVO;
import com.donut.prokindonutsweb.order.vo.OrderDetailVO;
import com.donut.prokindonutsweb.order.vo.OrderVO;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class OrderMapperTest {

    @Autowired(required = false)
    private OrderMapper orderMapper;


    @Test
    @DisplayName("발주내역 DB 저장 테스트")
    void insertOrder() {
        OrderVO vo = OrderVO.builder()
                .orderCode("ORD9")
                .orderDate(LocalDate.parse("2025-04-20"))
                .orderStatus("출고대기")
                .franchiseCode("DJF1")
                .warehouseCode("GG1")
                .build();

        orderMapper.insertOrder(vo);
    }

    @Test
    @DisplayName("발주상세 내역 List DB 저장 테스트")
    void insertInboundDetail() {
        OrderDetailVO vo1 = OrderDetailVO.builder()
                .orderDetailCode("ORD6-1")
                .quantity(200)
                .orderCode("ORD6")
                .productCode("DPN1")
                .build();

        OrderDetailVO vo2 = OrderDetailVO.builder()
                .orderDetailCode("ORD6-2")
                .quantity(300)
                .orderCode("ORD6")
                .productCode("DPN3")
                .build();
        List<OrderDetailVO> list = new ArrayList<>();
        list.add(vo1);
        list.add(vo2);

        orderMapper.insertOrderDetailList(list);
    }

    @Test
    @DisplayName("최신 발주코드 반환")
    void selectOrderCode() {
        String code = orderMapper.selectOrderCode();
        log.info(code);
    }

    @Test
    @DisplayName("멤버코드 -> 가맹점 코드 반환")
    void selectFranchiseCode() {
        String franchiseCode = orderMapper.selectFranchiseCode("FM1");
        log.info(franchiseCode);
    }

}
