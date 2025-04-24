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
    List<CategorySelectDTO> list = productMapper.selectCategoryList();
    log.info("전체 카테고리 목록 조회: {}", list.size());
    return list;
  }
  
  // 카테고리 등록
  @Override
  @Transactional
  public void saveCategory(CategoryInsertDTO dto) {
    CategoryMainVO vo = modelMapper.map(dto, CategoryMainVO.class);
    productMapper.insertCategory(vo);
    log.info("카테고리 등록 완료: {}", vo);
  }
  
  // 카테고리 일괄 삭제
  @Override
  @Transactional
  public void deleteCategories(List<String> categoryCodeList) {
    productMapper.deleteCategoriesByCodes(categoryCodeList);
    log.info("카테고리 일괄 삭제 완료: {}", categoryCodeList);
  }
  
  // 전체 제품 목록 조회
  @Override
  public List<ProductSelectDTO> findProductList() {
    List<ProductSelectDTO> list = productMapper.selectProductList();
    log.info("전체 제품 목록 조회: {}", list.size());
    return list;
  }
  
  // 제품 등록
  @Override
  @Transactional
  public void saveProduct(ProductInsertDTO dto) {
    String newCategoryCode = generateCategoryCodeByMidSub(dto.getCategoryMid(), dto.getCategorySub());
    log.info("제품 등록용 카테고리코드 생성: {}", newCategoryCode);
    
    List<String> existingCodes = productMapper.selectProductCodesByPrefix(newCategoryCode + "%");
    int nextNum = existingCodes.stream()
        .map(code -> code.replaceFirst("^" + newCategoryCode, ""))
        .filter(str -> str.matches("\\d+"))
        .mapToInt(Integer::parseInt)
        .max()
        .orElse(0) + 1;
    
    String newProductCode = newCategoryCode + nextNum;
    dto.setProductCode(newProductCode);
    ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
    vo.setCategoryCode(newCategoryCode);
    productMapper.insertProduct(vo);
    
    log.info("제품 등록 완료: {}", vo);
  }
  
  // 제품 일괄 수정
  @Override
  @Transactional
  public void updateProducts(List<ProductInsertDTO> dtoList) {
    List<ProductMainVO> voList = dtoList.stream().map(dto -> {
      ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
      String newCategoryCode = generateCategoryCodeByMidSub(dto.getCategoryMid(), dto.getCategorySub());
      vo.setCategoryCode(newCategoryCode);
      return vo;
    }).toList();
    
    productMapper.updateProduct(voList);
    log.info("제품 일괄 수정 완료: {}", voList);
  }
  
  // 제품 일괄 삭제
  @Override
  @Transactional
  public void deleteProducts(List<String> productCodeList) {
    productMapper.deleteProductsByCodes(productCodeList);
    log.info("제품 일괄 삭제 완료: {}", productCodeList);
  }
  
  // 제품 중복체크
  @Override
  public boolean checkProductDuplicate(ProductCheckDTO dto) {
    ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
    boolean isDuplicate = productMapper.checkProductDuplicate(vo) > 0;
    log.info("제품 중복체크 결과 [{}]: {}", vo.getProductName(), isDuplicate);
    return isDuplicate;
  }
  
  // 카테고리 중복체크
  @Override
  public boolean checkCategoryDuplicate(CategoryCheckDTO dto) {
    boolean isDuplicate = productMapper.checkCategoryCodeDuplicate(
        dto.getCategoryCode(), dto.getCategoryMid(), dto.getCategorySub()
    );
    log.info("카테고리 중복체크 [{}]: {}", dto.getCategoryCode(), isDuplicate);
    return isDuplicate;
  }
  
  // 제품 상태 확인
  @Override
  public String findProductStatus(String productCode) {
    String status = productMapper.selectProductStatus(productCode);
    log.info("제품 상태 조회 [{}]: {}", productCode, status);
    return status;
  }
  
  // 카테고리 상태 확인
  @Override
  public String findCategoryStatus(String categoryCode) {
    String status = productMapper.selectCategoryStatus(categoryCode);
    log.info("카테고리 상태 조회 [{}]: {}", categoryCode, status);
    return status;
  }
  
  // 내부 헬퍼 - 중분류/소분류로 카테고리코드 생성
  private String generateCategoryCodeByMidSub(String categoryMid, String categorySub) {
    log.info("카테고리코드 조회 요청: 중분류={}, 소분류={}", categoryMid, categorySub);
    String categoryCode = productMapper.selectCategoryCodeByMidSub(categoryMid, categorySub);
    if (categoryCode == null) {
      throw new IllegalArgumentException("해당 중분류/소분류에 해당하는 카테고리코드가 없습니다.");
    }
    log.info("조회된 카테고리코드: {}", categoryCode);
    return categoryCode;
  }
}