package com.donut.prokindonutsweb.product.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CategoryFilterMapper {
  List<String> selectCategoryMid();
  List<String> selectSubCategoryByMid(@Param("categoryMid") String categoryMid);
}
