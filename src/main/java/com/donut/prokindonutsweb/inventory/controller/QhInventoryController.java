package com.donut.prokindonutsweb.inventory.controller;

import com.donut.prokindonutsweb.inventory.dto.InventorySelectDTO;
import com.donut.prokindonutsweb.inventory.service.QhInventoryService;
import com.donut.prokindonutsweb.product.service.CategoryFilterService;
import com.donut.prokindonutsweb.warehouse.dto.WarehouseCheckDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.SQLOutput;
import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/qh/inventory")
public class QhInventoryController {
  
  private final QhInventoryService qhInventoryService;
  private final CategoryFilterService categoryFilterService;
  
  // 1) 초기 페이지 로딩
  @GetMapping()
  public void qhGetInventoryList(Model model) {
    log.info("QH - Fetching full inventory list");
    
    List<InventorySelectDTO> inventoryList = qhInventoryService.findInventoryList();
    List<String> warehouseList = qhInventoryService.findWarehouseList();
    
    List<String> categoryMidList = categoryFilterService.findCategoryMidList();
    
    model.addAttribute("inventoryList", inventoryList);
    model.addAttribute("warehouseList", warehouseList);
    model.addAttribute("categoryMidList", categoryMidList);
  }
  
  @GetMapping(value = "/check", produces = "application/json; charset=UTF-8")
  @ResponseBody
  public List<String> getSubCategoryList(@RequestParam("categoryMid") String categoryMid) {
    System.out.println(categoryMid);
    
    if (categoryMid == null || categoryMid.trim().isEmpty() || "중분류 선택".equals(categoryMid)) {
      System.out.println("test : " + categoryMid);
      return List.of();
    }
    
    return categoryFilterService.findSubCategoryListByMid(categoryMid);
  }
  
}