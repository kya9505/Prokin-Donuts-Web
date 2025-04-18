package com.donut.prokindonutsweb.mappers.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class WarehouseMapperTest {
  
  @Autowired
  private WarehouseMapper warehouseMapper;
  
  @Test
  public void testSelectWarehouseList() {
    List<WarehouseDTO> warehouseList = warehouseMapper.selectWarehouseList();
    
    assertNotNull(warehouseList, "창고 리스트는 null이 아니어야 합니다");
    log.info("조회된 창고 수: {}", warehouseList.size());
    
    for (WarehouseDTO dto : warehouseList) {
      log.info("창고 정보: {}", dto);
      assertNotNull(dto.getWarehouseCode(), "창고 코드가 존재해야 합니다");
      assertNotNull(dto.getWarehouseName(), "창고 이름이 존재해야 합니다");
      assertNotNull(dto.getAddress(), "창고 주소가 존재해야 합니다");
    }
  }
}