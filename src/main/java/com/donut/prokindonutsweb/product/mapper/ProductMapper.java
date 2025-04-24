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
  // Category 관련
  List<CategorySelectDTO> selectCategoryList();
  void insertCategory(CategoryMainVO categoryMainVO);
  void deleteCategoriesByCodes(@Param("list") List<String> categoryCodes); // 일괄 삭제
  boolean checkCategoryCodeDuplicate(@Param("categoryCode") String code,
                                     @Param("categoryMid") String mid,
                                     @Param("categorySub") String sub);
  String selectCategoryStatus(@Param("categoryCode") String categoryCode);
  String selectCategoryCodeByMidSub(@Param("mid") String mid, @Param("sub") String sub);
  
  // Product 관련
  List<ProductSelectDTO> selectProductList();
  void insertProduct(ProductMainVO productMainVO);
  void updateProduct(@Param("list") List<ProductMainVO> productList); // 일괄 수정
  void deleteProductsByCodes(@Param("list") List<String> productCodes); // 일괄 삭제
  int checkProductDuplicate(ProductMainVO productMainVO);
  String selectProductStatus(@Param("productCode") String productCode);
  List<String> selectProductCodesByPrefix(@Param("prefix") String prefix);
}