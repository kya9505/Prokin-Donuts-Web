package com.donut.prokindonutsweb.product.service;

import com.donut.prokindonutsweb.product.dto.*;
import com.donut.prokindonutsweb.product.vo.CategoryMainVO;
import com.donut.prokindonutsweb.product.vo.ProductMainVO;

import java.util.List;

public interface ProductService {
  // 🔹 카테고리
  List<CategorySelectDTO> findCategoryList();
  void saveCategory(CategoryInsertDTO categoryInsertDTO);
  void deleteCategories(List<String> categoryCodeList); // ✅ 일괄 삭제로 변경
  boolean checkCategoryDuplicate(CategoryCheckDTO categoryCheckDTO);
  String findCategoryStatus(String categoryCode);
  
  // 🔹 제품
  List<ProductSelectDTO> findProductList();
  void saveProduct(ProductInsertDTO productInsertDTO);
  void updateProducts(List<ProductInsertDTO> productInsertDTOList); // ✅ 일괄 수정으로 변경
  void deleteProducts(List<String> productCodeList);                // ✅ 일괄 삭제로 변경
  boolean checkProductDuplicate(ProductCheckDTO productCheckDTO);
  String findProductStatus(String productCode);
}
