/*
package com.donut.prokindonutsweb.service.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseCheckDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDeleteDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseUpdateDTO;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Transactional
public class WarehouseServiceImplTest {
  
  @Autowired
  private WarehouseService warehouseService;
  @Autowired
  private ModelMapper modelMapper;
  
  @Test
  public void testAddWarehouse() {
    String randomCode = "T" + UUID.randomUUID().toString().substring(0, 6).toUpperCase();
    
    WarehouseDTO dto = WarehouseDTO.builder()
        .warehouseCode(randomCode)
        .warehouseName("테스트창고")
        .capacityLimit(500)
        .address("서울시 테스트구")
        .memberCode(null)
        .build();
    
    warehouseService.addWarehouse(dto);
    
    List<WarehouseDTO> result = warehouseService.findWarehouseList();
    boolean found = result.stream()
        .anyMatch(w -> w.getWarehouseCode().equals(randomCode));
    
    assertTrue(found, "등록된 창고가 리스트에 존재해야 합니다");
  }
  
  @Test
  public void testUpdateWarehouse() {
    // 1. Insert
    String randomCode = "T" + UUID.randomUUID().toString().substring(0, 6).toUpperCase();
    
    WarehouseDTO dto = WarehouseDTO.builder()
        .warehouseCode(randomCode)
        .warehouseName("테스트창고")
        .capacityLimit(500)
        .address("서울시 테스트구")
        .memberCode(null)
        .build();
    
    warehouseService.addWarehouse(dto);
    
    // 2. Update DTO 생성
    WarehouseUpdateDTO updateDTO = new WarehouseUpdateDTO();
    updateDTO.setWarehouseCode(randomCode);
    updateDTO.setWarehouseName("수정된창고");
    updateDTO.setMemberCode("WM3"); // 할당된 회원코드 가정
    
    // 3. Update 실행
    warehouseService.updateWarehouse(updateDTO);
    
    // 4. 검증
    List<WarehouseDTO> result = warehouseService.findWarehouseList();
    WarehouseDTO updated = result.stream()
        .filter(w -> w.getWarehouseCode().equals(randomCode))
        .findFirst()
        .orElse(null);
    
    assertNotNull(updated);
    assertEquals("수정된창고", updated.getWarehouseName());
    assertEquals("WM3", updated.getMemberCode());
  }
  
  @Test
  public void testDeleteWarehouse() {
    // 1. Insert
    String randomCode = "T" + UUID.randomUUID().toString().substring(0, 6).toUpperCase();
    
    WarehouseDTO dto = WarehouseDTO.builder()
        .warehouseCode(randomCode)
        .warehouseName("삭제용창고")
        .capacityLimit(500)
        .address("서울시 테스트구")
        .memberCode(null)
        .build();
    
    warehouseService.addWarehouse(dto);
    
    // 2. Delete 실행
    WarehouseDeleteDTO deleteDTO = new WarehouseDeleteDTO();
    deleteDTO.setWarehouseCode(randomCode);
    warehouseService.deleteWarehouse(deleteDTO);
    
    // 3. 검증
    List<WarehouseDTO> result = warehouseService.findWarehouseList();
    boolean found = result.stream()
        .anyMatch(w -> w.getWarehouseCode().equals(randomCode));
    
    assertFalse(found, "삭제된 창고는 리스트에 존재하지 않아야 함");
  }
  
  @Test
  public void testFindWarehouseList() {
    List<WarehouseDTO> list = warehouseService.findWarehouseList();
    assertNotNull(list);
    log.info("창고 수: {}", list.size());
  }
  
  @Test
  public void testGetUnassignedWarehouseManagers() {
    List<MemberAccountVO> list = warehouseService.getUnassignedWarehouseManagers();
    assertNotNull(list);
    list.forEach(log::info);
  }
  
  @Test
  public void testCheckWarehouseDuplicate() {
    WarehouseDTO dto = WarehouseDTO.builder()
        .warehouseCode("TEST01")
        .warehouseName("중복창고")
        .capacityLimit(100)
        .address("서울")
        .build();
    
    warehouseService.addWarehouse(dto);
    
    WarehouseCheckDTO checkDTO = new WarehouseCheckDTO();
    checkDTO.setWarehouseName("중복창고");
    checkDTO.setWarehouseCode(null); // 등록 상황
    
    boolean isDup = warehouseService.checkWarehouseDuplicate(checkDTO);
    assertTrue(isDup, "중복된 창고명이라면 true 반환해야 함");
  }
}
*/
