package com.donut.prokindonutsweb.product.service;

import com.donut.prokindonutsweb.product.dto.*;
import com.donut.prokindonutsweb.product.mapper.ProductMapper;
import com.donut.prokindonutsweb.product.vo.CategoryMainVO;
import com.donut.prokindonutsweb.product.vo.ProductMainVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ProductServiceImpl implements ProductService {
  
  private final ProductMapper productMapper;
  private final ModelMapper modelMapper;
  
  // 전체 카테고리 목록 조회
  @Override
  public List<CategorySelectDTO> findCategoryList() {
    return productMapper.selectCategoryList();
  }
  
  // 카테고리 등록
  @Override
  @Transactional
  public void saveCategory(CategoryInsertDTO dto) {
    CategoryMainVO vo = modelMapper.map(dto, CategoryMainVO.class);
    productMapper.insertCategory(vo);
    log.info("새 카테고리 등록: {}", vo);
  }
  
  // 카테고리 삭제
  @Override
  @Transactional
  public void deleteCategory(CategoryDeleteDTO dto) {
    CategoryMainVO vo = modelMapper.map(dto, CategoryMainVO.class);
    productMapper.deleteCategory(vo);
    log.info("카테고리 삭제: {}", vo.getCategoryCode());
  }
  
  // 전체 제품 목록 조회
  @Override
  public List<ProductSelectDTO> findProductList() {
    return productMapper.selectProductList();
  }
  
  // 제품 코드 생성 함수 (제품 등록에 사용)
  private String generateCategoryCodeByMidSub(String categoryMid, String categorySub) {
    log.info("중분류={}, 소분류={}", categoryMid, categorySub);
    
    // 1. 중분류 + 소분류로 카테고리코드 조회
    String categoryCode = productMapper.selectCategoryCodeByMidSub(categoryMid, categorySub);
    if (categoryCode == null) {
      throw new IllegalArgumentException("해당 중분류/소분류에 해당하는 카테고리코드가 없습니다.");
    }
    
    log.info("조회된 카테고리코드 = {}", categoryCode);
    return categoryCode;
  }
  
  // 제품 등록
  @Override
  @Transactional
  public void saveProduct(ProductInsertDTO dto) {
    // 2) 자동 생성된 새 제품코드 만들기
    String newCategoryCode = generateCategoryCodeByMidSub(dto.getCategoryMid(), dto.getCategorySub());
    
    log.info("newCategoryCode={}", newCategoryCode);
    // 2-1. 해당 newCategoryCode로 시작하는 제품코드 목록 조회
    List<String> existingCodes = productMapper.selectProductCodesByPrefix(newCategoryCode + "%");
    
    // 2-2. 숫자만 추출하여 최대값 + 1 결정
    int nextNum = existingCodes.stream()
        .map(code -> code.replaceFirst("^" + newCategoryCode, "")) // prefix 제거
        .filter(str -> str.matches("\\d+")) // 숫자만 필터링
        .mapToInt(Integer::parseInt)
        .max()
        .orElse(0) + 1;
    
    log.info("newCategoryCode={}, nextNum={}", newCategoryCode, nextNum);
    dto.setProductCode(newCategoryCode + nextNum);
    
    // 3) VO로 매핑 후 삽입
    ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
    vo.setCategoryCode(newCategoryCode);
    productMapper.insertProduct(vo);
    
    log.info("새 제품 등록: {}", vo);
  }
  
  // 제품 수정
  @Override
  @Transactional
  public void updateProduct(ProductInsertDTO dto) {
    String newCategoryCode = generateCategoryCodeByMidSub(dto.getCategoryMid(), dto.getCategorySub());
    ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
    vo.setCategoryCode(newCategoryCode);
    productMapper.updateProduct(vo);
    log.info("제품 수정: {}", vo);
  }
  
  // 제품 삭제
  @Override
  @Transactional
  public void deleteProduct(ProductDeleteDTO dto) {
    ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
    productMapper.deleteProduct(vo);
    log.info("제품 삭제: {}", vo.getProductCode());
  }
  
  // 제품 중복체크 (등록, 수정시 사용)
  @Override
  public boolean checkProductDuplicate(ProductCheckDTO dto) {
    ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
    return productMapper.checkProductDuplicate(vo) > 0;
  }
  
  // 카테고리 중복확인 (등록시 사용)
  @Override
  public boolean checkCategoryDuplicate(CategoryCheckDTO dto) {
    CategoryMainVO vo = modelMapper.map(dto, CategoryMainVO.class);
    return productMapper.checkCategoryDuplicate(vo) > 0;
  }
  
  // 제품 상태 확인
  @Override
  public String findProductStatus(String productCode) {
    String status = productMapper.selectProductStatus(productCode);
    log.info("findProductStatus({}) = {}", productCode, status);
    return status;
  }
  
  // 카테고리 상태 확인
  @Override
  public String findCategoryStatus(String categoryCode) {
    String status = productMapper.selectCategoryStatus(categoryCode);
    log.info("findCategoryStatus({}) = {}", categoryCode, status);
    return status;
  }
}