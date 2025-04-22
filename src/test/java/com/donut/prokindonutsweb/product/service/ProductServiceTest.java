package com.donut.prokindonutsweb.product.service;

import com.donut.prokindonutsweb.product.dto.*;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Transactional
class ProductServiceTest {
  
  @Autowired
  private ProductService productService;
  
  @Test
  @DisplayName("전체 카테고리 목록 조회")
  void testFindCategoryList() {
    List<CategorySelectDTO> list = productService.findCategoryList();
    assertThat(list).isNotEmpty();
    log.info("카테고리 목록: {}", list);
  }
  
  @Test
  @DisplayName("카테고리 등록 및 삭제")
  void testSaveAndDeleteCategory() {
    CategoryInsertDTO insertDTO = new CategoryInsertDTO();
    insertDTO.setCategoryCode("TSTCAT");
    insertDTO.setCategoryMid("테스트중분류");
    insertDTO.setCategorySub("테스트소분류");
    productService.saveCategory(insertDTO);
    
    CategoryCheckDTO checkDTO = new CategoryCheckDTO();
    checkDTO.setCategoryCode("TSTCAT");
    assertThat(productService.checkCategoryDuplicate(checkDTO)).isTrue();
    
    CategoryDeleteDTO deleteDTO = new CategoryDeleteDTO();
    deleteDTO.setCategoryCode("TSTCAT");
    productService.deleteCategory(deleteDTO);
    
    assertThat(productService.checkCategoryDuplicate(checkDTO)).isFalse();
  }
  
  @Test
  @DisplayName("전체 제품 목록 조회")
  void testFindProductList() {
    List<ProductSelectDTO> list = productService.findProductList();
    assertThat(list).isNotEmpty();
    log.info("제품 목록: {}", list);
  }
  
  @Test
  @DisplayName("제품 등록/수정/삭제")
  void testSaveUpdateDeleteProduct() {
    ProductInsertDTO dto = new ProductInsertDTO();
    dto.setProductName("테스트제품V2");
    dto.setProductPrice(100);
    dto.setStoredType("냉장");
    dto.setCategoryMid("도넛");
    dto.setCategorySub("프로틴 도넛");
    
    productService.saveProduct(dto);
    
    ProductCheckDTO checkDTO = new ProductCheckDTO();
    checkDTO.setProductCode(dto.getProductCode());
    assertThat(productService.checkProductDuplicate(checkDTO)).isTrue();
    
    // 수정
    dto.setProductName("테스트 제품 수정");
    dto.setProductPrice(2000);
    productService.updateProduct(dto);
    
    // 삭제
    ProductDeleteDTO deleteDTO = new ProductDeleteDTO();
    deleteDTO.setProductCode(dto.getProductCode());
    productService.deleteProduct(deleteDTO);
    
    assertThat(productService.checkProductDuplicate(checkDTO)).isFalse();
  }
  
  @Test
  @DisplayName("제품 상태 확인")
  void testFindProductStatus() {
    String status = productService.findProductStatus("DPN1");
    assertThat(status).isIn("재고있음", "입고진행", "발주진행", "삭제가능");
    log.info("제품 상태: {}", status);
  }
  
  @Test
  @DisplayName("카테고리 상태 확인")
  void testFindCategoryStatus() {
    String status = productService.findCategoryStatus("DPN");
    assertThat(status).isIn("제품등록", "입고진행", "발주진행", "삭제가능", "재고있음");
    log.info("카테고리 상태: {}", status);
  }
}
