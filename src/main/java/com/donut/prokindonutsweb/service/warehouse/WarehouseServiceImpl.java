package com.donut.prokindonutsweb.service.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseCheckDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDeleteDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseUpdateDTO;
import com.donut.prokindonutsweb.mappers.warehouse.WarehouseMapper;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import com.donut.prokindonutsweb.vo.warehouse.WarehouseVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Log4j2
@RequiredArgsConstructor
public class WarehouseServiceImpl implements WarehouseService {
  private final ModelMapper modelMapper;
  private final WarehouseMapper warehouseMapper;
  
  @Override
  @Transactional(readOnly = true)
  public List<WarehouseDTO> findWarehouseList() {
    log.info("Service : findWarehouseList called");
    return warehouseMapper.selectWarehouseList();
  }
  
  private static final Map<String, String> REGION_PREFIX_MAP = Map.ofEntries(
      Map.entry("서울특별시", "SL"), Map.entry("서울", "SL"),
      Map.entry("경기도", "GG"), Map.entry("경기", "GG"),
      Map.entry("인천광역시", "IC"), Map.entry("인천", "IC"),
      Map.entry("강원특별자치도", "GW"), Map.entry("강원", "GW"),
      Map.entry("충청북도", "CB"), Map.entry("충북", "CB"),
      Map.entry("충청남도", "CN"), Map.entry("충남", "CN"),
      Map.entry("전라북도", "JB"), Map.entry("전북", "JB"),
      Map.entry("전라남도", "JN"), Map.entry("전남", "JN"),
      Map.entry("경상북도", "GB"), Map.entry("경북", "GB"),
      Map.entry("경상남도", "GN"), Map.entry("경남", "GN"),
      Map.entry("제주특별자치도", "JJ"), Map.entry("제주", "JJ"),
      Map.entry("대전광역시", "DJ"), Map.entry("대전", "DJ"),
      Map.entry("대구광역시", "DG"), Map.entry("대구", "DG"),
      Map.entry("광주광역시", "GJ"), Map.entry("광주", "GJ"),
      Map.entry("부산광역시", "BS"), Map.entry("부산", "BS"),
      Map.entry("울산광역시", "US"), Map.entry("울산", "US"),
      Map.entry("세종특별자치시", "SJ"), Map.entry("세종", "SJ")
  );
  
  // 창고 등록 시 코드 자동 생성 메서드
  private String generateWarehouseCode(String address) {
    // 1. 주소에 포함된 지역코드 추출
    String prefix = REGION_PREFIX_MAP.entrySet().stream()
        .filter(entry -> address.contains(entry.getKey()))
        .map(Map.Entry::getValue)
        .findFirst()
        .orElse("ETC");  // ← 예외 대신 ETC 처리
    
    // 2. 해당 prefix로 시작하는 기존 창고코드들 조회
    List<String> existingCodes = warehouseMapper.selectWarehouseCodesByPrefix(prefix); // ex: GG1, GG4, GG5
    
    // 3. 숫자만 추출하여 최대값 + 1 결정
    int nextNum = existingCodes.stream()
        .map(code -> code.replace(prefix, ""))
        .filter(str -> str.matches("\\d+"))
        .mapToInt(Integer::parseInt)
        .max()
        .orElse(0) + 1;
    
    return prefix + nextNum;
  }
  
  @Override
  public void addWarehouse(WarehouseDTO warehouseDTO) {
    log.info("Service : addWarehouse called");
    
    // 자동 창고 코드 생성
    String generatedCode = generateWarehouseCode(warehouseDTO.getAddress());
    warehouseDTO.setWarehouseCode(generatedCode);
    
    WarehouseVO warehouseVO = modelMapper.map(warehouseDTO, WarehouseVO.class);
    warehouseMapper.insertWarehouse(warehouseVO);
  }
  
  @Override
  public void updateWarehouse(WarehouseUpdateDTO warehouseUpdateDTO) {
    log.info("Service : qhUpdateWarehouse called");
    WarehouseVO warehouseVO = modelMapper.map(warehouseUpdateDTO, WarehouseVO.class);
    warehouseMapper.updateWarehouse(warehouseVO);
  }
  
  @Override
  public void deleteWarehouse(WarehouseDeleteDTO warehouseDeleteDTO) {
    log.info("Service : qhDeleteWarehouse called");
    WarehouseVO warehouseVO = modelMapper.map(warehouseDeleteDTO, WarehouseVO.class);
    warehouseMapper.deleteWarehouse(warehouseVO);
  }
  
  @Override
  @Transactional(readOnly = true)
  public List<MemberAccountVO> findUnassignedWarehouseManagers() {
    log.info("Service : getUnassignedWarehouseManagers called");
    return warehouseMapper.selectUnAccountWMList();
  }
  
  @Override
  public boolean checkWarehouseDuplicate(WarehouseCheckDTO warehouseCheckDTO) {
    log.info("Service : qhCheckWarehouseDuplicate called");
    WarehouseVO warehouseVO = modelMapper.map(warehouseCheckDTO, WarehouseVO.class);
    int count = warehouseMapper.checkWarehouseDuplicate(warehouseVO);
    return count > 0;
  }
  
  @Override
  public String findWarehouseStatus(String warehouseCode) {
    return warehouseMapper.selectWarehouseStatus(warehouseCode);
  }
}
