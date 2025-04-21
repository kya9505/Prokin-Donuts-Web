package com.donut.prokindonutsweb.warehouse.controller;

import com.donut.prokindonutsweb.warehouse.dto.WarehouseCheckDTO;
import com.donut.prokindonutsweb.warehouse.dto.WarehouseDTO;
import com.donut.prokindonutsweb.warehouse.dto.WarehouseDeleteDTO;
import com.donut.prokindonutsweb.warehouse.dto.WarehouseUpdateDTO;
import com.donut.prokindonutsweb.warehouse.service.WarehouseService;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/qh/warehouse")
public class WarehouseController {
  private final WarehouseService warehouseService;
  
  // 1. 전체 창고 목록 조회
  @GetMapping
  public void qhGetWarehouseList(Model model){
    log.info("Controller : qhGetWarehouseList called");
    List<WarehouseDTO> warehouseList = warehouseService.findWarehouseList();
    List<MemberAccountVO> unassignedWMs = warehouseService.findUnassignedWarehouseManagers();
    
    for (WarehouseDTO dto : warehouseList) {
      String status = warehouseService.findWarehouseStatus(dto.getWarehouseCode());
      // null 이면 삭제 가능 상태로 간주
      dto.setStatus(status != null ? status : "삭제가능");
    }
    
    model.addAttribute("warehouseList",warehouseList);
    model.addAttribute("unassignedWMs",unassignedWMs);
  }
  
  // 2. 창고 등록
  @PostMapping("/add")
  public String qhAddWarehouse(WarehouseDTO warehouseDTO) {
    log.info("Controller : qhAddWarehouse called");
    if ("null".equals(warehouseDTO.getMemberCode()) || "".equals(warehouseDTO.getMemberCode())) {
      warehouseDTO.setMemberCode(null);
    }
    
    warehouseService.saveWarehouse(warehouseDTO);
    return "redirect:/qh/warehouse";
  }
  
  // 3. 창고 수정
  @PostMapping("/update")
  public String qhUpdateWarehouse(WarehouseUpdateDTO warehouseUpdateDTO) {
    log.info("Controller : qhUpdateWarehouse called");
    if ("null".equals(warehouseUpdateDTO.getMemberCode()) || "".equals(warehouseUpdateDTO.getMemberCode())) {
      warehouseUpdateDTO.setMemberCode(null);
    }
    
    warehouseService.updateWarehouse(warehouseUpdateDTO);
    return "redirect:/qh/warehouse";
  }
  
  // 4. 창고 삭제
  @PostMapping("/delete")
  public String qhDeleteWarehouse(WarehouseDeleteDTO warehouseDeleteDTO) {
    log.info("Controller : qhDeleteWarehouse called");
    warehouseService.deleteWarehouse(warehouseDeleteDTO);
    return "redirect:/qh/warehouse";
  }
  
  // 5. 창고명 중복 확인
  @GetMapping(value = "/check", produces = "application/json")
  @ResponseBody
  public String qhCheckWarehouseDuplicate(@RequestParam("warehouseName") String warehouseName,
                                          @RequestParam(value = "warehouseCode", required = false) String warehouseCode) {
    log.info("Controller : qhCheckWarehouseDuplicate called");
    WarehouseCheckDTO dto = new WarehouseCheckDTO();
    dto.setWarehouseName(warehouseName);
    dto.setWarehouseCode(warehouseCode);  // 수정일 경우만 유효값 전달 그 외 null
    return warehouseService.checkWarehouseDuplicate(dto) ? "true" : "false";
  }
}
