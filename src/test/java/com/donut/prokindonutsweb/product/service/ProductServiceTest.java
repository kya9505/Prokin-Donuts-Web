package com.donut.prokindonutsweb.product.service;

import com.donut.prokindonutsweb.product.dto.*;
import com.donut.prokindonutsweb.product.mapper.ProductMapper;
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
  @Autowired
  private ProductMapper productMapper;
  
  @Test
  @DisplayName("전체 카테고리 목록 조회")
  void testFindCategoryList() {
    List<CategorySelectDTO> list = productService.findCategoryList();
    assertThat(list).isNotEmpty();
    log.info("카테고리 목록: {}", list);
  }
  
  @Test
  @DisplayName("카테고리 등록 및 삭제 (중복체크 없이 실제 데이터로 확인)")
  void testSaveAndDeleteCategory_withoutDuplicateCheck() {
    // 1) 등록용 DTO 생성
    CategoryInsertDTO insertDTO = new CategoryInsertDTO();
    insertDTO.setCategoryCode("TSTCAT");
    insertDTO.setCategoryMid("테스트중분류");
    insertDTO.setCategorySub("테스트소분류");
    
    // 2) 카테고리 등록
    productService.saveCategory(insertDTO);
    
    // 3) 전체 카테고리 목록에서 등록된 항목 존재 확인
    List<CategorySelectDTO> listAfterInsert = productService.findCategoryList();
    boolean existsAfterInsert = listAfterInsert.stream()
        .anyMatch(c -> c.getCategoryCode().equals("TSTCAT") &&
            c.getCategoryMid().equals("테스트중분류") &&
            c.getCategorySub().equals("테스트소분류"));
    assertThat(existsAfterInsert).isTrue();
    
    // 4) 삭제용 DTO 생성
    CategoryDeleteDTO deleteDTO = new CategoryDeleteDTO();
    deleteDTO.setCategoryCode("TSTCAT");
    
    // 5) 카테고리 삭제
    productService.deleteCategory(deleteDTO);
    
    // 6) 전체 목록에서 삭제된 항목이 사라졌는지 확인
    List<CategorySelectDTO> listAfterDelete = productService.findCategoryList();
    boolean existsAfterDelete = listAfterDelete.stream()
        .anyMatch(c -> c.getCategoryCode().equals("TSTCAT"));
    assertThat(existsAfterDelete).isFalse();
  }
  
  @Test
  @DisplayName("전체 제품 목록 조회")
  void testFindProductList() {
    List<ProductSelectDTO> list = productService.findProductList();
    assertThat(list).isNotEmpty();
    log.info("제품 목록: {}", list);
  }
  
  @Test
  @DisplayName("제품 등록/수정/삭제 (중복검사 함수 없이)")
  void testSaveUpdateDeleteProduct_withoutDuplicateCheck() {
    // 1) 등록용 DTO 생성
    ProductInsertDTO dto = new ProductInsertDTO();
    dto.setProductName("테스트제품V2");
    dto.setProductPrice(100);
    dto.setStoredType("냉장");
    dto.setCategoryMid("도넛");
    dto.setCategorySub("프로틴 도넛");
    
    // 2) 등록
    productService.saveProduct(dto);
    
    // 3) 제품 목록에서 등록된 제품 존재 여부 확인
    List<ProductSelectDTO> listAfterInsert = productService.findProductList();
    boolean existsAfterInsert = listAfterInsert.stream()
        .anyMatch(p -> p.getProductName().equals("테스트제품V2"));
    assertThat(existsAfterInsert).isTrue();
    
    // 4) 수정
    dto.setProductName("테스트 제품 수정");
    dto.setProductPrice(2000);
    productService.updateProduct(dto);
    
    // 5) 수정 확인
    List<ProductSelectDTO> listAfterUpdate = productService.findProductList();
    boolean updated = listAfterUpdate.stream()
        .anyMatch(p -> p.getProductName().equals("테스트 제품 수정") &&
            p.getProductPrice() == 2000);
    assertThat(updated).isTrue();
    
    // 6) 삭제
    ProductDeleteDTO deleteDTO = new ProductDeleteDTO();
    deleteDTO.setProductCode(dto.getProductCode());
    productService.deleteProduct(deleteDTO);
    
    // 7) 삭제 확인
    List<ProductSelectDTO> listAfterDelete = productService.findProductList();
    boolean existsAfterDelete = listAfterDelete.stream()
        .anyMatch(p -> p.getProductCode().equals(dto.getProductCode()));
    assertThat(existsAfterDelete).isFalse();
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
