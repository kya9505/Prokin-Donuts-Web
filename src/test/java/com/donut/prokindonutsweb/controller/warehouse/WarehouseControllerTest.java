/*
package com.donut.prokindonutsweb.controller.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseCheckDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDeleteDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseUpdateDTO;
import com.donut.prokindonutsweb.service.warehouse.WarehouseService;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;

import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Transactional
class WarehouseControllerTest {
  
  @Autowired
  private WarehouseController warehouseController;
  
  // 1. 전체 창고 목록 조회 테스트
  @Test
  public void testGetWarehouseList() {
    Model model = new ExtendedModelMap();
    warehouseController.qhGetWarehouseList(model);
    
    List<WarehouseDTO> list = (List<WarehouseDTO>) model.getAttribute("warehouseList");
    assertNotNull(list);
    list.forEach(log::info);
  }
  
  // 2. 창고 등록 테스트
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
    
    Model model = new ExtendedModelMap();
    String result = warehouseController.addWarehouse(dto, model);
    
    assertEquals("redirect:/qh/warehouse", result);
  }
  
  // 3. 창고 수정 테스트
  @Test
  public void testUpdateWarehouse() {
    WarehouseUpdateDTO updateDTO = new WarehouseUpdateDTO();
    updateDTO.setWarehouseCode("TEST01");
    updateDTO.setWarehouseName("수정된창고");
    updateDTO.setMemberCode("WM2");
    
    Model model = new ExtendedModelMap();
    String result = warehouseController.updateWarehouse(updateDTO, model);
    
    assertEquals("redirect:/qh/warehouse", result);
  }
  
  // 4. 창고 삭제 테스트
  @Test
  public void testDeleteWarehouse() {
    WarehouseDeleteDTO deleteDTO = new WarehouseDeleteDTO();
    deleteDTO.setWarehouseCode("TEST01");
    
    String result = warehouseController.deleteWarehouse(deleteDTO);
    assertEquals("redirect:/qh/warehouse", result);
  }
  
  // 5. 중복 확인 테스트
  @Test
  public void testCheckWarehouseDuplicate() {
    WarehouseCheckDTO checkDTO = new WarehouseCheckDTO();
    checkDTO.setWarehouseName("테스트창고");
    checkDTO.setWarehouseCode(null);
    
    boolean result = warehouseController.checkWarehouseDuplicate(checkDTO);
    log.info("중복 확인 결과: {}", result);
    
    // true or false 모두 가능 → 단순 호출 여부만 테스트
    assertNotNull(result);
  }
}
*/
