package com.donut.prokindonutsweb.outbound.mapper;

import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.dto.VehicleDTO;
import com.donut.prokindonutsweb.outbound.dto.VehicleScheduleDTO;
import com.donut.prokindonutsweb.outbound.vo.OutboundVO;
import com.donut.prokindonutsweb.outbound.vo.VehicleScheduleVO;
import com.donut.prokindonutsweb.outbound.vo.VehicleVO;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDate;
import java.util.List;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class OutboundMapperTest {

    @Autowired(required = false)
    private OutboundMapper outboundMapper;

    @Test
    @DisplayName("출고 목록 반환 메서드 테스트")
    void selectAllOutboundList() {
        outboundMapper.selectAllOutboundList("DJ1").forEach(System.out::println);
    }


    @Test
    @DisplayName("재고 존재 여부 반환 메서드 ")
    void checkInventory() {
        boolean OB006 = outboundMapper.checkInventory("OB006");
        log.info(String.valueOf(OB006));
    }

    @Test
    @DisplayName("창고코드 반환")
    void getWarehouseCode() {
        String warehouseCode = outboundMapper.getWarehouseCode("WM1");
        log.info(warehouseCode);
    }


    @Test
    @DisplayName("출고 승인 목록 반환 메서드 테스트")
    void selectApprovalOutboundList() {
        List<OutboundDTO> outboundDTOList = outboundMapper.selectApprovalOutboundList("DJ1");
        outboundDTOList.forEach(dto -> log.info("출고정보: {}", dto));
    }

    @Test
    @DisplayName("출고 준비 목록 반환 메서드 테스트")
    void findCompletionOutboundList() {
        List<OutboundDTO> outboundDTOList = outboundMapper.selectCompletionOutboundList("DJ1");
        outboundDTOList.forEach(dto -> log.info("출고정보: {}", dto));
    }


    @Test
    @DisplayName("출고 제품의 보관타입 반환")
    void selectStoredType() {
        String storedType = outboundMapper.selectStoredType("OB001");
        log.info(storedType);
    }

    @Test
    @DisplayName("섹션코드 존재 여부 반환 메서드 ")
    void checkSection() {
        boolean GG1R = outboundMapper.checkSection("GG1-R");
        log.info(String.valueOf(GG1R));
    }

    @Test
    @DisplayName("섹션 원복")
    void updateSection() {
        outboundMapper.updateSection("GG1-R",50);

    }

    @Test
    @DisplayName("출고 삽입")
    void insertOutbound() {
        OutboundVO outboundVO = OutboundVO.builder()
                .outboundCode("test")
                .outboundDate(LocalDate.now())
                .outboundStatus("출고대기")
                .quantity(30)
                .orderDetailCode("test")
                .inventoryCode("test")
                .build();
        outboundMapper.insertOutbound(outboundVO);
    }


    @Test
    @DisplayName("최신출고코드 조회")
    void selectOutboundCode(){
        String outboundCode = outboundMapper.selectOutboundCode();
        log.info(outboundCode);
    }


    @Test
    @DisplayName("출고 반환 메서드 테스트")
    void selectOutboundOne() {
        OutboundVO outboundVO = outboundMapper.selectOutboundVoOne("OB001");
        OutboundDTO outboundDTO = outboundMapper.selectOutboundDtoOne("OB001");

        log.info("outboundVO : {}", outboundVO);
        log.info("outboundDTO : {}", outboundDTO);
    }

    @Test
    @DisplayName("배치 차량 조회")
    void selectVehicleCode(){
        VehicleDTO vehicleDTO = VehicleDTO.builder()
                .storedType("냉장")
                .warehouseCode("GG1")
                .outboundDate(LocalDate.parse("2025-01-13"))
                .outboundCode("OB005")
                .quantity(45)
                .build();
        VehicleScheduleDTO vehicleScheduleDTO = outboundMapper.selectVehicle(vehicleDTO);
        log.info("vehicleScheduleDTO : {}",vehicleScheduleDTO);
    }

    @Test
    @DisplayName("출고일포함 3일내 스케쥴에 등록되어있는 차량 수 ")
    void countRegisteredVehicleSchedule(){
        VehicleDTO vehicleDTO = VehicleDTO.builder()
                .storedType("냉장")
                .warehouseCode("GG1")
                .outboundDate(LocalDate.parse("2025-01-13"))
                .outboundCode("OB005")
                .quantity(45)
                .build();
        int countRegisteredVehicleSchedule = outboundMapper.countRegisteredVehicleSchedule(vehicleDTO);
        log.info(String.valueOf(countRegisteredVehicleSchedule));
    }
    @Test
    @DisplayName("해당 창고의 보관타입이 일치하는 차량 수 조회  ")
    void countAllVehiclesInWarehouse(){
        VehicleDTO vehicleDTO = VehicleDTO.builder()
                .storedType("냉장")
                .warehouseCode("GG1")
                .outboundDate(LocalDate.parse("2025-01-13"))
                .outboundCode("OB005")
                .quantity(45)
                .build();
        int countAllVehiclesInWarehouse = outboundMapper.countAllVehiclesInWarehouse(vehicleDTO);
        log.info(String.valueOf(countAllVehiclesInWarehouse));
    }

    @Test
    @DisplayName("차량DTO조회")
    void getVehicleDTO(){
        VehicleDTO vehicleDTO = outboundMapper.getVehicleDTO("OB005");
        log.info("vehicleDTO : {}",vehicleDTO);
    }
    @Test
    @DisplayName("차량VO조회")
    void getVehicleVO(){
        List<VehicleVO> vehicleVOs = outboundMapper.getVehicleVO("GG1");
        vehicleVOs.forEach(vehicleVO -> log.info("vehicleVO : {}",vehicleVO));
    }

    @Test
    @DisplayName("최신차량 스케줄 코드 조회")
    void selectVehicleScheduleCode(){
        String code = outboundMapper.selectVehicleScheduleCode();
        log.info(code);
    }

    @Test
    @DisplayName("차량스케줄코드 등록(잔여 적재량 차감)")
    void updateVehicleSchedule(){
        VehicleScheduleDTO vehicleScheduleDTO = VehicleScheduleDTO.builder()
                .vehicleCode("V010")
                .dispatchDate(LocalDate.parse("2025-01-13"))
                .quantity(45)
                .build();
        outboundMapper.updateVehicleSchedule(vehicleScheduleDTO);
    }


    @Test
    @DisplayName("출고일 변경 ")
    void updateOutboundDate(){
        outboundMapper.updateOutboundDate(LocalDate.parse("2027-01-01"),"OB001");

    }
}