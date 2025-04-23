package com.donut.prokindonutsweb.product.controller;

import com.donut.prokindonutsweb.product.dto.*;
import com.donut.prokindonutsweb.product.service.CategoryFilterService;
import com.donut.prokindonutsweb.product.service.ProductService;
import com.donut.prokindonutsweb.warehouse.dto.WarehouseCheckDTO;
import com.donut.prokindonutsweb.warehouse.dto.WarehouseDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/qh/product")
public class ProductController {
  
  private final ProductService productService;
  private final CategoryFilterService categoryFilterService;
  
  // 제품 및 카테고리 목록 조회
  @GetMapping
  public void qhGetWarehouseList(Model model) {
    log.info("조회 - 제품 및 카테고리 목록을 요청합니다.");
    
    List<CategorySelectDTO> categoryList = productService.findCategoryList();
    List<ProductSelectDTO> productList = productService.findProductList();
    List<String> categoryMidList = categoryFilterService.findCategoryMidList();
    
    for (CategorySelectDTO dto : categoryList) {
      String status = productService.findCategoryStatus(dto.getCategoryCode());
      // null 이면 삭제 가능 상태로 간주
      dto.setCategoryStatus(status != null ? status : "삭제가능");
    }
    for (ProductSelectDTO dto : productList) {
      String status = productService.findProductStatus(dto.getProductCode());
      // null 이면 삭제 가능 상태로 간주
      dto.setProductStatus(status != null ? status : "삭제가능");
    }
    
    model.addAttribute("categoryList",categoryList);
    model.addAttribute("productList",productList);
    model.addAttribute("categoryMidList", categoryMidList);
  }
  
  /// //////////////////////////////////////////////////////
  /// //////////////////////////////////////////////////////
  /// //////////////////////////////////////////////////////
  
  // 카테고리 등록
  @PostMapping("/category/add")
  public String qhAddCategory(CategoryInsertDTO categoryDTO) {
    log.info("등록 - 새로운 카테고리를 등록합니다: {}", categoryDTO);
    
    productService.saveCategory(categoryDTO);
    return "redirect:/qh/product";
  }
  
  // 카테고리 삭제
  @PostMapping("/category/delete")
  public String qhDeleteCategory(CategoryDeleteDTO categoryDTO) {
    log.info("삭제 - 카테고리를 삭제합니다: {}", categoryDTO);
    
    productService.deleteCategory(categoryDTO);
    return "redirect:/qh/product";
  }
  
  /// //////////////////////////////////////////////////////
  /// //////////////////////////////////////////////////////
  /// //////////////////////////////////////////////////////
  
  // 제품 등록
  @PostMapping("/add")
  public String qhAddProduct(ProductInsertDTO productDTO) {
    log.info("등록 - 새로운 제품을 등록합니다: {}", productDTO);
    
    productService.saveProduct(productDTO);
    return "redirect:/qh/product";
  }
  
  // 제품 수정
  @PostMapping("/update")
  public String qhUpdateProduct(ProductInsertDTO productDTO) {
    log.info("수정 - 제품을 수정합니다: {}", productDTO);
    
    productService.updateProduct(productDTO);
    return "redirect:/qh/product";
  }
  
  // 제품 삭제
  @PostMapping("/delete")
  public String qhDeleteProduct(ProductDeleteDTO productDTO) {
    log.info("삭제 - 제품을 삭제합니다: {}", productDTO);
    
    productService.deleteProduct(productDTO);
    return "redirect:/qh/product";
  }
  
  /// //////////////////////////////////////////////////////
  /// //////////////////////////////////////////////////////
  /// //////////////////////////////////////////////////////
  
  // 카테고리 중복 확인 (카테고리 코드, 중분류명, 소분류명)
  @GetMapping("/category/check")
  @ResponseBody
  public String qhCheckCategoryDuplicate(
      @RequestParam String categoryCode,
      @RequestParam String middleName,
      @RequestParam String smallName) {
    log.info("중복 확인 - 카테고리 코드: {}, 중분류명: {}, 소분류명: {}", categoryCode, middleName, smallName);
    
    CategoryCheckDTO dto = new CategoryCheckDTO();
    dto.setCategoryCode(categoryCode);
    dto.setCategoryMid(middleName);
    dto.setCategorySub(smallName);
    return productService.checkCategoryDuplicate(dto) ? "true" : "false";
  }
  
  // 제품 중복 확인 (카테고리 코드와 제품명)
  @GetMapping("/check")
  @ResponseBody
  public String qhCheckProductDuplicate(
      @RequestParam String categoryCode,
      @RequestParam String productName,
      @RequestParam(value = "productCode", required = false) String productCode) {
    log.info("중복 확인 - 카테고리 코드: {}, 제품명: {}, 제품코드: {}", categoryCode, productName, productCode);
    
    ProductCheckDTO dto = new ProductCheckDTO();
    dto.setCategoryCode(categoryCode);
    dto.setProductName(productName);
    // 수정일 경우 자기 자신을 제외하고 중복검사
    dto.setProductCode(productCode);  // 수정일 경우만 유효값 전달 그 외 null
    return productService.checkProductDuplicate(dto) ? "true" : "false";
  }
  
}
