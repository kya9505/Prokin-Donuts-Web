package com.donut.prokindonutsweb.mappers.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDeleteDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseUpdateDTO;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import com.donut.prokindonutsweb.vo.warehouse.WarehouseVO;
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
public class WarehouseMapperTest {
  
  @Autowired
  private WarehouseMapper warehouseMapper;
  @Autowired
  private ModelMapper modelMapper;
  
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
  
  @Test
  public void testInsertWarehouse() {
    String randomCode = "TEST" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();
    
    WarehouseDTO dto = WarehouseDTO.builder()
        .warehouseCode(randomCode)
        .warehouseName("테스트창고")
        .capacityLimit(1000)
        .address("서울 강남구 테스트로 123")
        .memberCode(null)
        .build();
    
    WarehouseVO vo = modelMapper.map(dto, WarehouseVO.class);
    
    warehouseMapper.insertWarehouse(vo);
    
    List<WarehouseDTO> result = warehouseMapper.selectWarehouseList();
    boolean found = result.stream().anyMatch(w -> w.getWarehouseCode().equals(randomCode));
    assertTrue(found, "새로 추가된 창고가 조회 결과에 존재해야 합니다");
  }
  
  @Test
  public void testUpdateWarehouse() {
    String testCode = "GG1"; // DB에 있는 창고 코드
    
    WarehouseUpdateDTO dto = new WarehouseUpdateDTO();
    dto.setWarehouseCode(testCode);
    dto.setWarehouseName("수정된창고이름");
    dto.setMemberCode("WM3");
    
    WarehouseVO vo = modelMapper.map(dto, WarehouseVO.class);
    warehouseMapper.updateWarehouse(vo);
    
    WarehouseDTO updated = warehouseMapper.selectWarehouseList().stream()
        .filter(w -> w.getWarehouseCode().equals(testCode))
        .findFirst()
        .orElse(null);
    
    assertNotNull(updated);
    assertEquals("수정된창고이름", updated.getWarehouseName());
  }
  
  @Test
  public void testDeleteWarehouse() {
    String testCode = "GG11";
    
    // 1. 먼저 insert (등록은 VO 그대로)
    WarehouseVO vo = new WarehouseVO();
    vo.setWarehouseCode(testCode);
    vo.setWarehouseName("삭제용창고");
    vo.setCapacityLimit(500);
    vo.setAddress("삭제로 111");
    warehouseMapper.insertWarehouse(vo);
    
    // 2. DTO 생성 → VO로 변환
    WarehouseDeleteDTO deleteDTO = new WarehouseDeleteDTO();
    deleteDTO.setWarehouseCode(testCode);
    WarehouseVO deleteVO = modelMapper.map(deleteDTO, WarehouseVO.class);
    
    // 3. 삭제
    warehouseMapper.deleteWarehouse(deleteVO);
    
    // 4. 검증
    List<WarehouseDTO> result = warehouseMapper.selectWarehouseList();
    boolean found = result.stream().anyMatch(w -> w.getWarehouseCode().equals(testCode));
    assertFalse(found, "삭제된 창고는 조회 결과에 없어야 합니다");
  }
  
  @Test
  public void testSelectUnassignedManagers() {
    List<MemberAccountVO> list = warehouseMapper.selectUnAccountWMList();
    
    assertNotNull(list);
    log.info("할당되지 않은 창고 관리자 수: {}", list.size());
    for (MemberAccountVO vo : list) {
      log.info("미할당 관리자: {}", vo);
    }
  }
  
  @Test
  public void testCheckWarehouseDuplicate_whenInserting() {
    WarehouseVO vo = new WarehouseVO();
    vo.setWarehouseName("대전DT센터");
    vo.setWarehouseCode(null);
    
    int result = warehouseMapper.checkWarehouseDuplicate(vo);
    
    log.info("중복 결과 (등록): {}", result);
    assertTrue(result > 0, "같은 이름이 있을 경우 count > 0 이어야 함");
  }
  
  @Test
  public void testCheckWarehouseDuplicate_whenUpdatingSelf() {
    WarehouseVO vo = new WarehouseVO();
    vo.setWarehouseName("남양주DT센터");
    vo.setWarehouseCode("GG1");
    
    int result = warehouseMapper.checkWarehouseDuplicate(vo);
    
    log.info("중복 결과 (자기 자신): {}", result);
    assertEquals(0, result, "자기 자신은 중복에서 제외되어야 함");
  }
  
  @Test
  public void testCheckWarehouseDuplicate_whenUpdatingConflict() {
    WarehouseVO vo = new WarehouseVO();
    vo.setWarehouseName("남양주DT센터");
    vo.setWarehouseCode("DJ1");
    
    int result = warehouseMapper.checkWarehouseDuplicate(vo);
    
    log.info("중복 결과 (다른 창고 중복): {}", result);
    assertTrue(result > 0, "다른 창고가 같은 이름을 가지고 있으면 중복이어야 함");
  }
}