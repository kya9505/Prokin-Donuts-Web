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
  
  //
  @Override
  public List<CategorySelectDTO> findCategoryList() {
    return productMapper.selectCategoryList();
  }
  
  @Override
  @Transactional
  public void saveCategory(CategoryInsertDTO dto) {
    CategoryMainVO vo = modelMapper.map(dto, CategoryMainVO.class);
    productMapper.insertCategory(vo);
    log.info("새 카테고리 등록: {}", vo);
  }
  
  @Override
  @Transactional
  public void deleteCategory(CategoryDeleteDTO dto) {
    CategoryMainVO vo = modelMapper.map(dto, CategoryMainVO.class);
    productMapper.deleteCategory(vo);
    log.info("카테고리 삭제: {}", vo.getCategoryCode());
  }
  
  @Override
  public List<ProductSelectDTO> findProductList() {
    return productMapper.selectProductList();
  }
  
  @Override
  @Transactional
  public void saveProduct(ProductInsertDTO dto) {
    ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
    productMapper.insertProduct(vo);
    log.info("새 제품 등록: {}", vo);
  }
  
  @Override
  @Transactional
  public void updateProduct(ProductInsertDTO dto) {
    ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
    productMapper.updateProduct(vo);
    log.info("제품 수정: {}", vo);
  }
  
  @Override
  @Transactional
  public void deleteProduct(ProductDeleteDTO dto) {
    ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
    productMapper.deleteProduct(vo);
    log.info("제품 삭제: {}", vo.getProductCode());
  }
  
  @Override
  public boolean checkProductDuplicate(ProductCheckDTO dto) {
    ProductMainVO vo = modelMapper.map(dto, ProductMainVO.class);
    return productMapper.checkProductDuplicate(vo);
  }
  
  @Override
  public boolean checkCategoryDuplicate(CategoryCheckDTO dto) {
    CategoryMainVO vo = modelMapper.map(dto, CategoryMainVO.class);
    return productMapper.checkCategoryDuplicate(vo);
  }
  
  @Override
  public String findProductStatus(String productCode) {
    String status = productMapper.findProductStatus(productCode);
    log.info("findProductStatus({}) = {}", productCode, status);
    return status;
  }
  
  @Override
  public String findCategoryStatus(String categoryCode) {
    String status = productMapper.findCategoryStatus(categoryCode);
    log.info("findCategoryStatus({}) = {}", categoryCode, status);
    return status;
  }
  
  // 필요 시, 등록용 카테고리 코드 생성 로직
  @SuppressWarnings("unused")
  private String generateCategoryCode(String base) {
    return base + "-" + System.currentTimeMillis();
  }
}