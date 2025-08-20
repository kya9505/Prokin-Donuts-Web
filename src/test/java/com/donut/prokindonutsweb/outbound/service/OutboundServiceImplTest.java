package com.donut.prokindonutsweb.outbound.service;

import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.dto.VehicleDTO;
import com.donut.prokindonutsweb.outbound.dto.VehicleScheduleDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDate;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class OutboundServiceImplTest {

    @Autowired
    private  OutboundService outboundService;

    @Test
    @DisplayName("Service 출고목록 조회")
    public void findOutboundList(){
        List<OutboundDTO> outboundList = outboundService.findOutboundList("DJ1");
        assertNotNull(outboundList);
        outboundList.forEach(log::info);
    }
    @Test
    @DisplayName("Service 출고요청 목록 조회")
    public void findApprovalOutboundList(){
        List<OutboundDTO> outboundList = outboundService.findApprovalOutboundList("DJ1");
        outboundList.forEach(log::info);
    }

    @Test
    @DisplayName("Service 출고준비 목록 조회")
    public void findCompletionOutboundList(){
        List<OutboundDTO> outboundList = outboundService.findCompletionOutboundList("DJ1");
        outboundList.forEach(log::info);
    }


    @Test
    @DisplayName("보관타입 조회")
    public void findStoredType(){
       String storedType =  outboundService.findStoredType("OB001");
        log.info(storedType);
    }

    @Test
    @DisplayName("섹션코드 생성")
    public void getSectionCode(){
       String sectionCode = outboundService.getSectionCode("GG1","OB001");
        log.info(sectionCode);
    }

    @Test
    @DisplayName("출고요청일 2일 이전까지 창고의 모든 차량이 차량스케쥴표에 등록되어있는 지 조회")
    void getVehicleSchedule(){
        VehicleDTO vehicleDTO = VehicleDTO.builder()
                .storedType("냉장")
                .warehouseCode("GG1")
                .outboundDate(LocalDate.parse("2025-01-13"))
                .outboundCode("OB005")
                .quantity(45)
                .build();
        boolean scheduledCount = outboundService.getVehicleSchedule(vehicleDTO);
        log.info(scheduledCount);
    }
    @Test
    @DisplayName("해당날짜의 창고의 모든 차량을 스케쥴표에 등록 (중복제외)")
    void insertVehicleSchedule(){
        VehicleDTO vehicleDTO = VehicleDTO.builder()
                .storedType("냉장")
                .warehouseCode("GG1")
                .outboundDate(LocalDate.parse("2025-01-13"))
                .outboundCode("OB005")
                .quantity(45)
                .build();
        outboundService.insertVehicleSchedule(vehicleDTO);
    }


    @Test
    @DisplayName("출고에 차량 배치")
    void outboundVehicle(){
        outboundService.outboundVehicle("OB156");
        //결과 : 로그 확인
    }

}