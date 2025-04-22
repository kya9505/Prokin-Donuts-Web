package com.donut.prokindonutsweb.product.service;

import com.donut.prokindonutsweb.product.dto.*;
import com.donut.prokindonutsweb.product.vo.CategoryMainVO;
import com.donut.prokindonutsweb.product.vo.ProductMainVO;

import java.util.List;

public interface ProductService {
  List<CategorySelectDTO> findCategoryList();
  void saveCategory(CategoryInsertDTO categoryInsertDTO);
  void deleteCategory(CategoryDeleteDTO categoryDeleteDTO);
  
  List<ProductSelectDTO> findProductList();
  void saveProduct(ProductInsertDTO productInsertDTO);
  void updateProduct(ProductInsertDTO productInsertDTO);
  void deleteProduct(ProductDeleteDTO productDeleteDTO);
  
  boolean checkProductDuplicate(ProductCheckDTO productCheckDTO);
  boolean checkCategoryDuplicate(CategoryCheckDTO categoryCheckDTO);
  
  String findProductStatus(String productCode);
  String findCategoryStatus(String categoryCode);
}
