package com.donut.prokindonutsweb.product.controller;

import com.donut.prokindonutsweb.warehouse.service.WarehouseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/qh/product")
public class ProductController {
  private final WarehouseService warehouseService;
  
  // 1. 전체 창고 목록 조회
  @GetMapping
  public void qhGetWarehouseList(Model model) {
  }
}
