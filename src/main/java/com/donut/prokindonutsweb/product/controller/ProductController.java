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
    log.info("GET - 제품 및 카테고리 목록 요청");
    
    List<CategorySelectDTO> categoryList = productService.findCategoryList();
    List<ProductSelectDTO> productList = productService.findProductList();
    List<String> categoryMidList = categoryFilterService.findCategoryMidList();
    
    for (CategorySelectDTO dto : categoryList) {
      String status = productService.findCategoryStatus(dto.getCategoryCode());
      dto.setCategoryStatus(status != null ? status : "삭제가능");
    }
    
    for (ProductSelectDTO dto : productList) {
      String status = productService.findProductStatus(dto.getProductCode());
      dto.setProductStatus(status != null ? status : "삭제가능");
    }
    
    model.addAttribute("categoryList", categoryList);
    model.addAttribute("productList", productList);
    model.addAttribute("categoryMidList", categoryMidList);
    log.info("Model에 데이터 추가 완료");
  }
  
  // 카테고리 등록
  @PostMapping("/category/add")
  public String qhAddCategory(CategoryInsertDTO categoryDTO) {
    log.info("POST - 카테고리 등록 요청: {}", categoryDTO);
    productService.saveCategory(categoryDTO);
    return "redirect:/qh/product";
  }
  
  // 카테고리 일괄 삭제
  @PostMapping("/category/delete")
  public String qhDeleteCategories(@RequestParam("categoryCodes") List<String> categoryCodes) {
    log.info("POST - 카테고리 일괄 삭제 요청: {}", categoryCodes);
    productService.deleteCategories(categoryCodes);
    return "redirect:/qh/product";
  }
  
  // 제품 등록
  @PostMapping("/add")
  public String qhAddProduct(ProductInsertDTO productDTO) {
    log.info("POST - 제품 등록 요청: {}", productDTO);
    productService.saveProduct(productDTO);
    return "redirect:/qh/product";
  }
  
  // 제품 일괄 수정
  @PostMapping("/update")
  public String qhUpdateProducts(@ModelAttribute ProductListWrapper wrapper) {
    List<ProductInsertDTO> list = wrapper.getProductList();
    log.info("✅ 수정 요청 리스트 크기: {}", list.size());
    for (ProductInsertDTO dto : list) {
      log.info("🔧 수정 요청: {}", dto);
    }
    productService.updateProducts(wrapper.getProductList());
    return "redirect:/qh/product";
  }
  
  // 제품 일괄 삭제
  @PostMapping("/delete")
  public String qhDeleteProducts(@RequestParam("productCodes") List<String> productCodes) {
    log.info("POST - 제품 일괄 삭제 요청: {}", productCodes);
    productService.deleteProducts(productCodes);
    return "redirect:/qh/product";
  }
  
  // 카테고리 중복 확인
  @GetMapping("/category/check")
  @ResponseBody
  public String qhCheckCategoryDuplicate(@RequestParam String categoryCode,
                                         @RequestParam String middleName,
                                         @RequestParam String smallName) {
    log.info("GET - 카테고리 중복 확인 요청: code={}, mid={}, sub={}", categoryCode, middleName, smallName);
    
    CategoryCheckDTO dto = new CategoryCheckDTO();
    dto.setCategoryCode(categoryCode);
    dto.setCategoryMid(middleName);
    dto.setCategorySub(smallName);
    
    boolean isDuplicate = productService.checkCategoryDuplicate(dto);
    log.info("중복 결과: {}", isDuplicate);
    return isDuplicate ? "true" : "false";
  }
  
  // 제품 중복 확인
  @GetMapping("/check")
  @ResponseBody
  public String qhCheckProductDuplicate(@RequestParam String categoryMid, @RequestParam String categorySub,
                                        @RequestParam String productName,
                                        @RequestParam(value = "productCode", required = false) String productCode) {
    log.info("GET - 제품 중복 확인 요청: categoryMid={}, categorySub={}, productName={}, productCode={}", categoryMid, categorySub, productName, productCode);
    
    ProductCheckDTO dto = new ProductCheckDTO();
    dto.setCategoryMid(categoryMid);
    dto.setCategorySub(categorySub); // 조합해서 카테고리 코드 만들어야함
    dto.setProductName(productName);
    dto.setProductCode(productCode); // 등록은 NULL 수정은 수정대상
    
    boolean isDuplicate = productService.checkProductDuplicate(dto);
    log.info("중복 결과: {}", isDuplicate);
    return isDuplicate ? "true" : "false";
  }
}