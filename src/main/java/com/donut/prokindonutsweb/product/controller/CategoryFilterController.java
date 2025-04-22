package com.donut.prokindonutsweb.product.controller;

import com.donut.prokindonutsweb.product.service.CategoryFilterService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/category/check")
public class CategoryFilterController {
  private final CategoryFilterService categoryFilterService;
  
  @GetMapping(produces = "application/json; charset=UTF-8")
  @ResponseBody
  public List<String> getSubCategoryList(@RequestParam("categoryMid") String categoryMid) {
    
    if (categoryMid == null || categoryMid.trim().isEmpty() || "중분류 선택".equals(categoryMid)) {
      System.out.println("test : " + categoryMid);
      return List.of();
    }
    
    return categoryFilterService.findSubCategoryListByMid(categoryMid);
  }
}
