# Prokin Donuts Warehouse Management System

## 개요
Prokin Donuts WMS는 Prokin 도넛의 물류센터 운영을 위한 웹 기반 창고 관리 시스템입니다. Spring MVC 기반의 서버 사이드 렌더링으로 빠른 초기 화면 표시와, DataTables 및 AJAX를 활용한 비동기 데이터 처리를 통해 실시간 재고 관리 및 통계 기능을 제공합니다.

## 주요 기능
- **권한 기반 접근 관리**: 본사 관리자(QH), 창고 관리자(WM), 가맹점주(FM)
- **창고/가맹점 관리**: 창고 및 가맹점 등록/수정/삭제, 담당자 할당
- **섹션 관리**: 냉장·냉동·상온 섹션 설정 및 온도 조정
- **카테고리·제품 관리**: 중분류·소분류 드롭다운 연동, 제품 등록/수정/삭제
- **입고/출고 처리**: 입고 요청, 출고 요청, 재고 자동 증감
- **재고 현황 조회**: 실시간 재고 테이블, 검색·필터링·페이징
- **통계 대시보드**: 연간·월간·주간 입/출고 통계 차트
- **지도 연동**: Kakao Maps를 이용한 창고 위치 표시

## 기술 스택
- **Backend**: Java 11, Spring MVC, MyBatis, HikariCP, Lombok
- **Frontend**: JSP, Bootstrap 4, jQuery, DataTables, AJAX
- **Database**: MySQL 8
- **지도 API**: Kakao Maps API
- **주소 API**: 다음 주소 API
- **빌드 도구**: Gradle
- **서버**: Apache Tomcat 9

## 아키텍처
1. **Controller**: URL 매핑 및 요청 수신
2. **Service**: 비즈니스 로직 처리 및 트랜잭션 관리
3. **Mapper**: MyBatis XML 또는 어노테이션을 통한 SQL 매핑
4. **Domain/DTO/VO**: 데이터 전달 객체 정의
5. **View**: JSP 및 DataTables 기반 화면 렌더링

## 데이터베이스 설계
- Authority, MemberAccount, Franchise, Warehouse, Section, Category, Product, Inventory, Inbound, InboundDetail, Order, OrderDetail 테이블로 구성.
- 외래키 제약을 통해 데이터 무결성 보장.

## 설치 및 실행
1. **환경 설정**
   - JDK 11 이상 설치
   - MySQL 8 설치 및 `prokin_web_db` 스키마 생성
2. **DB 설정**
   - `src/main/webapp/root-context.xml`에서 DB 연결 정보 추가
3. **빌드 및 배포**
   ```bash
   ./gradlew clean build
   ```
   - 생성된 WAR 파일을 Tomcat `webapps` 폴더에 배포
4. **실행 확인**
   - `http://localhost:8080` 접속 후 로그인

## 기여 가이드
- 버그 리포트 및 개선 사항은 GitHub 이슈에 등록해 주세요.
- 풀 리퀘스트 전 `./gradlew test`로 모든 테스트가 성공하는지 확인 바랍니다.

## 제작자
- 박건희 (@psns0122)
- 고윤아 (@kya9505)
- 최문규 (@Cmk1031)

