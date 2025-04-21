package com.donut.prokindonutsweb.service.franchise;

import com.donut.prokindonutsweb.dto.franchise.FranchiseCheckDTO;
import com.donut.prokindonutsweb.dto.franchise.FranchiseDTO;
import com.donut.prokindonutsweb.dto.franchise.FranchiseDeleteDTO;
import com.donut.prokindonutsweb.dto.franchise.FranchiseUpdateDTO;
import com.donut.prokindonutsweb.mappers.franchise.FranchiseMapper;
import com.donut.prokindonutsweb.vo.franchise.FranchiseVO;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
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
public class FranchiseServiceImpl implements FranchiseService{
  
  private final ModelMapper modelMapper;
  private final FranchiseMapper franchiseMapper;
  
  @Override
  @Transactional(readOnly = true)
  public List<FranchiseDTO> findFranchiseList() {
    log.info("Service: findFranchiseList called");
    return franchiseMapper.selectFranchiseList();
  }
  
  private static final Map<String, String> REGION_PREFIX_MAP = Map.ofEntries(
      Map.entry("서울특별시", "SLF"), Map.entry("서울", "SLF"),
      Map.entry("경기도", "GGF"), Map.entry("경기", "GGF"),
      Map.entry("인천광역시", "ICF"), Map.entry("인천", "ICF"),
      Map.entry("강원특별자치도", "GWF"), Map.entry("강원", "GWF"),
      Map.entry("충청북도", "CBF"), Map.entry("충북", "CBF"),
      Map.entry("충청남도", "CNF"), Map.entry("충남", "CNF"),
      Map.entry("전라북도", "JBF"), Map.entry("전북", "JBF"),
      Map.entry("전라남도", "JNF"), Map.entry("전남", "JNF"),
      Map.entry("경상북도", "GBF"), Map.entry("경북", "GBF"),
      Map.entry("경상남도", "GNF"), Map.entry("경남", "GNF"),
      Map.entry("제주특별자치도", "JJF"), Map.entry("제주", "JJF"),
      Map.entry("대전광역시", "DJF"), Map.entry("대전", "DJF"),
      Map.entry("대구광역시", "DGF"), Map.entry("대구", "DGF"),
      Map.entry("광주광역시", "GJF"), Map.entry("광주", "GJF"),
      Map.entry("부산광역시", "BSF"), Map.entry("부산", "BSF"),
      Map.entry("울산광역시", "USF"), Map.entry("울산", "USF"),
      Map.entry("세종특별자치시", "SJF"), Map.entry("세종", "SJF")
  );
  
  // 창고 등록 시 코드 자동 생성 메서드
  private String generateWarehouseCode(String address) {
    // 1. 주소에 포함된 지역코드 추출
    String prefix = REGION_PREFIX_MAP.entrySet().stream()
        .filter(entry -> address.contains(entry.getKey()))
        .map(Map.Entry::getValue)
        .findFirst()
        .orElse("ETCF");  // ← 예외 대신 ETC 처리
    
    // 2. 해당 prefix로 시작하는 기존 창고코드들 조회
    List<String> existingCodes = franchiseMapper.selectFranchiseCodesByPrefix(prefix); // ex: GG1, GG4, GG5
    
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
  @Transactional
  public void saveFranchise(FranchiseDTO franchiseDTO) {
    log.info("Service: saveFranchise called");
    
    // 자동 가맹점 코드 생성
    String generatedCode = generateWarehouseCode(franchiseDTO.getFranchiseLocation());
    franchiseDTO.setFranchiseCode(generatedCode);
    
    FranchiseVO vo = modelMapper.map(franchiseDTO, FranchiseVO.class);
    franchiseMapper.insertFranchise(vo);
  }
  
  @Override
  @Transactional
  public void updateFranchise(FranchiseUpdateDTO franchiseUpdateDTO) {
    log.info("Service: updateFranchise called");
    FranchiseVO vo = modelMapper.map(franchiseUpdateDTO, FranchiseVO.class);
    franchiseMapper.updateFranchise(vo);
  }
  
  @Override
  @Transactional
  public void deleteFranchise(FranchiseDeleteDTO franchiseDeleteDTO) {
    log.info("Service: deleteFranchise called");
    FranchiseVO vo = modelMapper.map(franchiseDeleteDTO, FranchiseVO.class);
    franchiseMapper.deleteFranchise(vo);
  }
  
  @Override
  @Transactional(readOnly = true)
  public List<MemberAccountVO> findUnassignedFranchiseManagers() {
    log.info("Service: findUnassignedFranchiseManagers called");
    return franchiseMapper.selectUnAccountFMList();
  }
  
  @Override
  public boolean checkFranchiseDuplicate(FranchiseCheckDTO franchiseCheckDTO) {
    log.info("Service: checkFranchiseDuplicate called");
    FranchiseVO vo = modelMapper.map(franchiseCheckDTO, FranchiseVO.class);
    int count = franchiseMapper.checkFranchiseDuplicate(vo);
    return count > 0;
  }
  
  @Override
  @Transactional(readOnly = true)
  public String findFranchiseStatus(String franchiseCode) {
    log.info("Service: findFranchiseStatus called");
    return franchiseMapper.selectFranchiseStatus(franchiseCode);
  }
}