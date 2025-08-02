package com.donut.prokindonutsweb.inbound.service;

import com.donut.prokindonutsweb.inbound.dto.InboundDTO;
import com.donut.prokindonutsweb.inbound.dto.InboundDetailDTO;
import com.donut.prokindonutsweb.inbound.dto.InboundUpdateDTO;
import com.donut.prokindonutsweb.inbound.dto.InventoryDTO;
import com.donut.prokindonutsweb.inbound.vo.InventoryVO;
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
import org.springframework.transaction.annotation.Transactional;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
class InboundServiceImplTest {

    @Autowired
    private InboundService inboundService;
    @Test
    @DisplayName("findAllProductList service 호출(VO->DTO)")
    void findAllProductList() {
        inboundService.findProductList()
                .stream()
                .flatMap(List::stream)
                .forEach(dto -> log.info("DTO: {}", dto));
    }

    @Test
    @DisplayName("다음 입고코드 번호 반환 기능")
    void findNextInboundCode() {
        String nextInboundCode = inboundService.findNextInboundCode();
        log.info(nextInboundCode);
    }

    /*@Test
    @DisplayName("saveInbound 메서드 호출 테스트")
    void saveInbound() {
        InboundDTO dto = InboundDTO.builder()
                .inboundCode(inboundService.findNextInboundCode())
                .inboundDate(LocalDate.parse("2025-04-30"))
                .inboundStatus("입고요청")
                .warehouseCode("GG1")
                .build();
        inboundService.saveInboundbefore(dto);
    }*/

    @Test
    @DisplayName("입고 등록 메서드 호출")
    void addInbound() {
        String nextInboundCode = inboundService.findNextInboundCode();
        InboundDTO dto = InboundDTO.builder()
                .inboundCode(nextInboundCode)
                .inboundDate(LocalDate.parse("2025-04-30"))
                .inboundStatus("입고요청")
                .warehouseCode("GG1")
                .build();

        InboundDetailDTO dto1 = InboundDetailDTO.builder()
                .inboundCode(nextInboundCode)
                .productCode("DPN1")
                .productName("테스트1")
                .productPrice(5000)
                .storedType("냉동")
                .quantity(300)
                .build();

        InboundDetailDTO dto2 = InboundDetailDTO.builder()
                .inboundCode(nextInboundCode)
                .productCode("DPN2")
                .productName("테스트2")
                .productPrice(5000)
                .storedType("냉장")
                .quantity(300)
                .build();

        List<InboundDetailDTO> list = new ArrayList<>();
        list.add(dto1);
        list.add(dto2);

        inboundService.addInbound(dto, list);

    }

    @Test
    @DisplayName("멤버코드 -> 창고코드 반환 서비스")
    void getWarehouseCode() {
        String warehouseCode = inboundService.getWarehouseCode("WM1");
        log.info(warehouseCode);
    }


    @Test
    @DisplayName("(입고요청, 승인대기) 상태 입고목록만 반환하는 기능")
    void findAllInboundList() {
        inboundService.findInboundList("WM1").forEach(System.out::println);
    }

    @Test
    @DisplayName("입고 상세 목록 반환")
    void findAllInboundDetailList() {
        inboundService.findInboundDetailList().forEach(System.out::println);
    }

    @Test
    @DisplayName("입고 상태 변환(-> 완료)")
    void approveInbound() {
        inboundService.approveInbound("IN2");
    }

    @Test
    @DisplayName("입고 수정 (수량, 날짜)")
    void updateInbound() {
        List<InboundUpdateDTO> list = new ArrayList<>();
        InboundUpdateDTO dto1 = InboundUpdateDTO.builder()
                .inboundCode("IN1")
                .productCode("DLW1")
                .quantity(100)
                .build();

        InboundUpdateDTO dto2 = InboundUpdateDTO.builder()
                .inboundCode("IN1")
                .productCode("DLW2")
                .quantity(100)
                .build();
        list.add(dto1);
        list.add(dto2);

        inboundService.updateInbound(list, LocalDate.parse("2025-05-05"));
    }

    @Test
    @DisplayName("입고 상세 목록 리스트 반환(재고반영에 필요)")
    void findInboundDetailList() {
        inboundService.findInboundDetailList("IN1").get().forEach(System.out::println);
    }

    @Test
    @DisplayName("입고 취소 상태변환 (-> 입고취소)")
    void deleteInbound() {
        inboundService.deleteInbound("IN6");
    }

    @Test
    @DisplayName("입고현황 목록 반환")
    void findAllInboundStatusList() {
        inboundService.findInboundStatusList().ifPresent(System.out::println);
    }

    @Test
    @DisplayName("입고완료시 재고 반영 테스트")
    void updateInventory() {
        List<InventoryDTO> list = new ArrayList<>();

        InventoryDTO dto1 = InventoryDTO.builder()
                .warehouseCode("GG1")
                .quantity(400)
                .productCode("DGL3")
                .build();
        list.add(dto1);

//        InventoryDTO dto2 = InventoryDTO.builder()
//                .warehouseCode("GG1")
//                .quantity(400)
//                .productCode("DGL3")
//                .build();
//        list.add(dto2);
        inboundService.updateInventory(list);
    }

}