package com.donut.prokindonutsweb.product.mapper;

import com.donut.prokindonutsweb.product.dto.CategorySelectDTO;
import com.donut.prokindonutsweb.product.dto.ProductSelectDTO;
import com.donut.prokindonutsweb.product.vo.CategoryMainVO;
import com.donut.prokindonutsweb.product.vo.ProductMainVO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.assertj.core.api.AssertionsForInterfaceTypes.assertThat;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Transactional
class ProductMapperTest {
    
    @Autowired
    private ProductMapper mapper;
    
    @Test
    @DisplayName("1. 전체 카테고리 조회")
    void testSelectCategoryList() {
        // 전체 카테고리 리스트 조회 시도
        List<CategorySelectDTO> list = mapper.selectCategoryList();
        // 비어있지 않으면 테스트 성공
        assertThat(list).isNotEmpty();
        // 결과물 출력
        log.info("조회된 카테고리들: {}", list);
    }
    
    @Test
    @DisplayName("2. 카테고리 추가/중복체크/삭제")
    void testInsertAndDeleteCategory() {
        // 테스트용 VO 객체 생성
        CategoryMainVO vo = new CategoryMainVO();
        // 테스트용 카테고리 코드 설정
        vo.setCategoryCode("TST");
        // 테스트용 중분류명 설정
        vo.setCategoryMid("테스트중분류");
        // 테스트용 소분류명 설정
        vo.setCategorySub("테스트소분류");
        
        // 1) 삽입 전 중복 체크
        boolean dupBefore = mapper.checkCategoryDuplicate(vo);
        // 중복되지 않아야 함
        assertThat(dupBefore).isFalse();
        // 중복여부 출력
        log.info(dupBefore);
        
        // 2) 카테고리 삽입
        mapper.insertCategory(vo);
        // 삽입 후 중복 체크
        boolean dupAfterInsert = mapper.checkCategoryDuplicate(vo);
        // 삽입했으니 중복이어야 함
        assertThat(dupAfterInsert).isTrue();
        // 중복여부 출력
        log.info(dupAfterInsert);
        
        // 3) 삽입된 카테고리의 상태 조회
        String status = mapper.selectCategoryStatus("TST");
        // 상태는 "제품등록" 또는 "삭제가능"이어야 함
        assertThat(status).isIn("제품등록", "삭제가능");
        // 카테고리 상태 출력
        log.info(status);
        
        // 4) 카테고리 삭제
        mapper.deleteCategory(vo);
        // 삭제 후 다시 중복 체크
        boolean dupAfterDelete = mapper.checkCategoryDuplicate(vo);
        // 삭제했으므로 중복이 아니어야 함
        assertThat(dupAfterDelete).isFalse();
        // 중복여부 출력
        log.info(dupAfterDelete);
    }
    
    @Test
    @DisplayName("3. 전체 제품 조회")
    void testSelectProductList() {
        // 1) 전체 제품 리스트 조회 시도
        List<ProductSelectDTO> products = mapper.selectProductList();
        // 2) 비어있지 않으면 테스트 성공
        assertThat(products).isNotEmpty();
        // 3) 결과물 출력
        log.info("조회된 제품들: {}", products);
    }
    
    @Test
    @DisplayName("4. 제품 추가/수정/중복체크/삭제")
    void testInsertUpdateDeleteProduct() {
        // 1) 테스트용 VO 객체 생성 및 초기값 설정
        ProductMainVO vo = new ProductMainVO();
        vo.setProductCode("PST");
        vo.setProductName("테스트제품");
        vo.setProductPrice(1000);
        vo.setCategoryCode("DPN");
        vo.setStoredType("냉장");
        
        // 2) 삽입 전 중복 체크
        boolean dupBefore = mapper.checkProductDuplicate(vo);
        assertThat(dupBefore).isFalse();
        log.info("삽입 전 중복여부: {}", dupBefore);
        
        // 3) 제품 삽입
        mapper.insertProduct(vo);
        boolean dupAfterInsert = mapper.checkProductDuplicate(vo);
        assertThat(dupAfterInsert).isTrue();
        log.info("삽입 후 중복여부: {}", dupAfterInsert);
        
        // 4) 제품 정보 수정
        vo.setProductName("테스트제품수정");
        vo.setProductPrice(2000);
        mapper.updateProduct(vo);
        
        // 수정 후 전체 리스트 조회 및 수정된 항목 존재 확인
        List<ProductSelectDTO> list = mapper.selectProductList();
        boolean foundUpdated = list.stream()
            .anyMatch(p -> "PST".equals(p.getProductCode())
                && "테스트제품수정".equals(p.getProductName())
                && p.getProductPrice() == 2000);
        assertThat(foundUpdated).isTrue();
        log.info("수정된 제품 존재여부: {}", foundUpdated);
        
        // 5) 수정된 제품의 상태 조회 (PST)
        String pStatus = mapper.selectProductStatus("PST");
        assertThat(pStatus).isIn("삭제가능","재고있음","입고진행","발주진행");
        log.info("PST 상태: {}", pStatus);
        
        // 6) 제품 삭제
        mapper.deleteProduct(vo);
        boolean dupAfterDelete = mapper.checkProductDuplicate(vo);
        assertThat(dupAfterDelete).isFalse();
        log.info("삭제 후 중복여부: {}", dupAfterDelete);
    }
    
    
    @Test
    @DisplayName("중분류 + 소분류로 카테고리코드 조회")
    void testSelectCategoryCodeByMidSub() {
        String mid = "도넛";
        String sub = "프로틴 도넛";
        String code = mapper.selectCategoryCodeByMidSub(mid, sub);
        
        assertThat(code).isEqualTo("DPN");
        log.info("카테고리코드 = {}", code);
    }
    
    @Test
    @DisplayName("prefix로 시작하는 제품코드들 조회")
    void testSelectProductCodesByPrefix() {
        String prefix = "DPN%";
        List<String> codes = mapper.selectProductCodesByPrefix(prefix);
        
        assertThat(codes).isNotEmpty();
        log.info("조회된 제품코드 목록 = {}", codes);
    }

// ----------------------
// Category 상태별 테스트
// ----------------------
    
    @Test
    @DisplayName("Category 상태 - 삭제가능")
    void testCategoryStatus_Deletable() {
        // 존재하지 않는 코드
        String status = mapper.selectCategoryStatus("ZZZ");
        assertThat(status).isEqualTo("삭제가능");
        log.info("ZZZ 상태: {}", status);
    }

    @Test
    @DisplayName("Category 상태 - 제품등록 (@Sql)")
    @Sql(statements = {
        // 재고가 있으면 우선 '재고있음'이 나오므로 해당 카테고리 제품들 삭제
        "DELETE FROM Inventory WHERE productCode IN (SELECT productCode FROM Product WHERE categoryCode = 'CDC')"
    }, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
    void ttestCategoryStatus_Registered_WithSql() {
        String status = mapper.selectCategoryStatus("CDC");
        assertThat(status).isEqualTo("제품등록");
        log.info("CDC 상태: {}", status);
    }
    
    @Test
    @DisplayName("Category 상태 - 재고있음 (@Sql)")
    @Sql(statements = {
        // DGL1 제품에 대해 재고 삽입
        "INSERT INTO Inventory(inventoryCode, warehouseCode, productCode, quantity) " +
            "VALUES('TST-INV','GG1','DGL1',10)"
    }, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
    void testCategoryStatus_InStock_WithSql() {
        String status = mapper.selectCategoryStatus("DGL");
        assertThat(status).isEqualTo("재고있음");
        log.info("DGL 상태: {}", status);
    }
    
    @Test
    @DisplayName("Category 상태 - 입고진행 (@Sql)")
    @Sql(statements = {
        // 1) 해당 카테고리(Product WHERE categoryCode='CDC') 제품의 Inventory 기록 삭제
        "DELETE FROM Inventory " +
            "WHERE productCode IN (SELECT productCode FROM Product WHERE categoryCode = 'CDC')",
        // 2) Inbound 헤더 INSERT (FK 제약 회피)
        "INSERT INTO `Inbound` (inboundCode, inboundDate, warehouseCode, inboundStatus) " +
            "VALUES ('TST-INB','2025-04-22','GG1', '승인대기')",
        // 3) InboundDetail INSERT
        "INSERT INTO `InboundDetail` " +
            "(`inboundDetailCode`,`inboundCode`,`productCode`,`sectionCode`,`quantity`) " +
            "VALUES('TST-IN','TST-INB','CDC1','GG1-R',5)"
    }, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
    void testCategoryStatus_InboundProgress_WithSql() {
        String status = mapper.selectCategoryStatus("CDC");
        assertThat(status).isEqualTo("입고진행");
        log.info("CDC 상태: {}", status);
    }
    
    @Test
    @DisplayName("Category 상태 - 발주진행 (@Sql)")
    @Sql(statements = {
        // 재고·입고 기록 삭제
        "DELETE FROM Inventory     WHERE productCode IN (SELECT productCode FROM Product WHERE categoryCode = 'TZR')",
        "DELETE FROM InboundDetail WHERE productCode IN (SELECT productCode FROM Product WHERE categoryCode = 'TZR')",
        // TZR1 제품에 대해 발주 디테일만 삽입
        "INSERT INTO OrderDetail(orderDetailCode, orderCode, productCode, quantity) " +
            "VALUES('TST-OD','ORD1','TZR1',7)"
    }, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
    void testCategoryStatus_OrderProgress_WithSql() {
        String status = mapper.selectCategoryStatus("TZR");
        assertThat(status).isEqualTo("발주진행");
        log.info("TZR 상태: {}", status);
    }


// ----------------------
// Product 상태별 테스트
// ----------------------
    
    @Test
    @DisplayName("Product 상태 - 삭제가능")
    void testProductStatus_Deletable() {
        // PST는 어떤 테이블에도 없으므로
        String status = mapper.selectProductStatus("PST");
        assertThat(status).isEqualTo("삭제가능");
        log.info("PST 상태: {}", status);
    }
    
    @Test
    @DisplayName("Product 상태 - 재고있음")
    void testProductStatus_InStock() {
        // DPN1은 이미 Inventory에 레코드가 있으므로
        String status = mapper.selectProductStatus("DPN1");
        assertThat(status).isEqualTo("재고있음");
        log.info("DPN1 상태: {}", status);
    }
    
    @Test
    @DisplayName("Product 상태 - 입고진행 (@Sql, 헤더 + 디테일)")
    @Sql(statements = {
        // 1) Inbound 헤더 삽입 (외래키 제약을 만족시키기 위해)
        "INSERT INTO `Inbound` (inboundCode, inboundDate, warehouseCode, inboundStatus) " +
            "VALUES('IN11', CURDATE(), 'GG1', '승인대기')",
        // 2) InboundDetail 삽입
        "INSERT INTO `InboundDetail` " +
            "(`inboundDetailCode`,`inboundCode`,`productCode`,`sectionCode`,`quantity`) " +
            "VALUES('TST-IN','IN11','PST','GG1-R',12)"
    }, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
    void testProductStatus_InboundProgress_WithSql() {
        String status = mapper.selectProductStatus("PST");
        assertThat(status).isEqualTo("입고진행");
        log.info("PST 상태: {}", status);
    }
    
    @Test
    @DisplayName("Product 상태 - 발주진행 (@Sql)")
    @Sql(statements = {
        // 1) 테스트용 제품 삽입 (FK 제약을 위해)
        "INSERT INTO Product(productCode, productName, productPrice, categoryCode, storedType) " +
            "VALUES('PST','테스트제품',1000,'DPN','냉장')",
        // 2) 주문 헤더 삽입 (franchiseCode, orderStatus 포함)
        "INSERT INTO `Order` (orderCode, orderDate, franchiseCode, orderStatus) " +
            "VALUES('TST-ORD', CURDATE(), 'GGF1', '승인대기')",
        // 3) OrderDetail 삽입
        "INSERT INTO `OrderDetail` (orderDetailCode, orderCode, productCode, quantity) " +
            "VALUES('TST-OD','TST-ORD','PST',8)"
    }, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
    void testProductStatus_OrderProgress_WithSql() {
        String status = mapper.selectProductStatus("PST");
        assertThat(status).isEqualTo("발주진행");
        log.info("PST 상태: {}", status);
    }
}
