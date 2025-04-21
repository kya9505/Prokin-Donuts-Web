package com.donut.prokindonutsweb.inventory.controller;

import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;
import com.donut.prokindonutsweb.inventory.service.QhInventoryService;
import com.donut.prokindonutsweb.inventory.service.WmInventoryService;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/wm/inventory")
public class WmInventoryController {
  
  private final WmInventoryService wmInventoryService;
  
  // 1) 초기 페이지 로딩
  @GetMapping
  public void wmGetInventoryList(Model model) {
    // 1. 로그인 안 되어 있으므로 더미 담당자 코드로 설정
    String dummyMemberCode = "WM1";
    
    // 2. 해당 담당자에게 할당된 창고코드 조회
    String warehouseCode = wmInventoryService.findWarehouseCodeByMemberCode(dummyMemberCode);
    
    // 3. 창고가 아예 할당되지 않은 경우 (예: 담당자 미지정)
    if (warehouseCode == null || warehouseCode.trim().isEmpty()) {
      log.warn("No warehouse assigned to member: {}", dummyMemberCode);
      model.addAttribute("inventoryList", List.of());              // 재고는 빈 리스트로
      model.addAttribute("warehouseCode", "(미지정)");             // 창고 없음 표시
      return;
    }
    
    // 4. 할당된 창고의 재고 목록 조회
    List<InventorySelectDTO> inventoryList = wmInventoryService.findInventoryList(warehouseCode);
    
    // 5. 재고가 아예 없는 경우
    if (inventoryList == null || inventoryList.isEmpty()) {
      log.warn("No inventory found for warehouse: {}", warehouseCode);
      model.addAttribute("inventoryList", List.of());              // 재고는 빈 리스트로
      model.addAttribute("warehouseCode", warehouseCode + " (재고 없음)"); // 창고는 있으나 재고 없음 표시
    } else {
      // 6. 재고가 존재할 경우 → 그대로 전달
      model.addAttribute("inventoryList", inventoryList);
      model.addAttribute("warehouseCode", warehouseCode);
    }
  }
  
}