package com.donut.prokindonutsweb.product.service;

import java.util.List;

public interface CategoryFilterService {
  List<String> findCategoryMidList();
  List<String> findSubCategoryListByMid(String categoryMid);
}
