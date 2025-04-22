package com.donut.prokindonutsweb.product.controller;

import com.donut.prokindonutsweb.product.service.ProductService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
@WebAppConfiguration
@EnableWebMvc
@Transactional
class ProductControllerTest {
  
  @Autowired
  private WebApplicationContext context;
  
  private MockMvc mockMvc;
  
  @Autowired
  private ProductService productService;
  
  @BeforeEach
  void setup() {
    mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
  }
  
  @Test
  @DisplayName("GET /qh/product - 목록 페이지 접근")
  void testGetProductPage() throws Exception {
    mockMvc.perform(get("/qh/product"))
        .andExpect(status().isOk())
        .andExpect(model().attributeExists("categoryList"))
        .andExpect(model().attributeExists("productList"));
  }
  
  @Test
  @DisplayName("POST /qh/product/add - 제품 등록 요청")
  void testAddProduct() throws Exception {
    mockMvc.perform(post("/qh/product/add")
            .param("productName", "테스트제품123")
            .param("productPrice", "1000")
            .param("storedType", "냉장")
            .param("categoryMid", "도넛")
            .param("categorySub", "저당 도넛"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("/qh/product"));
  }
  
  @Test
  @DisplayName("POST /qh/product/update - 제품 수정")
  void testUpdateProduct() throws Exception {
    mockMvc.perform(post("/qh/product/update")
            .param("productCode", "P001")
            .param("productName", "수정된제품")
            .param("productPrice", "1500")
            .param("storedType", "냉장")
            .param("categoryMid", "도넛")
            .param("categorySub", "저당 도넛"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("/qh/product"));
  }
  
  @Test
  @DisplayName("POST /qh/product/delete - 제품 삭제")
  void testDeleteProduct() throws Exception {
    mockMvc.perform(post("/qh/product/delete")
            .param("productCode", "P001"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("/qh/product"));
  }
  
  @Test
  @DisplayName("POST /qh/product/category/add - 카테고리 등록")
  void testAddCategory() throws Exception {
    mockMvc.perform(post("/qh/product/category/add")
            .param("categoryCode", "CAT001")
            .param("categoryMid", "도넛")
            .param("categorySub", "프로틴 도넛11"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("/qh/product"));
  }
  
  @Test
  @DisplayName("POST /qh/product/category/delete - 카테고리 삭제")
  void testDeleteCategory() throws Exception {
    mockMvc.perform(post("/qh/product/category/delete")
            .param("categoryCode", "CAT001"))
        .andExpect(status().is3xxRedirection())
        .andExpect(redirectedUrl("/qh/product"));
  }
  
  @Test
  @DisplayName("GET /qh/product/check - 제품 중복 확인 (등록 시, 사전 등록 포함)")
  void testProductCheckWithInsert() throws Exception {
    // 제품 사전 등록
    mockMvc.perform(post("/qh/product/add")
            .param("productName", "테스트제품")
            .param("productPrice", "1000")
            .param("storedType", "냉장")
            .param("categoryMid", "도넛")
            .param("categorySub", "프로틴 도넛")) // DPN 카테고리로 자동 연결됨
        .andExpect(status().is3xxRedirection());
    
    // 중복 확인
    MvcResult result = mockMvc.perform(get("/qh/product/check")
            .param("categoryCode", "DPN")
            .param("productName", "테스트제품"))
        .andExpect(status().isOk())
        .andReturn();
    
    String content = result.getResponse().getContentAsString();
    assertEquals("true", content); // 이제 진짜 true 나옴
  }
  
  @Test
  @DisplayName("GET /qh/product/check - 제품 중복 확인 (수정 시, Hamcrest 없이)")
  void testProductCheckOnUpdateWithoutHamcrest() throws Exception {
    MvcResult result = mockMvc.perform(get("/qh/product/check")
            .param("categoryCode", "DPN")
            .param("productName", "테스트제품")
            .param("productCode", "DPN13")) // 자기 자신 제외하고 검사
        .andExpect(status().isOk())
        .andReturn();
    
    String content = result.getResponse().getContentAsString();
    assertEquals("false", content); // 자기 자신이므로 중복 아님
  }
  
  @Test
  @DisplayName("GET /qh/product/category/check - 카테고리 중복 확인 (Hamcrest 없이)")
  void testCategoryCheckWithoutHamcrest() throws Exception {
    MvcResult result = mockMvc.perform(get("/qh/product/category/check")
            .param("categoryCode", "TST")
            .param("middleName", "도넛")
            .param("smallName", "프로틴 도넛"))
        .andExpect(status().isOk())
        .andReturn();
    
    String content = result.getResponse().getContentAsString();
    assertEquals("false", content); // 실제 결과에 맞춰 true/false 선택
  }
}