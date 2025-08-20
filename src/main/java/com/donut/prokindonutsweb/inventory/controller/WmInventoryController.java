package com.donut.prokindonutsweb.inventory.controller;

import com.donut.prokindonutsweb.common.EmailUtil;
import com.donut.prokindonutsweb.inbound.dto.ProductDTO;
import com.donut.prokindonutsweb.inventory.dto.InventoryExpiredDTO;
import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;
import com.donut.prokindonutsweb.inventory.dto.MinStockDTO;
import com.donut.prokindonutsweb.inventory.service.WmInventoryService;
import com.donut.prokindonutsweb.product.service.CategoryFilterService;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import java.io.FileNotFoundException;
import java.util.List;
import java.util.Map;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/wm/warehouse")
public class WmInventoryController {
  
  private final WmInventoryService wmInventoryService;
  private final CategoryFilterService categoryFilterService;
    
    // 1) 초기 페이지 로딩
  @GetMapping
  public void wmGetInventoryList(Model model, @AuthenticationPrincipal CustomUserDetails user) {
    log.info(String.valueOf(user));
    // 1. 로그인 안 되어 있으므로 더미 담당자 코드로 설정
    String dummyMemberCode = user.getMemberCode();
    log.info("WM - Fetching inventory list for member: {}", dummyMemberCode);
    
    // 2. 해당 담당자에게 할당된 창고코드 조회 + 창고명 조회
    String warehouseCode = wmInventoryService.findWarehouseCodeByMemberCode(dummyMemberCode);
    String warehouseName = wmInventoryService.findWarehouseNameByWarehouseCode(warehouseCode);
    
    // 3. 창고가 아예 할당되지 않은 경우 (예: 담당자 미지정)
    if (warehouseCode == null || warehouseCode.trim().isEmpty()) {
      log.warn("No warehouse assigned to member: {}", dummyMemberCode);
      model.addAttribute("inventoryList", List.of()); // 재고는 빈 리스트로
      model.addAttribute("warehouseCode", "코드 미지정"); // 창고 없음 표시
      model.addAttribute("warehouseName", "할당사항 없음"); // 창고명
      return;
    }
    
    // 4. 할당된 창고의 재고 목록 조회
    List<InventorySelectDTO> inventoryList = wmInventoryService.findInventoryList(warehouseCode);
    
    // 5. 재고가 아예 없는 경우
    if (inventoryList == null || inventoryList.isEmpty()) {
      log.warn("No inventory found for warehouse: {}", warehouseCode);
      model.addAttribute("inventoryList", List.of()); // 재고는 빈 리스트로
      model.addAttribute("warehouseCode", warehouseCode + ", 재고 없음"); // 창고는 있으나 재고 없음 표시
      model.addAttribute("warehouseName", warehouseName); // 창고명
    } else {
      // 6. 재고가 존재할 경우 → 그대로 전달
      model.addAttribute("inventoryList", inventoryList);
      model.addAttribute("warehouseCode", warehouseCode);
      model.addAttribute("warehouseName", warehouseName); // 창고명
    }
    
    // 7. 중분류 목록을 조회
    List<String> categoryMidList = categoryFilterService.findCategoryMidList();
    model.addAttribute("categoryMidList", categoryMidList);
  }
  
  // 2) 유통기한 지난 재고 조회
  @GetMapping("/expired/check")
  public ResponseEntity<List<InventoryExpiredDTO>> checkExpiredItems(@AuthenticationPrincipal CustomUserDetails user) {
    log.info("Checking expired inventory items");
    String warehouseCode = wmInventoryService.findWarehouseCodeByMemberCode(user.getMemberCode());
    List<InventoryExpiredDTO> expiredList = wmInventoryService.getExpiredItems(warehouseCode);
    return ResponseEntity.ok(expiredList);
  }
  
  // 3) 유통기한 지난 재고 일괄 폐기
  @PostMapping("/expired/discard")
  public ResponseEntity<Void> discardExpiredItems(@AuthenticationPrincipal CustomUserDetails user) {
    log.info("Discarding expired inventory items");
    String warehouseCode = wmInventoryService.findWarehouseCodeByMemberCode(user.getMemberCode());
    wmInventoryService.discardExpiredItems(warehouseCode);
    
    return ResponseEntity.ok().build();
  }
  
  // 4) 적정재고량 조회
  @GetMapping("/threshold/list")
  public ResponseEntity<List<MinStockDTO>> getMinStockList(@AuthenticationPrincipal CustomUserDetails user) {
    String warehouseCode = wmInventoryService.findWarehouseCodeByMemberCode(user.getMemberCode());
    List<MinStockDTO> result = wmInventoryService.getMinStockList(warehouseCode);
    log.info("[적정재고 조회] warehouseCode: {}", result);
    return ResponseEntity.ok(result);
  }
  
  // 5) 적정재고량 저장/수정/삭제
  @PostMapping("/threshold/save")
  public ResponseEntity<Void> saveMinStockList(@RequestBody List<MinStockDTO> minStockList) {
    log.info("[적정재고 저장 요청] 건수: {}", minStockList.size());
    wmInventoryService.saveMinStockList(minStockList);
    return ResponseEntity.ok().build();
  }
  
  // 6) 적정재고량 - 서브모달 : 추가할 수 있는 제품명 조회
  @GetMapping("/threshold/search")
  public ResponseEntity<List<ProductDTO>> searchProducts(@RequestParam String keyword) {
    List<ProductDTO> products = wmInventoryService.searchProducts(keyword);
    return ResponseEntity.ok(products);
  }
  
  /**
   * 7) 적정재고량 - 메인모달 : 적정재고량 제안 받기 버튼 클릭시
   * @param warehouseCode 필수
   * @param L 리드타임(일), 기본 4
   * @param z 서비스레벨 Z, 기본 1.65
   * @param packSize 묶음 단위, 기본 1
   * @return [{ productCode, productName, suggestedMinStock }]
   */
  @GetMapping(value = "/threshold/suggest", produces = "application/json;charset=UTF-8")
  public ResponseEntity<?> suggest(
      @RequestParam String warehouseCode,
      @RequestParam(required = false) Integer L,
      @RequestParam(required = false) Double z,
      @RequestParam(required = false) Integer packSize
  ) {
    if (warehouseCode == null || warehouseCode.isBlank()) {
      return ResponseEntity.badRequest().body(Map.of("message", "warehouseCode is required"));
    }
    List<Map<String, Object>> list = wmInventoryService.suggestMinStock(warehouseCode, L, z, packSize);
    return ResponseEntity.ok(list);
  }
  
}