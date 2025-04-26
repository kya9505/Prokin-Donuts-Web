<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="/resources/images/logo/favicon_logo.png" type="image/png" />
    <title>Prokin Donuts</title>

    <!-- ========== All CSS files linkup ========= -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/css/lineicons.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/resources/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/resources/css/fullcalendar.css" />
    <link rel="stylesheet" href="/resources/css/main.css" />
    <!-- datatable을 위해 필요함 -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
</head>

<body>
<!-- ======== Preloader =========== -->
<div id="preloader">
    <div class="spinner"></div>
</div>
<!-- ======== Preloader =========== -->

<!-- ======== sidebar-nav start =========== -->
<%@include file="/WEB-INF/views/includes/sidebar/qhSidebar.jsp"%>
<!-- ======== sidebar-nav end =========== -->

<!-- ======== main-wrapper start =========== -->
<main class="main-wrapper">

    <!-- ========== header start ========== -->
    <%@include file="/WEB-INF/views/includes/header/LoginMemberHeader.jsp"%>
    <!-- ========== header end ========== -->

    <!-- 마이페이지 모달 -->
    <%@ include file="/WEB-INF/views/includes/mypage/mypage.jsp" %>
    <!-- Modal HTML End -->

    <!-- ========== section start ========== -->
    <section class="section">
        <div class="container-fluid">
            <!-- ========== title-wrapper start ========== -->
            <div class="title-wrapper pt-30">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="title">
                            <h2>제품관리</h2>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ========== title-wrapper end ========== -->

            <!-- 위 : 카테고리 / 아래 : 제품 -->
            <!-- 카테고리 목록 테이블 시작 -->

            <div class="row">
                <!-- Start col -->
                <div class="col-lg-12">
                    <!-- Start card -->
                    <div class="card-style mb-30">
                        <h6 class="mb-10">카테고리 목록</h6>
                        <p class="text-sm mb-20"></p>

                        <!-- 원하는 필터(중분류, 소분류) 설정 -->
                        <div class="text-sm mb-20" id="myCustomFilters_mainCategoryUp" style="display: none;">

                            <div class="d-flex flex-wrap gap-2">

                                <!-- 중분류 -->
                                <div >
                                    <div class="select-style-1">
                                        <div class="select-position">
                                            <!-- 중분류 드롭다운 -->
                                            <select id="mainCategoryUp">
                                                <option value="">중분류</option>
                                                <c:forEach var="mid" items="${categoryMidList}">
                                                    <option value="${mid}">${mid}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- 필터 초기화 -->
                                <div class="mb-20">
                                    <button class="main-btn warning-btn-outline square-btn btn-hover btn-sm btn-xs" id="resetFilterBtn_mainCategoryUp" style="height:auto; min-height:auto;">
                                        필터 초기화
                                    </button>
                                </div>

                                <!-- 오른쪽: 등록/수정/삭제 -->
                                <div class="btu-group-1 ms-auto gap-2 mb-20">
                                    <button class="main-btn warning-btn-outline square-btn btn-hover btn-sm btn-xs" id="btnProductAdd_mainCategoryUp">카테고리 등록</button>
                                    <button class="main-btn warning-btn-outline square-btn btn-hover btn-sm btn-xs" id="btnProductDelete_mainCategoryUp">카테고리 삭제</button>
                                </div>
                            </div>

                        </div>

                        <div class="table-wrapper table-responsive p-0">

                            <!-- Start table -->
                            <table id="datatable_mainCategoryUp" class="table striped-table w-100" style="width:100%">

                                <!-- colgroup를 통해 열 폭을 강제 지정 -->
                                <colgroup>
                                    <col style="width: 5%;" />
                                    <col style="width: 25%;" />
                                    <col style="width: 25%" />
                                    <col style="width: 30%;" />
                                    <col style="width: 15%;" />
                                </colgroup>

                                <thead>
                                <tr>
                                    <th><input type="checkbox" id="select-all_mainCategoryUp"></th> <!-- 체크박스 열 -->
                                    <th>카테고리코드</th>
                                    <th>중분류명</th>
                                    <th>소분류명</th>
                                </tr>
                                </thead>

                                <tbody class="category-tbody">
                                <c:forEach var="item" items="${categoryList}">
                                    <tr
                                            data-category-code="${item.categoryCode}"
                                            data-category-mid="${item.categoryMid}"
                                            data-category-sub="${item.categorySub}"
                                            data-category-status="${item.categoryStatus}">
                                        <td><input type="checkbox" class="row-checkbox" /></td>
                                        <td>${item.categoryCode}</td>
                                        <td>${item.categoryMid}</td>
                                        <td>${item.categorySub}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!--  위 : 카테고리 / 아래 : 제품 -->
            <!-- 제품 목록 테이블 시작 -->

            <div class="row">
                <!-- Start col -->
                <div class="col-lg-12">
                    <!-- Start card -->
                    <div class="card-style mb-30">
                        <h6 class="mb-10">제품 목록</h6>
                        <p class="text-sm mb-20"></p>

                        <!-- 원하는 필터(중분류, 소분류) 설정 -->
                        <div id="myCustomFilters" style="display: none;">

                            <div class="d-flex flex-wrap gap-2">
                                <!-- 중분류 -->
                                <div >
                                    <div class="select-style-1">
                                        <div class="select-position">
                                            <!-- 중분류 드롭다운 -->
                                            <select id="midCategory" name="midCategory">
                                                <option value="">중분류</option>
                                                <c:forEach var="mid" items="${categoryMidList}">
                                                    <option value="${mid}">${mid}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- 소분류 -->
                                <div >
                                    <div class="select-style-1">
                                        <div class="select-position">
                                            <!-- 소분류 드롭다운 (초기엔 비워둠) -->
                                            <select id="subCategory" name="subCategory">
                                                <option value="">소분류</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- 필터 초기화 -->
                                <div class="mb-20">
                                    <button class="main-btn warning-btn-outline square-btn btn-hover btn-sm btn-xs" id="resetFilterBtn22" style="height:auto; min-height:auto;">
                                        필터 초기화
                                    </button>
                                </div>

                                <!-- 오른쪽: 등록/수정/삭제 -->
                                <div class="btu-group-1 ms-auto gap-2 mb-20">
                                    <button class="main-btn warning-btn-outline square-btn btn-hover btn-sm btn-xs" id="btnProductAdd">제품 등록</button>
                                    <button class="main-btn warning-btn-outline square-btn btn-hover btn-sm btn-xs" id="btnProductEdit">제품 수정</button>
                                    <button class="main-btn warning-btn-outline square-btn btn-hover btn-sm btn-xs" id="btnProductDelete">제품 삭제</button>
                                </div>
                            </div>

                        </div>

                        <div class="table-wrapper table-responsive p-0">
                            <!-- Start table -->
                            <table id="datatable" class="table striped-table w-100" style="width:100%">

                                <!-- colgroup를 통해 열 폭을 강제 지정 -->
                                <colgroup>
                                    <col style="width: 5%;" />
                                    <col style="width: 10%;" />
                                    <col style="width: 10%;" />
                                    <col style="width: 15%;" />
                                    <col style="width: 10%;" />
                                    <col style="width: 20%;" />
                                    <col style="width: 15%;" />
                                </colgroup>

                                <thead>
                                <tr>
                                    <th><input type="checkbox" id="select-all"></th> <!-- 체크박스 열 -->
                                    <th>제품코드</th>
                                    <th>중분류</th>
                                    <th>소분류</th>
                                    <th>보관타입</th>
                                    <th>제품명</th>
                                    <th>제공단가</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="item" items="${productList}">
                                    <tr
                                            data-product-code="${item.productCode}"
                                            data-product-mid="${item.categoryMid}"
                                            data-product-sub="${item.categorySub}"
                                            data-product-type="${item.storedType}"
                                            data-product-name="${item.productName}"
                                            data-product-price="${item.productPrice}"
                                            data-product-status="${item.productStatus}">
                                        <td><input type="checkbox" class="row-checkbox"></td>
                                        <td>${item.productCode}</td>
                                        <td>${item.categoryMid}</td>
                                        <td>${item.categorySub}</td>
                                        <td>${item.storedType}</td>
                                        <td>${item.productName}</td>
                                        <td><fmt:formatNumber value="${item.productPrice}" type="number" groupingUsed="true"/> 원</td>
                                    </tr>
                                </c:forEach>
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </section>
    <!-- ========== section end ========== -->

    <!-- ========== footer start =========== -->
    <footer class="footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="terms d-flex justify-content-center justify-content-md-end">
                        <a href="https://small-ragdoll-a57.notion.site/Prokin-Donuts-1b83a719d3508047953eeda89caeec14" class="text-sm">Brand Story</a>
                        <a href="https://github.com/Prokin-Donuts/Prokin-Donuts" class="text-sm ml-15">Dev Hub</a>
                    </div>
                </div>
                <!-- end col-->
            </div>
            <!-- end row -->
        </div>
        <!-- end container -->
    </footer>
    <!-- ========== footer end =========== -->
</main>
<!-- ======== main-wrapper end =========== -->

<!-- 모달 시작 -->

<!-- 카테고리 등록 모달 -->
<div class="modal fade" id="categoryAddModal" tabindex="-1" aria-labelledby="categoryAddModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- 모달 헤더 -->
            <div class="modal-header">
                <h3 class="modal-title" id="categoryAddModalLabel">카테고리 등록</h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- 모달 바디 -->
            <div class="modal-body">
                <p class="text-danger fw-normal mb-3">(*)는 필수 입력 항목입니다.</p>

                <form id="registerCategoryForm" action="${pageContext.request.contextPath}/qh/product/category/add" method="post">

                    <!-- 카테고리 코드 -->
                    <div class="mb-3">
                        <label for="registerCategoryCode" class="form-label">
                            카테고리코드 (*)
                            <i
                                    class="mdi mdi-help-circle text-primary"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="right"
                                    data-bs-html="true"
                                    data-bs-custom-class="wide-tooltip"
                                    title="중분류(1자) + 소분류(2자) = <b>총 3자리 대문자 코드</b><br>예: 도넛(D) + 로우슈거(LS) → DLS<br><i>※ 중복 시 소분류 약어를 조정해 주세요.</i>"
                                    style="cursor: pointer;">
                            </i>
                        </label>
                        <input
                                type="text"
                                class="form-control"
                                id="registerCategoryCode"
                                name="categoryCode"
                                placeholder="예: DPN"
                                maxlength="3"
                        />
                    </div>

                    <!-- 중분류명 -->
                    <div class="mb-3">
                        <label for="registerCategoryMid_subCategoryUp" class="form-label">
                            중분류명 (*)
                        </label>
                        <input
                                type="text"
                                class="form-control"
                                id="registerCategoryMid_subCategoryUp"
                                name="categoryMid"
                                placeholder="예: 도넛"
                                maxlength="10"
                        />
                    </div>

                    <!-- 소분류명 -->
                    <div class="mb-3">
                        <label for="registerCategorySub_subCategoryUp" class="form-label">
                            소분류명 (*)
                        </label>
                        <input
                                type="text"
                                class="form-control"
                                id="registerCategorySub_subCategoryUp"
                                name="categorySub"
                                placeholder="예: 글루텐 프리 도넛"
                                maxlength="20"
                        />
                    </div>

                    <!-- 중복 체크 & 등록 버튼 -->
                    <div class="d-flex justify-content-between">
                        <button
                                type="button"
                                class="main-btn warning-btn-outline btn-hover btn-sm"
                                id="checkCategoryDuplicate">
                            중복 체크
                        </button>
                        <button
                                type="submit"
                                class="main-btn primary-btn btn-hover btn-sm"
                                id="registerCategorySubBtn">
                            등록
                        </button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<!-- 카테고리 삭제 모달 -->
<div class="modal fade" id="productDeleteModal_mainCategoryUp" tabindex="-1" aria-labelledby="productDeleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- 모달 헤더 -->
            <div class="modal-header">
                <h3 class="modal-title" id="productDeleteModalLabel_mainCategoryUp">카테고리 삭제</h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- 모달 바디 -->
            <div class="modal-body">
                <form id="warehouseDeleteForm" action="${pageContext.request.contextPath}/qh/product/category/delete" method="post">
                    <h5>선택한 카테고리를 정말 삭제하시겠습니까?</h5><br>
                    <ul id="deleteProductList_mainCategoryUp" class="list-group mb-3">
                        <!-- 선택된 제품명 목록 삽입 -->
                    </ul>
                    <div class="d-flex justify-content-end gap-2">
                        <button type="submit" class="main-btn primary-btn btn-hover text-center" id="confirmDelete_mainCategoryUp">삭제</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 제품 등록 모달 -->
<div class="modal fade" id="productAddModal" tabindex="-1" aria-labelledby="productAddModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- 모달 헤더 -->
            <div class="modal-header">
                <h5 class="modal-title" id="productAddModalLabel">제품 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- 모달 바디 -->
            <div class="modal-body">
                <p class="text-danger fw-normal mb-3">(*)는 필수 입력 항목입니다.</p>
                <form id="registerProductForm" action="${pageContext.request.contextPath}/qh/product/add" method="post">
                    <!-- 1. 중분류 드롭박스 -->
                    <div class="mb-3">
                        <label for="registerCategoryMid" class="form-label">중분류 (*)</label>

                        <select class="form-select" id="registerCategoryMid" name="categoryMid" required>
                            <option value="">중분류</option>
                            <c:forEach var="mid" items="${categoryMidList}">
                                <option value="${mid}">${mid}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- 2. 소분류 드롭박스 -->
                    <div class="mb-3">
                        <label for="registerCategorySub" class="form-label">소분류 (*)</label>
                        <select class="form-select" id="registerCategorySub" name="categorySub" disabled>
                            <option value="">소분류 선택</option>
                            <!-- JavaScript에서 동적으로 옵션 추가 -->
                        </select>
                    </div>

                    <!-- 3. 제품명 입력 + 중복 확인 버튼 -->
                    <div class="mb-3">
                        <label for="registerProductName" class="form-label">제품명 (*)
                            <i
                                    class="mdi mdi-help-circle text-primary"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="right"
                                    data-bs-html="true"
                                    data-bs-custom-class="wide-tooltip"
                                    title="냉동 보관 제품의 경우,<br>제품명 앞에 보관타입을 명시해 주세요.<br>예: 냉동초코프로틴도넛"
                                    style="cursor: pointer;">
                            </i></label>
                        <div class="d-flex gap-2">
                            <input type="text" class="form-control" id="registerProductName" name="productName" placeholder="예: 프로틴초코" maxlength="10" required>

                            <button type="button" class="main-btn primary-btn btn-hover btn-smaller" id="checkProductNameDuplicate">중복 확인</button>
                        </div>
                    </div>

                    <!-- 4. 제공단가 입력 + 단위 표시 -->
                    <div class="mb-3">
                        <label for="registerProductPrice" class="form-label">제공단가 (*)</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="registerProductPrice" name="productPrice" placeholder="예: 5000" required>
                            <span class="input-group-text">원</span>
                        </div>
                    </div>

                    <!-- 5. 보관타입 드롭박스 -->
                    <div class="mb-3">
                        <label for="registerStoredType" class="form-label">보관타입 (*)</label>
                        <select class="form-select" name="storedType" id="registerStoredType" required>
                            <option value="">선택하세요</option>
                            <option value="냉장">냉장</option>
                            <option value="냉동">냉동</option>
                            <option value="상온">상온</option>
                        </select>
                    </div>

                    <!-- 제출 버튼 -->
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="main-btn primary-btn btn-hover text-center"
                                id="btnProductRegisterSubmit">등록</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<!-- 제품 수정 모달 -->
<div class="modal fade" id="productEditModal" tabindex="-1" aria-labelledby="productEditModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">제품 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <p class="text-danger mb-2">(*)는 필수 입력 항목입니다.</p>
                <form id="productEditForm" action="${pageContext.request.contextPath}/qh/product/update" method="post">
                    <div id="editProductContainer">
                    <table class="table text-center align-middle" id="editProductTable">
                        <thead>
                        <tr>
                            <th style="width: 20px;">#</th>
                            <th>제품코드</th>
                            <th>중분류 (*)</th>
                            <th>소분류 (*)</th>
                            <th>제품명 (*)
                                <i
                                        class="mdi mdi-help-circle text-primary wide-tooltip tooltip-inner"
                                        data-bs-toggle="tooltip"
                                        data-bs-placement="right"
                                        data-bs-html="true"
                                        title="냉동 보관 제품의 경우,<br>제품명 앞에 보관타입을<br>명시해 주세요.<br>예: 냉동초코프로틴도넛"
                                        style="cursor: pointer; margin-left: 5px;">
                                </i>
                            </th>
                            <th>제공단가 (*)</th>
                            <th>보관타입 (*)</th>
                            <th>중복확인</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 체크한 값을 여기로 뿌릴 예정 (JS) -->
                        </tbody>
                    </table>
                    </div>

                    <div class="d-flex justify-content-end">
                        <button type="submit" class="main-btn primary-btn btn-hover text-center" id="btnProductEditSubmit">수정</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<!-- 제품 삭제 모달 -->
<div class="modal fade" id="productDeleteModal" tabindex="-1" aria-labelledby="productDeleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h3 class="modal-title" id="productDeleteModalLabel">제품 삭제</h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <!-- 안내 메시지 -->
                <h5>선택한 제품을 정말 삭제하시겠습니까?</h5><br>

                <form id="productDeleteForm" action="${pageContext.request.contextPath}/qh/product/delete" method="post">
                    <!-- 선택된 제품 목록 (상태 배지는 모두 회색 bg-secondary로 표시) -->
                    <ul id="deleteProductList" class="list-group mb-3">
                        <!-- 동적으로 목록 항목이 추가됩니다 -->
                    </ul>
                    <!-- 삭제 확인 버튼 (취소 버튼은 없음) -->
                    <div class="d-flex justify-content-end">
                        <button type="button" class="main-btn primary-btn btn-hover text-center" id="btnProductDeletSubmit">삭제</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<!-- 모달 끝 -->

<!-- ========= All Javascript files linkup ======== -->
<script src="/resources/js/Chart.min.js"></script>
<script src="/resources/js/dynamic-pie-chart.js"></script>
<script src="/resources/js/moment.min.js"></script>
<script src="/resources/js/fullcalendar.js"></script>
<script src="/resources/js/jvectormap.min.js"></script>
<script src="/resources/js/world-merc.js"></script>
<script src="/resources/js/polyfill.js"></script>
<script src="/resources/js/main.js"></script>
<!-- datatable을 위해 필요함 -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="/resources/js/bootstrap.bundle.min.js"></script>

<script>
    // Bootstrap 5 Tooltip 활성화 (모달 내부)
    document.addEventListener('DOMContentLoaded', function () {
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
</script>

<!-- 카테고리 설정 시작 -->
<script>
    $(document).ready(function() {
        // DataTable 초기화 시 dom 옵션에서 필터 영역을 위한 container를 별도로 지정
        var categoryTable = $('#datatable_mainCategoryUp').DataTable({
            autoWidth: false,
            order: [[1, 'asc']],
            columnDefs: [
                { width: '95px', targets: -1 },
                { targets: [1, 2, 3], className: 'text-center' },
                { targets: [0], orderable: false }
            ],
            paging: true,
            pageLength: 5,
            lengthMenu: [[5, 10, 20, -1], ['5개', '10개', '20개', '전체']],
            searching: true,
            ordering: true,
            info: true,
            lengthChange: true,
            // dom 옵션에서 필터 영역을 위한 container 추가 (고유 클래스 사용)
            dom: '<"top"l<"myCustomFilters_mainCategoryUp_area">fr>t<"bottom"ip>',
            language: {
                lengthMenu: '_MENU_',
                search: "검색 ",
                info: "Showing _START_ to _END_ of _TOTAL_ entries",
                infoEmpty: "no data",
                emptyTable: "empty table",
                paginate: {
                    previous: "< prev",
                    next: "next >"
                }
            },
            initComplete: function(settings, json) {
                // 헤더 체크박스 정렬 아이콘 제거
                $('#datatable_mainCategoryUp thead th').eq(4).removeClass('sorting sorting_asc sorting_desc');
                fixLengthDropdownStyle_category();
                const api = this.api();

                setTimeout(() => {
                    api.draw(false);
                }, 0);

                // 필터 이벤트는 복제한 요소에 바인딩
                // (이벤트는 아래 부분에서 복제한 후 다시 바인딩할 예정)
            },
            drawCallback: function(settings) {
                $('#datatable_mainCategoryUp thead th').eq(4).removeClass('sorting sorting_asc sorting_desc');
            }
        });

        ///////////////////////////////////////////////////////

        // 전체 선택 체크박스 클릭 시 (현재 페이지 기준)
        $(document).off('change', '#select-all_mainCategoryUp').on('change', '#select-all_mainCategoryUp', function (e) {
            e.preventDefault();      // 🔒 기본 동작 방지
            e.stopPropagation();     // 🔒 이벤트 버블링 방지

            const isChecked = $(this).prop('checked');
            console.log('[전체선택] 상태:', isChecked);

            const rows = categoryTable.rows({ page: 'current' }).nodes();
            $('input.row-checkbox', rows).prop('checked', isChecked);
        });

        // 개별 체크 해제 시 전체 선택 해제
        $('#datatable_mainCategoryUp tbody').off('change', 'input.row-checkbox').on('change', 'input.row-checkbox', function () {
            const $selectAll = $('#select-all_mainCategoryUp');
            const rows = categoryTable.rows({ page: 'current' }).nodes();
            const total = $('input.row-checkbox', rows).length;
            const checked = $('input.row-checkbox:checked', rows).length;

            $selectAll.prop('checked', total > 0 && total === checked);
        });

        // 페이지 이동 시 전체선택 체크박스 초기화
        categoryTable.on('draw.dt', function () {
            // 1. 전체선택 체크박스 해제
            $('#select-all_mainCategoryUp').prop('checked', false);

            // 2. 현재 페이지의 체크박스 모두 해제
            const rows = categoryTable.rows({ page: 'current' }).nodes();
            $('input.row-checkbox', rows).prop('checked', false);
        });

        ///////////////////////////////////////////////////////

        // 필터 영역 복제 및 재설정
        var $origFilter = $('#myCustomFilters_mainCategoryUp'); // 원본: display:none
        var $cloneFilter = $origFilter.clone(true);

        // 보이도록 display 제거
        $cloneFilter.css("display", "block");

        // 복제한 필터 내에서 ID 변경 (중분류 드롭다운, 버튼 등)
        $cloneFilter.find('#mainCategoryUp').attr('id', 'mainCategoryUp_clone');
        $cloneFilter.find('#resetFilterBtn_mainCategoryUp').attr('id', 'resetFilterBtn_mainCategoryUp_clone');
        $cloneFilter.find('#btnProductAdd_mainCategoryUp').attr('id', 'btnProductAdd_mainCategoryUp_clone');
        $cloneFilter.find('#btnProductDelete_mainCategoryUp').attr('id', 'btnProductDelete_mainCategoryUp_clone');

        // 삽입할 container가 dom 옵션에 지정되었으므로,
        // 해당 container가 document에 없다면 동적으로 생성
        if ($('.myCustomFilters_mainCategoryUp_area').length == 0) {
            $('<div class="myCustomFilters_mainCategoryUp_area"></div>').insertBefore('#datatable_mainCategoryUp');
        }
        $('.myCustomFilters_mainCategoryUp_area').html($cloneFilter.html());

        // 카테고리 테이블: 중분류 정확 일치 필터
        $.fn.dataTable.ext.search.push(function(settings, data) {
            if (settings.nTable.id !== 'datatable_mainCategoryUp') return true;
            const selectedMid = $('#mainCategoryUp_clone').val().trim();
            const rowMid = (data[2] || '').trim(); // 중분류 컬럼은 인덱스 2

            if (selectedMid && rowMid !== selectedMid) return false;
            return true;
        });

        // 필터 이벤트 바인딩 (복제된 요소 기준)
        $('#mainCategoryUp_clone').on('change', function() {
            categoryTable.draw();
        });

        $('#resetFilterBtn_mainCategoryUp_clone').on('click', function() {
            $('#mainCategoryUp_clone').val('');
            categoryTable.column(2).search('').draw();
        });

        categoryTable.on('draw', function () {
            $('#datatable_mainCategoryUp_wrapper .dataTables_paginate .paginate_button').removeClass().addClass('main-btn deactive-btn-outline square-btn btn-hover mt-1 pt-2 pb-2 pl-15 pr-15');
        });

        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        // 카테고리 등록

        $(function() {
            // 컨텍스트 경로
            var contextPath = '${pageContext.request.contextPath}';

            // 중복 체크 플래그
            var isCategoryDuplicateChecked = false;

            // 1) 중복 체크 버튼 클릭
            $('#checkCategoryDuplicate').on('click', function() {
                var code = $('#registerCategoryCode').val().trim();
                var mid  = $('#registerCategoryMid_subCategoryUp').val().trim();
                var sub  = $('#registerCategorySub_subCategoryUp').val().trim();

                // 빈값 검사
                if (!code || !mid || !sub) {
                    alert('모든 항목을 입력해주세요.');
                    return;
                }
                // 형식 검사
                var regCode   = /^[A-Z]{3}$/;
                var regMidSub = /^[A-Za-z0-9가-힣 ]{1,20}$/;
                if (!regCode.test(code)) {
                    alert('카테고리 코드는 알파벳 대문자 3자리여야 합니다.');
                    return;
                }
                if (!regMidSub.test(mid)) {
                    alert('중분류명은 한글, 영문, 숫자, 공백 포함 최대 20자입니다.');
                    return;
                }
                if (!regMidSub.test(sub)) {
                    alert('소분류명은 한글, 영문, 숫자, 공백 포함 최대 20자입니다.');
                    return;
                }

                // 실제 중복 확인 API 호출 ('' + 로 연결)
                fetch(contextPath
                    + '/qh/product/category/check'
                    + '?categoryCode=' + encodeURIComponent(code)
                    + '&middleName='   + encodeURIComponent(mid)
                    + '&smallName='    + encodeURIComponent(sub))
                    .then(function(res) { return res.text(); })
                    .then(function(result) {
                        if (result === 'true') {
                            alert('이미 존재하는 카테고리입니다.');
                            isCategoryDuplicateChecked = false;
                        } else {
                            alert('사용 가능한 카테고리입니다.');
                            isCategoryDuplicateChecked = true;
                        }
                    })
                    .catch(function() {
                        alert('중복 확인에 실패했습니다. 네트워크를 확인하세요.');
                        isCategoryDuplicateChecked = false;
                    });
            });

            // 2) 입력값 변경 시 플래그 리셋
            $('#registerCategoryCode, #registerCategoryMid_subCategoryUp, #registerCategorySub_subCategoryUp')
                .on('input', function() { isCategoryDuplicateChecked = false; });

            // 3) 모달 열기 버튼
            $('body').on('click', '#btnProductAdd_mainCategoryUp_clone', function() {
                $('#categoryAddModal').modal('show');
            });

            // 4) 폼 제출 시 유효성 및 중복 체크 확인
            $('#registerCategoryForm').on('submit', function() {
                var code = $('#registerCategoryCode').val().trim();
                var mid  = $('#registerCategoryMid_subCategoryUp').val().trim();
                var sub  = $('#registerCategorySub_subCategoryUp').val().trim();

                if (!code || !mid || !sub) {
                    alert('모든 항목을 입력해주세요.');
                    return false;  // 전송 막기
                }
                if (!isCategoryDuplicateChecked) {
                    alert('중복 체크를 먼저 진행해주세요.');
                    return false;  // 전송 막기
                }
                // 통과 시 true 반환 → form action으로 POST
                return true;
            });

            $('#categoryAddModal').on('shown.bs.modal', function () {
                $('#registerCategoryCode').val('');
                $('#registerCategoryMid_subCategoryUp').val('');
                $('#registerCategorySub_subCategoryUp').val('');
                isCategoryDuplicateChecked = false;
            });

        });

        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////

        $(function () {
            var deleteCandidates = [];

            // 카테고리 삭제 버튼 클릭 시
            $('body').on('click', '#btnProductDelete_mainCategoryUp_clone', function () {
                deleteCandidates = [];
                const $deleteList = $('#deleteProductList_mainCategoryUp').empty();

                categoryTable.rows({ page: 'current' }).nodes().each(function (row) {
                    var $tr = $(row);
                    if ($tr.find('.row-checkbox').prop('checked')) {
                        deleteCandidates.push({
                            code: $tr.data('category-code'),
                            mid: $tr.data('category-mid'),
                            sub: $tr.data('category-sub'),
                            status: $tr.data('category-status') || ''
                        });
                    }
                });

                if (!deleteCandidates.length) {
                    alert('삭제할 항목을 선택하세요.');
                    return;
                }

                let allDeletable = true;
                deleteCandidates.forEach(function (item) {
                    const canDelete = item.status.trim() === '삭제가능';
                    if (!canDelete) allDeletable = false;

                    const badgeClass = canDelete ? 'bg-success' : 'bg-danger';
                    const badge = '<span class="badge ' + badgeClass + '">' + item.status + '</span>';

                    $deleteList.append(
                        '<li class="list-group-item d-flex justify-content-between align-items-center">'
                        + item.mid + ' - ' + item.sub + badge +
                        '</li>'
                    );
                });

                // 안내문 및 버튼 텍스트 설정
                $('#productDeleteModal_mainCategoryUp .modal-body h5').text(
                    allDeletable
                        ? '선택한 카테고리를 정말 삭제하시겠습니까?'
                        : '선택한 카테고리 중 삭제할 수 없는 항목이 포함되어 있습니다.'
                );
                $('#confirmDelete_mainCategoryUp').text(allDeletable ? '삭제' : '삭제가능 품목만 삭제');

                $('#productDeleteModal_mainCategoryUp').modal('show');
            });

            // 삭제 확인 버튼 클릭 시
            $('#confirmDelete_mainCategoryUp').on('click', function () {
                const btnText = $(this).text();
                const toDelete = [];

                deleteCandidates.forEach(function (item) {
                    const canDelete = item.status.trim() === '삭제가능';
                    if (btnText === '삭제' || (btnText === '삭제가능 품목만 삭제' && canDelete)) {
                        toDelete.push(item.code);
                    }
                });

                if (!toDelete.length) {
                    alert('삭제할 수 있는 항목이 없습니다.');
                    document.activeElement.blur(); // 포커스 제거
                    $('#productDeleteModal_mainCategoryUp').modal('hide');
                    return false;
                }

                const $form = $('#warehouseDeleteForm').empty();
                toDelete.forEach(function (code) {
                    $form.append('<input type="hidden" name="categoryCodes" value="' + code + '"/>');
                });

                $form.submit();
            });

            // 깜빡임 방지: 모달 닫힐 때 상태 정리
            $('#productDeleteModal_mainCategoryUp').on('hidden.bs.modal', function () {
                document.activeElement.blur();
                setTimeout(function () {
                    const $modal = $('#productDeleteModal_mainCategoryUp');
                    $modal.removeClass('show').css('display', 'none').attr('aria-hidden', 'true');
                    $('body').removeClass('modal-open');
                    $('.modal-backdrop').remove();
                }, 300);
            });
        });

        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////

        // DataTable length dropdown custom 스타일 함수 (카테고리용)
        function fixLengthDropdownStyle_category() {
            const $length = $('#datatable_mainCategoryUp_wrapper .dataTables_length');
            const $select = $length.find('select');
            const selectedValue = $select.val();
            const $filter = $('#datatable_mainCategoryUp_wrapper .dataTables_filter');
            const $input = $filter.find('input');

            // 기존 label 텍스트 제거
            $length.find('label').contents().filter(function () {
                return this.nodeType == 3;
            }).remove();

            const $newWrapper = $(`
            <div class="select-style-1">
              <div class="select-position"></div>
            </div>
          `);
            const $newInput = $('<div class="input-style-1"></div>');

            $select.detach();
            $newWrapper.find('.select-position').append($select);
            $length.empty().append($newWrapper);

            $input.detach();
            $input.attr('placeholder', 'Search...');
            $newInput.append($input);
            $filter.empty().append($newInput);

            $select.val(selectedValue);
        }
    });

</script>

<!-- 위 : 카테고리 / 아래 : 제품 -->

<script>
    $(document).ready(function() {

        // 4. 이벤트 바인딩: 중분류 선택 시 소분류 리셋, 소분류 선택 시 자동 중분류 선택
        $('#myCustomFilters #midCategory').on('change', function() {
            $('#myCustomFilters #subCategory').val('');

            var selectedSub = $(this).val();
            if (selectedSub) {
                var correspondingMid = mapping[selectedSub];
                if (correspondingMid) {
                    $('#myCustomFilters #midCategory').val(correspondingMid);
                }
            }
        });

        // 5. DataTable 초기화 (dom 옵션에 사용자 정의 영역 포함)
        /** @type {DataTables.Api} */
        var table = $('#datatable').DataTable({
            autoWidth: false,
            order: [[1, 'asc']],
            columnDefs: [
                { width: '95px', targets: -1 },  // Actions 열 너비
                { targets: [1, 2, 3, 4, 5, 6], className: 'text-center' }, // JS 속성으로 가운데 정렬
                { targets: [0], orderable: false }
            ],
            paging: true,
            pageLength: 10,
            lengthMenu: [[5, 10, 20, -1], ['5개', '10개', '20개', '전체']],
            searching: true,
            ordering: true,
            info: true,
            lengthChange: true,
            dom: '<"top"l<"myFilterArea">fr>t<"bottom"ip>',
            language: {
                lengthMenu: '_MENU_',
                search: "검색 ",
                info: "Showing _START_ to _END_ of _TOTAL_ entries",
                infoEmpty: "no data",
                emptyTable: "empty table",
                paginate: {
                    previous: "< prev",
                    next: "next >"
                }
            },
            // 초기에 체크박스에서 정렬 화살표 지우기
            initComplete: function(settings, json) {
                fixLengthDropdownStyle();
                const api = this.api();

                setTimeout(() => {
                    api.draw(false);
                }, 0);
                // 이후 중분류, 소분류 이벤트도 이 영역 내의 요소에 바인딩
            },
            // 새로고침 후 체크박스에서 정렬 화살표 지우기 (유지)
            drawCallback: function(settings) {
            }
        });

        ///////////////////////////////////////////////////////

        // ✅ 전체 선택 체크박스 클릭 시 (현재 페이지 기준)
        $(document).off('change', '#select-all').on('change', '#select-all', function (e) {
            e.preventDefault();
            e.stopPropagation();

            const isChecked = $(this).prop('checked');
            console.log('[제품 전체선택] 상태:', isChecked);

            const rows = table.rows({ page: 'current' }).nodes();
            $('input.row-checkbox', rows).prop('checked', isChecked);
        });

        // ✅ 개별 체크 해제 시 전체 선택 해제
        $('#datatable_product tbody').off('change', 'input.row-checkbox').on('change', 'input.row-checkbox', function () {
            const $selectAll = $('#select-all');
            const rows = table.rows({ page: 'current' }).nodes();
            const total = $('input.row-checkbox', rows).length;
            const checked = $('input.row-checkbox:checked', rows).length;

            $selectAll.prop('checked', total > 0 && total === checked);
        });

        // ✅ 페이지 이동 시 전체선택 체크박스 초기화
        table.on('draw.dt', function () {
            $('#select-all').prop('checked', false);

            const rows = table.rows({ page: 'current' }).nodes();
            $('input.row-checkbox', rows).prop('checked', false);
        });

        ///////////////////////////////////////////////////////

        // ① 전역 필터 함수: 중분류/소분류 필터링
        $.fn.dataTable.ext.search.push(function(settings, data) {
            if (settings.nTable.id !== 'datatable') return true;
            const m = $('#midCategory_clone').val().trim();
            const s = $('#subCategory_clone').val().trim();
            const rowMid = (data[2] || '').trim();
            const rowSub = (data[3] || '').trim();
            if (m && rowMid  !== m) return false;
            if (s && rowSub  !== s) return false;
            return true;
        });

        function fixLengthDropdownStyle() {
            const $length = $('#datatable_wrapper .dataTables_length');
            const $select = $length.find('select');
            const selectedValue = $select.val();

            const $filter = $('#datatable_filter')
            const $input = $filter.find('input');

            // 기존 label 텍스트 제거 (ex. "표시 개수")
            $length.find('label').contents().filter(function () {
                return this.nodeType == 3; // 텍스트 노드
            }).remove();

            // 새 구조로 재조립
            const $newWrapper = $(`
            <div class="select-style-1">
              <div class="select-position"></div>
            </div>
          `);

            const $newInput = $(`
            <div class="input-style-1">
            </div>
          `);

            $select.detach();
            $newWrapper.find('.select-position').append($select);
            $length.empty().append($newWrapper);

            $input.detach();
            $input.attr('placeholder', 'Search...');
            $newInput.append($input);
            $filter.empty().append($newInput);

            $select.val(selectedValue);
        }

        table.on('draw', function () {
            $('#datatable_wrapper .dataTables_paginate .paginate_button').removeClass().addClass('main-btn deactive-btn-outline square-btn btn-hover mt-1 pt-2 pb-2 pl-15 pr-15');
        });

        // 원본 <div id="myCustomFilters"> 를 복제해서 datatable dom에 붙이고
        var $clone = $('#myCustomFilters').clone(true);
        $clone.find('#midCategory').attr('id','midCategory_clone');
        $clone.find('#subCategory').attr('id','subCategory_clone');

        // 불필요한 버튼 아이디도 바꿔 주고…
        $clone.find('#resetFilterBtn22').attr('id', 'resetFilterBtn22_clone');
        $clone.find('#btnProductAdd').attr('id', 'btnProductAdd_clone');
        $clone.find('#btnProductEdit').attr('id', 'btnProductEdit_clone');
        $clone.find('#btnProductDelete').attr('id', 'btnProductDelete_clone');
        $clone.find('#btnProductAdd, #btnProductEdit, #btnProductDelete').remove();
        $('div.myFilterArea').html($clone.html());

        // 2) Reset 버튼 클릭 시
        $(document).on('click', '#resetFilterBtn22_clone', function() {
            // 중분류 클리어
            $('#midCategory_clone').val('');
            // 소분류 옵션 완전 초기화 + 비활성화
            $('#subCategory_clone')
                .empty()
                .append('<option value="">소분류</option>')
                .prop('disabled', true);
            // 필터 검색어 제거 후 redraw
            table
                .column(2).search('')
                .column(3).search('')
                .draw();
        });

        // 3) 소분류 선택 시
        $(document).on('change', '#subCategory_clone', function() {
            table.column(3).search(this.value).draw();
        });

        // 중분류 선택 시 소분류 초기화 & 필터링 적용
        $(document).on('change', '#midCategory_clone', function() {
            const midVal = $(this).val().trim();

            // 1) DataTable에 미리 등록된 전역 필터(중분류/소분류) 적용
            $('#datatable').DataTable().draw();

            // 2) 소분류 드롭다운 초기화
            const $sub = $('#subCategory_clone')
                .empty()
                .append('<option value="">소분류 선택</option>');

            // 3) 중분류가 비어 있으면 소분류 비활성화 후 종료
            if (!midVal) {
                $sub.prop('disabled', true);
                return;
            }

            // 4) 중분류가 선택되었으면 AJAX로 소분류 불러와 활성화
            fetch('${pageContext.request.contextPath}/category/check?categoryMid=' + encodeURIComponent(midVal))
                .then(res => res.json())
                .then(subList => {
                    subList.forEach(sub => $sub.append(new Option(sub, sub)));
                    $sub.prop('disabled', false);
                });
        });

        // select 태그 감싸는 구조 적용
        $('.dataTables_length select').each(function() {
            const $select = $(this);
            if (!$select.parent().hasClass('select-position')) {
                $select.wrap('<div class="col-lg-2"><div class="select-style-1"><div class="select-position"></div></div></div>');
            }
        });

        ////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////

        $(function () {
            const ctx = '${pageContext.request.contextPath}';
            let isProductNameDuplicateChecked = false;

            // 🔄 등록 모달 열릴 때 초기화
            $('#productAddModal').on('shown.bs.modal', function () {
                $('#registerCategoryMid').val('');
                $('#registerCategorySub')
                    .empty()
                    .append('<option value="">소분류 선택</option>')
                    .prop('disabled', true);
                $('#registerProductName').val('');
                $('#registerProductPrice').val('');
                $('#registerStoredType').val('');
                isProductNameDuplicateChecked = false;
            });

            // 🔀 중분류 선택 시 소분류 비동기로 가져오기
            $(document).on('change', '#registerCategoryMid', function () {
                const selectedMid = $(this).val();
                const $sub = $('#registerCategorySub');

                $sub.empty().append('<option value="">소분류 선택</option>');

                if (!selectedMid) {
                    $sub.prop('disabled', true);
                    return;
                }

                fetch(ctx + '/category/check?categoryMid=' + encodeURIComponent(selectedMid))
                    .then(res => res.json())
                    .then(subList => {
                        subList.forEach(sub => {
                            $sub.append(new Option(sub, sub));
                        });
                        $sub.prop('disabled', false);
                    })
                    .catch(() => {
                        console.warn("소분류 로드 실패");
                        $sub.prop('disabled', true);
                    });
            });

            // ✅ 중복확인 버튼
            $('#checkProductNameDuplicate').on('click', function () {
                const mid = $('#registerCategoryMid').val().trim();
                const sub = $('#registerCategorySub').val().trim();
                const name = $('#registerProductName').val().trim();

                if (!mid || !sub || !name) {
                    alert("중분류, 소분류, 제품명을 모두 입력해주세요.");
                    return;
                }

                const nameRegex = /^[A-Za-z가-힣]{1,10}$/;
                if (!nameRegex.test(name)) {
                    alert("제품명은 한글/영문 10자 이하만 가능합니다.");
                    return;
                }

                fetch(ctx + '/qh/product/check'
                    + '?categoryMid=' + encodeURIComponent(mid)
                    + '&categorySub=' + encodeURIComponent(sub)
                    + '&productName=' + encodeURIComponent(name))
                    .then(res => res.text())
                    .then(result => {
                        if (result === 'true') {
                            alert("이미 등록된 제품입니다.");
                            isProductNameDuplicateChecked = false;
                        } else {
                            alert("사용 가능한 제품명입니다.");
                            isProductNameDuplicateChecked = true;
                        }
                    })
                    .catch(() => {
                        alert("중복 확인에 실패했습니다.");
                        isProductNameDuplicateChecked = false;
                    });
            });

            // ✅ 등록 버튼 클릭 시 전체 유효성 검사
            $('#registerProductForm').on('submit', function (e) {
                e.preventDefault();

                const mid = $('#registerCategoryMid').val().trim();
                const sub = $('#registerCategorySub').val().trim();
                const name = $('#registerProductName').val().trim();
                const price = $('#registerProductPrice').val().trim();
                const stored = $('#registerStoredType').val();

                const nameRegex = /^[A-Za-z가-힣]{1,10}$/;
                if (!nameRegex.test(name)) {
                    alert("제품명은 한글과 영문만 가능하며 최대 10자까지 입력 가능합니다.");
                    return;
                }

                if (isNaN(price)) {
                    alert("제공단가는 숫자만 입력 가능합니다.");
                    return;
                }

                if (!isProductNameDuplicateChecked) {
                    alert("제품명 중복 확인을 먼저 진행해주세요.");
                    return;
                }

                if (!mid || !sub || !name || !price || !stored) {
                    alert("모든 항목은 필수 입력입니다.");
                    return;
                }

                this.submit(); // ✅ 유효성 통과 시 실제 form 전송
            });
        });

        $(document).on('click', '#btnProductAdd_clone', function () {
            console.log("제품 등록 버튼 눌림");
            $('#productAddModal').modal('show');
        });

        ///////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////

        window.categoryMidList = [
            <c:forEach var="mid" items="${categoryMidList}" varStatus="vs">
            "${mid}"<c:if test="${!vs.last}">,</c:if>
            </c:forEach>
        ];

        // ✅ 수정 버튼 클릭 시 모달 열기
        $(document).on('click', '#btnProductEdit_clone', function () {
            const $checked = $('#datatable').find('input.row-checkbox:checked');

            if ($checked.length === 0) {
                alert('수정할 제품을 선택해주세요.');
                return;
            }

            const table = $('#datatable').DataTable();
            const $tbody = $('#editProductTable tbody');
            $tbody.empty();

            $checked.each(function (i) {
                const $row = $(this).closest('tr');
                const rowData = {
                    productCode: $row.data('product-code'),
                    categoryMid: $row.data('product-mid'),
                    categorySub: $row.data('product-sub'),
                    storedType: $row.data('product-type'),
                    productName: $row.data('product-name'),
                    productPrice: $row.data('product-price')
                };
                $tbody.append(createEditRow(rowData, i));
            });

            $('#productEditModal').modal('show');

            // 수정 모달 열기 직후: 중분류가 선택된 행에 대해 소분류 자동 호출
            $('#editProductTable tbody tr').each(function () {
                const $row = $(this);
                const mid = $row.find('.mid-select').val();
                const $sub = $row.find('.sub-select');
                const ctx = '${pageContext.request.contextPath}';

                if (!mid) return;

                fetch(ctx + '/category/check?categoryMid=' + encodeURIComponent(mid))
                    .then(res => res.json())
                    .then(subList => {
                        $sub.empty().append('<option value="">소분류 선택</option>');
                        const initSub = $row.data('initial-sub');
                        subList.forEach(sub => {
                            const option = $('<option></option>').val(sub).text(sub);
                            if (sub === initSub) option.attr('selected', 'selected');
                            $sub.append(option);
                        });
                        $sub.prop('disabled', false);
                    })
                    .catch(() => {
                        $sub.empty().append('<option value="">소분류 선택</option>').prop('disabled', true);
                    });
            });
        });

        // ✅ 수정 행 생성 함수 (중분류 드롭다운 + 비동기 소분류)
        function createEditRow(rowData, index) {
            const ctx = '${pageContext.request.contextPath}';
            const midOptions = categoryMidList.map(mid => {
                return '<option value="' + mid + '"' + (mid === rowData.categoryMid ? ' selected' : '') + '>' + mid + '</option>';
            }).join('');

            return (
                '<tr data-duplicate-checked="false" data-initial-mid="' + rowData.categoryMid +
                '" data-initial-sub="' + rowData.categorySub +
                '" data-initial-name="' + rowData.productName + '">' +
                '<td><h6>' + (index + 1) + '&nbsp;&nbsp;</h6></td>' +
                '<td><input type="hidden" name="productList[' + index + '].productCode" value="' + rowData.productCode + '" />' +
                '<span class="form-control form-control-sm text-muted bg-light">' + rowData.productCode + '</span></td>' +

                '<td><select class="form-select form-select-sm required-field mid-select" name="productList[' + index + '].categoryMid">' +
                '<option value="">중분류 선택</option>' + midOptions +
                '</select></td>' +

                '<td><select class="form-select form-select-sm required-field sub-select" name="productList[' + index + '].categorySub">' +
                '<option value="">소분류 선택</option>' +
                '</select></td>' +

                '<td><input type="text" class="form-control form-control-sm required-field name-input" ' +
                'name="productList[' + index + '].productName" maxlength="10" value="' + (rowData.productName || '') + '"></td>' +

                '<td><div class="input-group"><input type="text" class="form-control form-control-sm required-field price-input" ' +
                'name="productList[' + index + '].productPrice" value="' + (rowData.productPrice || '') + '"><span class="input-group-text form-control-sm px-2 py-0"' +
                ' style="height: 30px; line-height: 1.2; font-size: 0.875rem; display: flex; align-items: center;">원</span></div></td>' +

                '<td><select class="form-select form-select-sm required-field stored-select" name="productList[' + index + '].storedType">' +
                '<option value="">선택</option>' +
                '<option value="냉장"' + (rowData.storedType === '냉장' ? ' selected' : '') + '>냉장</option>' +
                '<option value="냉동"' + (rowData.storedType === '냉동' ? ' selected' : '') + '>냉동</option>' +
                '<option value="상온"' + (rowData.storedType === '상온' ? ' selected' : '') + '>상온</option>' +
                '</select></td>' +

                '<td><button type="button" class="main-btn primary-btn btn-hover btn-smaller btnCheckDuplicate">중복확인</button></td>' +
                '</tr>'
            );
        }

        // ✅ 중분류 변경 시 소분류 비동기로 불러오기
        $(document).on('change', '.mid-select', function () {
            const $row = $(this).closest('tr');
            const selectedMid = $(this).val();
            const $sub = $row.find('.sub-select');
            const ctx = '${pageContext.request.contextPath}';

            $sub.empty().append('<option value="">소분류 선택</option>');
            if (!selectedMid) {
                $sub.prop('disabled', true);
                return;
            }

            fetch(ctx + '/category/check?categoryMid=' + encodeURIComponent(selectedMid))
                .then(res => res.json())
                .then(subList => {
                    subList.forEach(sub => {
                        $sub.append(new Option(sub, sub));
                    });
                    $sub.prop('disabled', false);

                    const initMid = $row.data('initial-mid');
                    const initSub = $row.data('initial-sub');
                    if (initMid === selectedMid) {
                        $sub.val(initSub);
                    }
                })
                .catch(() => {
                    console.warn('소분류 불러오기 실패');
                    $sub.prop('disabled', true);
                });
        });

        // ✅ 중복 확인 후 값이 변경되면 다시 확인 필요
        $(document).on('input change', '.mid-select, .sub-select, .name-input', function () {
            const $row = $(this).closest('tr');
            const currentMid = $row.find('.mid-select').val();
            const currentSub = $row.find('.sub-select').val();
            const currentName = $row.find('.name-input').val().trim();

            const initialMid = $row.data('initial-mid');
            const initialSub = $row.data('initial-sub');
            const initialName = $row.data('initial-name');

            const isChanged = currentMid !== initialMid || currentSub !== initialSub || currentName !== initialName;
            if (isChanged) {
                $row.data('duplicateChecked', false);
            }
        });

// ✅ 중복확인 버튼 클릭
        $(document).on('click', '.btnCheckDuplicate', function () {
            const $tr = $(this).closest('tr');
            const mid = $tr.find('.mid-select').val();
            const sub = $tr.find('.sub-select').val();
            const name = $tr.find('.name-input').val().trim();
            const code = $tr.find('input[name$=".productCode"]').val();

            const ctx = '${pageContext.request.contextPath}';
            const index = $tr.index();

            const error = validateEditRow($tr, index, true); // true = 중복확인 중이므로 중복확인 검사 제외
            if (error && error !== '중복 확인을 먼저 해주세요.') {
                alert(error);
                return;
            }

            fetch(ctx + '/qh/product/check?categoryMid=' + encodeURIComponent(mid) +
                '&categorySub=' + encodeURIComponent(sub) +
                '&productName=' + encodeURIComponent(name) +
                '&productCode=' + encodeURIComponent(code))
                .then(res => res.text())
                .then(isDuplicate => {
                    if (isDuplicate === "true") {
                        alert("이미 존재하는 제품입니다.");
                        $tr.data('duplicateChecked', false);
                    } else {
                        alert("사용 가능한 제품명입니다.");
                        $tr.data('duplicateChecked', true);
                    }
                })
                .catch(err => {
                    console.error("중복 확인 중 오류 발생:", err);
                    alert("중복 확인 실패");
                    $tr.data('duplicateChecked', false);
                });
        });

// ✅ 검증 함수
        function validateEditRow($row, index, ignoreDupCheck = false) {
            const mid = $row.find('.mid-select').val();
            const sub = $row.find('.sub-select').val();
            const name = $row.find('.name-input').val().trim();
            const price = $row.find('.price-input').val().trim();
            const stored = $row.find('.stored-select').val();
            const isChecked = $row.data('duplicateChecked') === true;

            const initialMid = $row.data('initial-mid');
            const initialSub = $row.data('initial-sub');
            const initialName = $row.data('initial-name');
            const isChanged = mid !== initialMid || sub !== initialSub || name !== initialName;

            if (!mid) return (index + 1) + '행: 중분류를 선택해주세요.';
            if (!sub) return (index + 1) + '행: 소분류를 선택해주세요.';
            if (!name) return (index + 1) + '행: 제품명을 입력해주세요.';
            if (!/^[A-Za-z가-힣]{1,15}$/.test(name)) return '(' + (index + 1) + '행) 제품명 형식이 올바르지 않습니다.';
            if (!price) return (index + 1) + '행: 제공단가를 입력해주세요.';
            if (isNaN(price)) return (index + 1) + '행: 제공단가는 숫자여야 합니다.';
            if (!stored) return (index + 1) + '행: 보관타입을 선택해주세요.';

            if (!ignoreDupCheck && isChanged && !isChecked) {
                return (index + 1) + '행: 중분류, 소분류 또는 제품명이 변경되었습니다. 중복 확인을 해주세요.';
            }

            return null;
        }

// ✅ 제출 전 유효성 검사 + alert
        $(document).on('click', '#btnProductEditSubmit', function (e) {
            e.preventDefault();

            const $rows = $('#editProductTable tbody tr');
            for (let i = 0; i < $rows.length; i++) {
                const $row = $($rows[i]);
                const error = validateEditRow($row, i);
                if (error) {
                    alert(error);
                    return;
                }
            }

            alert('제품이 성공적으로 수정되었습니다.');
            $('#productEditModal').modal('hide');
        });


        ////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////

        let deleteProductCandidates = [];

        $('#btnProductDelete_clone').on('click', function () {
            deleteProductCandidates.length = 0;
            deleteProductCandidates = [];
            $('#deleteProductList').empty();

            let allDeletable = true;

            table.rows({ page: 'current' }).nodes().each(function (row) {
                const $tr = $(row);
                if ($tr.find('.row-checkbox').prop('checked')) {
                    deleteProductCandidates.push({
                        code: $tr.data('product-code'),
                        name: $tr.data('product-name'),
                        status: $tr.data('product-status') || '삭제가능'
                    });
                }
            });

            if (deleteProductCandidates.length === 0) {
                alert('삭제할 제품을 선택하세요.');
                return;
            }

            deleteProductCandidates.forEach(function (item) {
                const canDelete = (item.status || '').trim() === '삭제가능';
                if (!canDelete) allDeletable = false;

                const badgeClass = canDelete ? 'bg-success' : 'bg-danger';
                const badge = '<span class="badge ' + badgeClass + '">' + item.status + '</span>';

                $('#deleteProductList').append(
                    '<li class="list-group-item d-flex justify-content-between align-items-center">'
                    + item.name + badge + '</li>'
                );
            });

            // 안내문 + 버튼 텍스트 분기
            $('#productDeleteModal .modal-body h5').text(
                allDeletable
                    ? '선택한 제품을 정말 삭제하시겠습니까?'
                    : '선택한 제품 중 삭제할 수 없는 항목이 포함되어 있습니다.'
            );
            $('#btnProductDeletSubmit').text(allDeletable ? '삭제' : '삭제가능 품목만 삭제');

            $('#productDeleteModal').modal('show');
        });

        // 삭제 확인 버튼 클릭
        $('#btnProductDeletSubmit').off('click').on('click', function (e) {
            e.preventDefault();

            const btnText = $(this).text();
            const $form = $('#productDeleteForm');
            $form.find('input[type="hidden"]').remove(); // ❗ 안내문 날리지 말고 input만 지움

            deleteProductCandidates.forEach(function (item) {
                const canDelete = item.status === '삭제가능';
                if (btnText === '삭제' || (btnText === '삭제가능 품목만 삭제' && canDelete)) {
                    $form.append('<input type="hidden" name="productCodes" value="' + item.code + '">');
                }
            });

            if ($form.find('input').length === 0) {
                alert('삭제 가능한 제품이 없습니다.');
                document.activeElement.blur();
                $('#productDeleteModal').modal('hide');
                return false;
            }

            $form.submit(); // 서버 전송
        });
    });
</script>

<!-- 마이페이지 -->
<script>
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>
</script>

</body>
</html>