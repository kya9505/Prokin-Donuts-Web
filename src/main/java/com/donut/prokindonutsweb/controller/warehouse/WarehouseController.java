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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

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
    List<MemberAccountVO> unassignedWMs = warehouseService.getUnassignedWarehouseManagers();
    
    model.addAttribute("warehouseList",warehouseList);
    model.addAttribute("unassignedWMs",unassignedWMs);
  }
  
  // 2. 창고 등록
  @PostMapping("/add")
  public String addWarehouse(WarehouseDTO warehouseDTO) {
    log.info("Controller : addWarehouse called");
    warehouseService.addWarehouse(warehouseDTO);
    return "redirect:/qh/warehouse";
  }
  
  // 3. 창고 수정
  @PostMapping("/update")
  public String updateWarehouse(WarehouseUpdateDTO warehouseUpdateDTO) {
    log.info("Controller : updateWarehouse called");
    warehouseService.updateWarehouse(warehouseUpdateDTO);
    return "redirect:/qh/warehouse";
  }
  
  // 4. 창고 삭제
  @PostMapping("/delete")
  public String deleteWarehouse(WarehouseDeleteDTO warehouseDeleteDTO) {
    log.info("Controller : deleteWarehouse called");
    warehouseService.deleteWarehouse(warehouseDeleteDTO);
    return "redirect:/qh/warehouse";
  }
  
  // 6. 창고명 중복 확인
  @GetMapping(value = "/check", produces = "application/json")
  @ResponseBody
  public boolean checkWarehouseDuplicate(@RequestParam("warehouseName") String warehouseName,
                                         @RequestParam(value = "warehouseCode", required = false) String warehouseCode) {
    log.info("Controller : checkWarehouseDuplicate called");
    WarehouseCheckDTO dto = new WarehouseCheckDTO();
    dto.setWarehouseName(warehouseName);
    dto.setWarehouseCode(warehouseCode);  // 수정일 경우만 유효값 전달 그 외 null
    return warehouseService.checkWarehouseDuplicate(dto);
  }
}
