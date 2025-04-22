package com.donut.prokindonutsweb.product.mapper;

import com.donut.prokindonutsweb.product.dto.CategorySelectDTO;
import com.donut.prokindonutsweb.product.dto.ProductSelectDTO;
import com.donut.prokindonutsweb.product.vo.CategoryMainVO;
import com.donut.prokindonutsweb.product.vo.ProductMainVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProductMapper {
  List<CategorySelectDTO> selectCategoryList();
  void insertCategory(CategoryMainVO categoryMainVO);
  void deleteCategory(CategoryMainVO categoryMainVO);
  
  List<ProductSelectDTO> selectProductList();
  void insertProduct(ProductMainVO productMainVO);
  void updateProduct(ProductMainVO productMainVO);
  void deleteProduct(ProductMainVO productMainVO);
  
  boolean checkCategoryDuplicate(CategoryMainVO categoryMainVO);
  boolean checkProductDuplicate(ProductMainVO productMainVO);
  
  String selectCategoryStatus(@Param("categoryCode") String categoryCode);
  String selectProductStatus(@Param("productCode") String productCode);
  
  String selectCategoryCodeByMidSub(@Param("mid") String mid, @Param("sub") String sub);
  List<String> selectProductCodesByPrefix(@Param("prefix") String prefix);
}
