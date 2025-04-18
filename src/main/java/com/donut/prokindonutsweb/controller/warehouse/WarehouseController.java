package com.donut.prokindonutsweb.controller.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import com.donut.prokindonutsweb.service.warehouse.WarehouseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
public class WarehouseController {
  private final WarehouseService warehouseService;
  
  @GetMapping("/qh/warehouse")
  public void qhGetWarehouseList(Model model){
    log.debug("Controller : qhGetWarehouseList called");
    List<WarehouseDTO> warehouseList = warehouseService.findWarehouseList();
    model.addAttribute("warehouseList",warehouseList);
  }
}
