<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="<c:url value='/resources/images/logo/favicon_logo.png'/>" type="image/png" />
    <title>Prokin Donuts</title>

    <!-- ========== All CSS files linkup ========= -->
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/resources/css/lineicons.css'/>" type="text/css" />
    <link rel="stylesheet" href="<c:url value='/resources/css/materialdesignicons.min.css'/>" type="text/css" />
    <link rel="stylesheet" href="<c:url value='/resources/css/fullcalendar.css'/>" />
    <link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>" />
    <!-- datatable을 위해 필요함 -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
</head>

<body>
<!-- ======== Preloader =========== -->
<div id="preloader">
    <div class="spinner"></div>
</div>
<!-- ======== Preloader =========== -->

<!-- 커서 디자인 -->
<div class="cursor">
    <img src="<c:url value='/resources/images/logo/donut.svg'/>" alt="cursor">
</div>
<!-- ======== sidebar-nav start =========== -->
<%@include file="/WEB-INF/views/includes/sidebar/wmSidebar.jsp"%>
<!-- ======== sidebar-nav end =========== -->

<!-- ======== main-wrapper start =========== -->
<main class="main-wrapper">
    <!-- ========== header start ========== -->
    <%@include file="/WEB-INF/views/includes/header/LoginMemberHeader.jsp"%>
    <!-- ========== header end ========== -->
    <!-- Modal HTML Start -->
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
                            <h2>입고요청</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ========== title-wrapper end ========== -->

            <div class="row">
                <!-- Start col -->
                <div class="col-lg-12">
                    <!-- Start card -->
                    <div class="card-style mb-30">
                        <h6 class="mb-10">제품 메뉴</h6>
                        <p class="text-sm mb-20"></p>

                        <!-- 원하는 필터(중분류, 소분류) 설정 -->
                        <div id="myCustomFilters" style="display: none;">

                            <div class="d-flex align-items-center gap-2">

                                <!-- 중분류 -->
                                <div >
                                    <div class="select-style-1">
                                        <div class="select-position">
                                            <!-- 중분류 드롭다운 -->
                                            <select id="midCategory">
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
                                            <select id="subCategory">
                                                <option value="">소분류</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- 필터 초기화 -->
                                <div class="mb-30">
                                    <button class="main-btn warning-btn-outline square-btn btn-hover btn-sm btn-xs" id="resetFilterBtn" style="height:auto; min-height:auto;">
                                        필터 초기화
                                    </button>
                                </div>

                                <!-- 오른쪽: 등록/수정/삭제 -->
                                <div class="btu-group-1 d-flex gap-2 mb-30">
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm btn-xs" id="btnInboundAdd">입고 요청</button>
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm btn-xs" id="btnAutoInboundAdd" onclick="testAutoInbound()">자동입고 요청</button>
                                </div>
                            </div>
                        </div>
                        <div class="table-wrapper table-responsive p-0">
                            <!-- Start table -->
                            <table id="datatable" class="table striped-table w-100 inbound-datatable" style="width:100%">
                                <thead>
                                <tr>
                                    <th><input type="checkbox" id="select-all"></th>
                                    <th>중분류</th>
                                    <th>소분류</th>
                                    <th>제품코드</th>
                                    <th>제품명</th>
                                    <th>제품단가</th>
                                    <th>보관타입</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="product" items="${product}">
                                    <tr>
                                        <td></td>
                                        <td>${product.categoryMid}</td>
                                        <td>${product.categorySub}</td>
                                        <td>${product.productCode}</td>
                                        <td>${product.productName}</td>
                                        <td><fmt:formatNumber value="${product.productPrice}" type="number"/>원</td>
                                        <td>${product.storedType}</td>

                                    </tr>
                                </c:forEach>
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal HTML Start -->
            <!-- 입고 요청 모달 -->
            <form id="inboundForm" action="/wm/inbound/request" method="post"  accept-charset="UTF-8">
                <div class="modal fade" id="addInboundModal" tabindex="-1" role="dialog" aria-labelledby="addInboundModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document"> <!-- modal-lg: 큰 창 -->
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">입고 요청 확인</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <%--<c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger mt-3">
                                            ${errorMessage}
                                    </div>
                                </c:if>--%>
                                <p>수량과 입고 날짜를 선택하고 입고요청 완료 버튼을 클릭하세요.</p>
                                <table class="table" id="selectedProductsTable">
                                    <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>제품코드</th>
                                        <th>제품명</th>
                                        <th>제품단가</th>
                                        <th>보관타입</th>
                                        <th>수량</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <!-- JS로 동적 추가 -->
                                    </tbody>
                                </table>
                            </div>
                            <div class="modal-footer d-flex justify-content-between align-items-center">
                                <!-- 왼쪽: 입고 날짜 -->
                                <div class="form-group mb-0">
                                    <label for="inboundDate" class="mr-2 mb-0">입고 날짜:</label>
                                    <input type="date" class="form-control form-control-sm d-inline-block" id="inboundDate" style="width: auto;" />
                                </div>

                                <div>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                                    <button type="button" class="main-btn primary-btn btn-primary btn-sm">입고 요청 완료</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </form>
            <!-- Modal HTML End -->

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

<!-- ========= All Javascript files linkup ======== -->
<script src="<c:url value='/resources/js/Chart.min.js'/>"></script>
<script src="<c:url value='/resources/js/dynamic-pie-chart.js'/>"></script>
<script src="<c:url value='/resources/js/moment.min.js'/>"></script>
<script src="<c:url value='/resources/js/fullcalendar.js'/>"></script>
<script src="<c:url value='/resources/js/jvectormap.min.js'/>"></script>
<script src="<c:url value='/resources/js/world-merc.js'/>"></script>
<script src="<c:url value='/resources/js/polyfill.js'/>"></script>
<script src="<c:url value='/resources/js/main.js'/>"></script>
<!-- datatable을 위해 필요함 -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="<c:url value='/resources/js/bootstrap.bundle.min.js'/>"></script>

<!-- 커서 디자인 -->
<script>
    // body 맨 아래에 한 번만!
    const cursorEl = document.querySelector('.cursor');
    let shown = false;

    document.addEventListener('mousemove', e => {
        // 좌표 업데이트
        cursorEl.style.left = e.clientX + 10 + 'px';
        cursorEl.style.top  = e.clientY + 10 + 'px';

        // 첫 움직임에만 보이게
        if (!shown) {
            cursorEl.classList.add('visible');
            shown = true;
        }
    });
</script>

<script>
    //ID가 datatable인 테이블을 DataTables로 초기화하고 반환된 객체를 table 변수에 저장.
    var table = $('#datatable').DataTable({
        autoWidth: false,
        columnDefs: [
            {targets: 0, orderable: false, searchable: false}, // 체크박스 컬럼
            // { targets: [0, 1, 2, 3], className: 'text-center' }
            {targets: [1, 2, 3, 4, 5, 6], className: 'text-center'}
            // { targets: [1, 2, 3, 4, 6, 7], className: 'text-center' }
        ],
        order: [[1, 'asc']],
        columns: [
            { // 체크박스 컬럼
                data: null,
                orderable: false,
                searchable: false,
                render: function (data, type, row, meta) {
                    return '<input type="checkbox" class="row-checkbox">';
                }
            },
            {data: 'categoryMid', title: '중분류'},
            {data: 'categoryMSub', title: '소분류'},
            {data: 'productCode', title: '제품코드'},
            {data: 'productName', title: '제품명'},
            {data: 'productPrice', title: '제품단가'},
            {data: 'storedType', title: '보관타입'},
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
        initComplete: function (settings, json) {
            $('#datatable thead th').eq(0).removeClass('sorting sorting_asc sorting_desc');
            fixLengthDropdownStyle();
            const api = this.api();

            setTimeout(() => {
                api.draw(false);
            }, 0);
        },
        // 새로고침 후 체크박스에서 정렬 화살표 지우기 (유지)
        drawCallback: function (settings) {
            $('#datatable thead th').eq(0).removeClass('sorting sorting_asc sorting_desc');
        }
    });

    // 5. DataTable 초기화 (dom 옵션에 사용자 정의 영역 포함)
    function fixLengthDropdownStyle() {
        const $length = $('.dataTables_length');
        const $select = $length.find('select');
        const selectedValue = $select.val();

        const $filter = $('#datatable_filter');
        const $input = $filter.find('input');

        // 기존 label 텍스트 제거 (ex. "표시 개수")
        $length.find('label').contents().filter(function () {
            return this.nodeType === 3; // 텍스트 노드
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
        $('.dataTables_paginate .paginate_button').removeClass().addClass('main-btn deactive-btn-outline square-btn btn-hover mt-1 pt-2 pb-2 pl-15 pr-15');
    });

    // 6. 사용자 정의 필터 영역에 원본 필터를 복제하여 주입
    var $clone = $('#myCustomFilters').clone(true);

    // 복제 후 삽입 시, ID 제거 필수!
    $clone.find('#midCategory').attr('id', 'midCategory_clone');
    $clone.find('#subCategory').attr('id', 'subCategory_clone');

    $clone.find('#btnInboundAdd').attr('id', 'btnInboundAdd_clone');
    $clone.find('#btnInboundEdit').attr('id', 'btnInboundEdit_clone');
    $clone.find('#btnInboundDelete').attr('id', 'btnInboundDelete_clone');
    $clone.find('#btnInboundAdd, #btnInboundEdit, #btnInboundDelete').remove();
    $('div.myFilterArea').html($clone.html());

    // select 태그 감싸는 구조 적용
    $('.dataTables_length select').each(function () {
        const $select = $(this);
        if (!$select.parent().hasClass('select-position')) {
            $select.wrap('<div class="col-lg-2"><div class="select-style-1"><div class="select-position"></div></div></div>');
        }
    });

    ///////////////////////

    // 2. 소분류 비활성화 초기화
    $('#subCategory_clone').prop('disabled', true);

    // 3. 중분류 변경 시 → 소분류 초기화 + fetch 요청
    $("#midCategory_clone").on("change", function() {
        const midVal = $(this).val();
        const $sub = $("#subCategory_clone");

        // 3-1. 초기화
        $sub.empty().append('<option value="">소분류 선택</option>');

        if (!midVal) {
            $sub.prop("disabled", true);
            return;
        }

        // 3-2. fetch 요청
        const contextPath = "${pageContext.request.contextPath}";
        fetch(`${contextPath}/category/check?categoryMid=`+encodeURIComponent(midVal))
            .then(res => res.json())
            .then(subList => {
                subList.forEach(sub => {
                    $sub.append(new Option(sub, sub));
                });
                $sub.prop("disabled", false);
                if (typeof table !== "undefined") table.draw();
            })
            .catch(() => {
                console.warn("Failed to fetch subcategories");
                $sub.prop("disabled", true);
            });
    });

    // 4. 소분류, 창고, 중분류 선택 시 필터링 동작
    $('#midCategory_clone, #subCategory_clone').on('change', function () {
        table.draw();
    });

    // 5. 필터링 로직 정의
    $.fn.dataTable.ext.search.push(function(settings, data) {
        const selectedMid = $('#midCategory_clone').val();
        const selectedSub = $('#subCategory_clone').val();

        const categoryMid = data[1];   // "중분류" 칼럼
        const categorySub = data[2];   // "소분류" 칼럼

        // 1) 중분류 필터
        if (selectedMid && selectedMid !== categoryMid) {
            return false;
        }
        // 2) 소분류 필터
        if (selectedSub && selectedSub !== categorySub) {
            return false;
        }

        // 조건 만족 시 표시
        return true;
    });

    // 6. 필터 초기화 버튼
    $('body').on('click', '#resetFilterBtn', function () {
        $('#midCategory_clone').val('');
        $('#subCategory_clone').val('').prop('disabled', true);
        table.draw();
    });

    // 7. 입력창 변화에 반응
    $('#productNameInput').on('keyup', function() {
        table.draw();
    });



    /////////////////////










    // 8. "Select All" 체크박스 이벤트 및 페이지 변경 시 초기화 등은 그대로 유지
    $('#select-all').on('click', function () {
        const rows = table.rows({page: 'current'}).nodes();
        $('input.row-checkbox', rows).prop('checked', this.checked);
    });
    $('#datatable tbody').on('change', 'input.row-checkbox', function () {
        if (!this.checked) {
            const el = $('#select-all').get(0);
            if (el && el.checked) {
                el.checked = false;
            }
        }
    });

    table.on('draw', function () {
        $('#select-all').prop('checked', false);
    });

    // "입고 요청" 버튼 클릭 시
    $('#btnInboundAdd_clone').on('click', function () {
        const selectedData = [];

        // 체크된 행들의 데이터 수집
        $('#datatable tbody input.row-checkbox:checked').each(function () {
            const rowData = table.row($(this).closest('tr')).data();
            console.log(rowData);
            selectedData.push(rowData);
        });

        // 체크 안 되어 있으면 알림
        if (selectedData.length === 0) {
            alert('입고 요청할 제품을 선택해주세요.');
            return;
        }

        // 모달 내부 테이블 초기화
        const $tableBody = $('#selectedProductsTable tbody');
        $tableBody.empty();

        // 선택한 제품 정보 테이블에 삽입
        selectedData.forEach((item, index) => {
            const rowHtml = `
        <tr>
          <td> ` + (index + 1) + `</td>
          <td>` + item.productCode + `</td>
          <td>` + item.productName + `</td>
          <td>` + item.productPrice + `</td>
          <td>` + item.storedType + `</td>
          <td><input type="number" class="form-control quantity-input"  min="100" value="100" step="100" style="width: 80px;"></td>
        </tr>
      `;
            $tableBody.append(rowHtml);
        });

        // 모달 열기
        $('#addInboundModal').modal('show');
    });

    // "자동입고 요청" 버튼 클릭 시
    $(document).ready(function() {
        console.log('문서 로드 완료');
        console.log('자동입고 버튼 존재 여부:', $('#btnAutoInboundAdd').length);
        
        // 버튼에 직접 onclick 이벤트 추가
        $('#btnAutoInboundAdd').click(function () {
            console.log('자동입고 요청 버튼 클릭됨');
            alert('자동입고 요청 버튼이 클릭되었습니다!');
            
            // 백엔드에서 자동입고 대상 제품 데이터를 가져오기
            $.ajax({
                url: '/wm/inbound/auto-request',
                method: 'GET',
                beforeSend: function() {
                    console.log('AJAX 요청 시작: /wm/inbound/auto-request');
                },
                success: function(response) {
                    console.log('자동입고 요청 성공:', response);
                    if (response && response.length > 0) {
                        // 모달 내부 테이블 초기화
                        const $tableBody = $('#selectedProductsTable tbody');
                        $tableBody.empty();

                        // 백엔드에서 받은 제품 정보 테이블에 삽입
                        response.forEach((item, index) => {
                            const rowHtml = `
                        <tr>
                          <td> ` + (index + 1) + `</td>
                          <td>` + item.productCode + `</td>
                          <td>` + item.productName + `</td>
                          <td>` + item.productPrice + `</td>
                          <td>` + item.storedType + `</td>
                          <td><input type="number" class="form-control quantity-input" min="100" value="` + (item.suggestedQuantity || 100) + `" step="100" style="width: 80px;"></td>
                        </tr>
                      `;
                            $tableBody.append(rowHtml);
                        });

                        // 모달 열기
                        $('#addInboundModal').modal('show');
                    } else {
                        alert('자동입고 대상 제품이 없습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('자동입고 요청 데이터 가져오기 실패:', error);
                    console.error('상태:', status);
                    console.error('응답:', xhr.responseText);
                    alert('자동입고 요청 데이터를 가져오는데 실패했습니다.');
                }
            });
        });
    });

    $('#addInboundModal').on('shown.bs.modal', function () {
        const today = new Date();
        console.log(today);

        const yyyy = today.getFullYear();
        const mm = String(today.getMonth() + 1).padStart(2, '0'); // 반드시 +1 필요
        const dd = String(today.getDate()).padStart(2, '0');      // 0으로 시작되게 패딩

        const minDate = `` + yyyy + `-` + mm + `-` + dd + ``;

        console.log('✅ 오늘 날짜 (minDate):', minDate); // 여기서 값 확인
        $('#inboundDate').attr('min', minDate);

    });



    $('#addInboundModal .btn-primary').on('click', function () {
        let invalid = false;
        // 기존 input 정리
        $('#inboundForm input.dynamic-field').remove();
        // 날짜 추가
        const inboundDate = $('#inboundDate').val();
        //입고 날짜 선택 안 하면 return
        if (!inboundDate) {
            alert('입고 날짜를 선택해주세요.');
            return;
        }

        $('<input>').attr({
            type: 'hidden',
            name: 'inboundDate',
            value: inboundDate,
            class: 'dynamic-field'
        }).appendTo('#inboundForm');

        // 제품 목록 반복
        $('#selectedProductsTable tbody tr').each(function (i) {

            const $tds = $(this).find('td');
            const quantity = $(this).find('.quantity-input').val();

            if (!/^\d+$/.test(quantity)) {
                alert("수량은 자연수만 입력해주세요.");
                invalid = true;
                return false;
            }

            const productCode = $tds.eq(1).text().trim();
            const productName = $tds.eq(2).text().trim();
            // const productPrice = $tds.eq(3).text().trim();
            const productPriceText = $tds.eq(3).text().trim(); // 예: '10,000원'
            const productPrice = Number(productPriceText.replace(/[^0-9]/g, '')); // → 10000
            const storedType = $tds.eq(4).text().trim();

            // form에 hidden input 추가
            $('<input>').attr({
                type: 'hidden',
                name: 'productList[' + i + '].productCode',
                value: productCode,
                class: 'dynamic-field'
            }).appendTo('#inboundForm');

            $('<input>').attr({
                type: 'hidden',
                name: 'productList[' + i + '].productName',
                value: productName,
                class: 'dynamic-field'
            }).appendTo('#inboundForm');

            $('<input>').attr({
                type: 'hidden',
                name: 'productList[' + i + '].productPrice',
                value: productPrice,
                class: 'dynamic-field'
            }).appendTo('#inboundForm');

            $('<input>').attr({
                type: 'hidden',
                name: 'productList[' + i + '].storedType',
                value: storedType,
                class: 'dynamic-field'
            }).appendTo('#inboundForm');

            $('<input>').attr({
                type: 'hidden',
                name: 'productList[' + i + '].quantity',
                value: quantity,
                class: 'dynamic-field'
            }).appendTo('#inboundForm');
        });

        if (invalid) {
            return;
        }
        // form 전송
        $('#inboundForm').submit();
    });
    console.log($('#inboundDate').length); // 1 아니면 문제 있음
    
    // 자동입고 요청 함수
    function testAutoInbound() {
        console.log('자동입고 요청 함수 호출됨');
        
        // 백엔드에서 자동입고 대상 제품 데이터를 가져오기
        $.ajax({
            url: '/wm/inbound/auto-request',
            method: 'GET',
            beforeSend: function() {
                console.log('AJAX 요청 시작: /wm/inbound/auto-request');
            },
            success: function(response) {
                console.log('자동입고 요청 성공:', response);
                if (response && response.length > 0) {
                    // 모달 내부 테이블 초기화
                    const $tableBody = $('#selectedProductsTable tbody');
                    $tableBody.empty();

                    // 백엔드에서 받은 제품 정보 테이블에 삽입
                    response.forEach((item, index) => {
                        const rowHtml = `
                    <tr>
                      <td> ` + (index + 1) + `</td>
                      <td>` + item.productCode + `</td>
                      <td>` + item.productName + `</td>
                      <td>` + item.productPrice + `</td>
                      <td>` + item.storedType + `</td>
                      <td><input type="number" class="form-control quantity-input" min="100" value="` + (item.suggestedQuantity || 100) + `" step="100" style="width: 80px;"></td>
                    </tr>
                  `;
                        $tableBody.append(rowHtml);
                    });

                    // 모달 열기
                    $('#addInboundModal').modal('show');
                } else {
                    alert('자동입고 대상 제품이 없습니다.');
                }
            },
            error: function(xhr, status, error) {
                console.error('자동입고 요청 데이터 가져오기 실패:', error);
                console.error('상태:', status);
                console.error('응답:', xhr.responseText);
                alert('자동입고 요청 데이터를 가져오는데 실패했습니다.');
            }
        });
    }
    
    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>


</script>
<c:if test="${not empty successMessage}">
    <script>
        alert('${successMessage}');
    </script>
</c:if>

<c:if test="${not empty errorMessage}">
    <script>
        alert('${errorMessage}');
    </script>
</c:if>

<c:if test="${showModal}">
    <script>
        $(document).ready(function () {
            $('#addInboundModal').modal('show'); // ❗ 등록 실패 후 모달 유지
        });
    </script>
</c:if>
</body>
</html>