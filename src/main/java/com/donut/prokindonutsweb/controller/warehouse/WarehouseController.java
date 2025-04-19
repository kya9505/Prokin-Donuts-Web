package com.donut.prokindonutsweb.controller.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseCheckDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDeleteDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseUpdateDTO;
import com.donut.prokindonutsweb.service.warehouse.WarehouseService;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
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
    log.debug("Controller : qhGetWarehouseList called");
    List<WarehouseDTO> warehouseList = warehouseService.findWarehouseList();
    model.addAttribute("warehouseList",warehouseList);
  }
  
  // 2. 창고 등록
  @PostMapping("/add")
  public String addWarehouse(WarehouseDTO warehouseDTO, Model model) {
    log.debug("Controller : addWarehouse called");
    warehouseService.addWarehouse(warehouseDTO);
    List<MemberAccountVO> unassignedWMs = warehouseService.getUnassignedWarehouseManagers();
    model.addAttribute("unassignedWMs",unassignedWMs);
    return "redirect:/qh/warehouse";
  }
  
  // 3. 창고 수정
  @PostMapping("/update")
  public String updateWarehouse(WarehouseUpdateDTO warehouseUpdateDTO, Model model) {
    log.debug("Controller : updateWarehouse called");
    warehouseService.updateWarehouse(warehouseUpdateDTO);
    List<MemberAccountVO> unassignedWMs = warehouseService.getUnassignedWarehouseManagers();
    model.addAttribute("unassignedWMs",unassignedWMs);
    return "redirect:/qh/warehouse";
  }
  
  // 4. 창고 삭제
  @PostMapping("/delete")
  public String deleteWarehouse(WarehouseDeleteDTO warehouseDeleteDTO) {
    log.debug("Controller : deleteWarehouse called");
    warehouseService.deleteWarehouse(warehouseDeleteDTO);
    return "redirect:/qh/warehouse";
  }
  
  // 6. 창고명 중복 확인
  @GetMapping("/check")
  @ResponseBody
  public boolean checkWarehouseDuplicate(WarehouseCheckDTO warehouseCheckDTO) {
    log.debug("Controller : checkWarehouseDuplicate called");
    return warehouseService.checkWarehouseDuplicate(warehouseCheckDTO);
  }
}
