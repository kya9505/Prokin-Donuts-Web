package com.donut.prokindonutsweb.product.service;

import com.donut.prokindonutsweb.product.mapper.CategoryFilterMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class CategoryFilterServiceImpl implements CategoryFilterService {
  
  private final CategoryFilterMapper categoryFilterMapper;
  
  // 전체 중분류 목록
  @Override
  public List<String> findCategoryMidList() {
    return categoryFilterMapper.selectCategoryMid();
  }
  
  public List<String> findSubCategoryListByMid(String mid) {
    try {
      return categoryFilterMapper.selectSubCategoryByMid(mid);
    } catch (Exception e) {
      log.error("🔥 소분류 조회 중 오류 발생", e);
      return List.of();
    }
  }
}
