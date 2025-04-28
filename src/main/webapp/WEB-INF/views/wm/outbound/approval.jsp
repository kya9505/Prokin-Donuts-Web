<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
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
                            <h2>출고관리</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ========== title-wrapper end ========== -->

            <!-- Start col -->
            <div class="col-lg">
                <!-- Start card -->
                <div class="card-style mb-30">
                    <h6 class="mb-10">출고 목록
                        <label>
                            <i
                                    class="mdi mdi-help-circle text-primary"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="right"
                                    data-bs-html="true"
                                    data-bs-custom-class="wide-tooltip"
                                    title="<b>승인</b>: 제품 검수 후 재고에 반영한다.<br><br> <b>수정, 취소</b>: 본사관리자 승인 후에는 불가능"
                                    style="cursor: pointer;">
                            </i>
                        </label>
                    </h6>

                    <p class="text-sm mb-20">

                        <!-- 원하는 필터(중분류, 소분류) 설정 -->
                    <div id="myCustomFilters" style="display: none;">

                        <div class="d-flex flex-wrap gap-2">
                            <!-- 중분류 -->
                            <div >
                                <div class="select-style-1">
                                    <div class="select-position">
                                        <select id="outboundCategories">
                                            <option value="">출고 상태</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- 필터 초기화 -->
                            <div class="mb-20">
                                <button class="main-btn warning-btn-outline btn-hover btn-sm btn-xs" id="resetFilterBtn" style="height:auto; min-height:auto;">
                                    필터 초기화
                                </button>
                            </div>
                        </div>

                    </div>

                    </p>
                    <div class="table-wrapper table-responsive p-0">


                        <!-- Start table -->
                        <table id="datatable" class="table striped-table w-100" style="width:100%">

                            <!-- colgroup를 통해 열 폭을 강제 지정 -->
                            <colgroup>
                                <col style="width: 10%; background-color: null;" />
                                <col style="width: 18%; background-color: null;" />
                                <col style="width: 14%; background-color: null;" />
                                <col style="width: 13%; background-color: null;" />
                                <col style="width: 10%; background-color: null;" />
                                <col style="width: 20%; background-color: null;" />
                                <!-- <col style="width: 10%; background-color: null;" /> -->
                            </colgroup>

                            <thead>
                            <tr>
                                <th>출고코드</th>
                                <th>출고일</th>
                                <th>출고상태</th>
                                <th>창고코드</th>
                                <th>가맹점코드</th>
                                <th>승인|수정|취소</th> <!-- 수정/삭제 열 -->
                            </tr>
                            </thead>
                            <c:forEach var="outbound" items="${outboundList}">
                                <tr>
                                    <td>${outbound.outboundCode}</td>
                                    <td>${outbound.outboundDate}</td>
                                    <td>${outbound.outboundStatus}</td>
                                    <td>${outbound.franchiseCode}</td>
                                    <td>${outbound.warehouseCode}</td>
                                    <td>
                                        <div class="btu-group-2">
                                           <%-- <button class="btn btn-approve text-success" title="출고 승인" id="btnoutboundAdd" data-outbound-code="${outbound.outboundCode}"
                                                    data-outbound-date="${outbound.outboundDate}"
                                                &lt;%&ndash;                                                    현재날짜와 출고날짜가 다르다 or 출고상태가 '승인대기' 상태가 아니다 --> disabled 처리&ndash;%&gt;
                                                    <c:if test="${outbound.outboundDate ne today or outbound.outboundStatus ne '승인대기'}">disabled</c:if>>
                                                <i class="lni lni-checkmark-circle"
                                                   style="color: <c:out value='${(outbound.outboundDate eq today and outbound.outboundStatus eq "승인대기") ? "#28a745" : "#cccccc"}'/>;"></i>
                                            </button>--%>
                                               <button class="btn btn-approve text-success" title="출고 승인" id="btnoutboundAdd" data-outbound-code="${outbound.outboundCode}"
                                                       data-outbound-date="${outbound.outboundDate}"
                                                       <c:if test="${outbound.outboundStatus eq '출고완료'}">disabled</c:if>>
                                                   <i class="lni lni-checkmark-circle"></i>
                                               </button>

                                            <button class="btn btn-edit text-primary-2" data-outbound-code="${outbound.outboundCode}"
                                                    data-outbound-date="${outbound.outboundDate}"
                                                <%--                                                    출고상태가 '출고요청' 상태가 아니면 수정이 불가능하다.--%>
                                                    <c:if test="${outbound.outboundStatus ne '출고요청'}">disabled</c:if>>
                                                <i class="lni lni-pencil"
                                                   style="color: <c:out value='${(outbound.outboundStatus ne "출고요청") ? "#cccccc": "#007bff"}'/>;"></i>
                                            </button>


                                            <button class="btn btn-delete text-danger"  data-outbound-code="${outbound.outboundCode}"
                                                    data-outbound-date="${outbound.outboundDate}"
                                                <%--                                                    출고상태가 '출고요청' 상태가 아니면 취소가 불가능하다--%>
                                                    <c:if test="${outbound.outboundStatus ne '출고요청'}">disabled</c:if>>
                                                <i class="lni lni-trash-can"
                                                   style="color: <c:out value='${(outbound.outboundStatus ne "출고요청") ? "#cccccc": "#red"}'/>;"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <tbody>
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- 승인 모달 -->
        <!-- 출고 승인 상세 보기 모달 -->
        <form id="outboundApproveForm" method="post" action="/wm/outbound/approval" accept-charset="UTF-8">
            <div class="modal fade" id="outboundDetailModal" tabindex="-1" aria-labelledby="outboundDetailModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg"> <!-- 크기 조정 가능: modal-sm, modal-lg 등 -->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="outboundDetailModalLabel">출고 상세 내역</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                        </div>
                        <div class="modal-body">
                            <%--                        서버에 outboundCode 전송--%>
                            <input type="hidden" id="modaloutboundCode" name="outboundCode">

                            <table class="table" id="selectedProductsTable">
                                <thead>
                                <tr>
                                    <th>출고상세코드</th>
                                    <th>수량</th>
                                    <th>출고코드</th>
                                    <th>제품코드</th>
                                </tr>
                                </thead>
                                <tbody id="outboundDetailTableBody_approve">
                                <!-- JavaScript로 채워짐 -->
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer d-flex justify-content-between align-items-center">
                            <div class="form-group mb-0">
                                <input type="date" id="outboundDate_approve" class="form-control" disabled />
                            </div>
                            <div>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                                <button type="submit" class="main-btn primary-btn btn-primary btn-sm">출고 완료</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <%--<!-- 출고 요청 수정 모달 -->
        <form id="outboundEditForm" method="post" action="/wm/outbound/edit" accept-charset="UTF-8">
            <div class="modal fade" id="outboundEditModal" tabindex="-1" aria-labelledby="outboundDetailModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg"> <!-- 크기 조정 가능: modal-sm, modal-lg 등 -->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="outboundDetailModalLabel">출고 상세 내역</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                        </div>
                        <div class="modal-body">
                            <table class="table" id="selectedProductsTable">
                                <thead>
                                <tr>
                                    <th>제품코드</th>
                                    <th>제품명</th>
                                    <th>제품단가</th>
                                    <th>보관타입</th>
                                    <th>수량</th>
                                </tr>
                                </thead>
                                <tbody id="outboundDetailTableBody_edit">
                                <!-- JavaScript로 채워짐 -->
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer d-flex justify-content-between align-items-center">

                            <div class="form-group mb-0">
                                <label for="outboundDate" class="mr-2 mb-0">출고 날짜:</label>
                                <input type="date" class="form-control form-control-sm d-inline-block" id="outboundDate" name = "outboundDate" style="width: auto;" />
                            </div>
                            <div>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                                <button type="submit" class="main-btn primary-btn btn-primary btn-sm">출고 수정</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- 출고 삭제 모달 ! -->
        <form id="outboundDeleteForm" method="post" action="/wm/outbound/cancel" accept-charset="UTF-8">
            <div class="modal fade" id="outboundDeleteModal" tabindex="-1" aria-labelledby="outboundDeleteModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg"> <!-- 크기 조정 가능: modal-sm, modal-lg 등 -->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="outboundDetailModalLabel">출고 상세 내역</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                        </div>
                        <div class="modal-body">

                            <input type="hidden" id="modaloutboundCode_delete" name="outboundCode">

                            <table class="table" id="selectedProductsTable">
                                <thead>
                                <tr>
                                    <th>제품코드</th>
                                    <th>제품명</th>
                                    <th>제품단가</th>
                                    <th>보관타입</th>
                                    <th>수량</th>
                                </tr>
                                </thead>
                                <tbody id="outboundDetailTableBody_delete">
                                <!-- JavaScript로 채워짐 -->
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer d-flex justify-content-between align-items-center">
                            <!-- 왼쪽: 출고 날짜 -->
                            <div class="form-group mb-0">
                                <input type="date" id="outboundDate_delete" class="form-control" disabled />

                                &lt;%&ndash;<input type="date" class="form-control form-control-sm d-inline-block" id="outboundDate" style="width: auto;" />&ndash;%&gt;
                            </div>
                            <div>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                                <button type="submit" class="main-btn primary-btn btn-primary btn-sm">출고 삭제</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>--%>

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

<style>
    button:disabled {
        border: none !important; /* 테두리 제거 */
        background-color: transparent !important; /* 배경도 필요 시 투명하게 */
        box-shadow: none !important; /* 그림자도 제거 */
    }
</style>
<script>
    // Bootstrap 5 Tooltip 활성화 (모달 내부)
    document.addEventListener('DOMContentLoaded', function () {
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });

    const outboundDetails = [
        <c:forEach var="detail" items="${outboundDetailList}" varStatus="loop">
        {
            outboundDetailCode: '${detail.outboundDetailCode}',
            quantity: '${detail.quantity}',
            outboundCode: '${detail.outboundCode}',
            productCode: `${detail.productCode}`,
        }<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];


    $(document).ready(function() {
        // 1. 더미 데이터 정의 (출고상태)
        const dummyoutboundCategories = [
            { "id": "출고대기", "name": "출고대기" },
            { "id": "출고완료", "name": "출고완료" },
        ];

        // 2. 원본 필터 영역에 출고상태 옵션 채우기
        var $midSelect = $('#myCustomFilters #outboundCategories');
        $.each(dummyoutboundCategories, function(index, item) {
            $midSelect.append($('<option>', {
                value: item.id,
                text: item.name
            }));
        });

        // 5. DataTable 초기화 (dom 옵션에 사용자 정의 영역 포함)
        var table = $('#datatable').DataTable({
            autoWidth: false,
            columnDefs: [
                { width: '95px', targets: -1 },  // Actions 열 너비
                { targets: [0, 1, 2, 3], className: 'text-center' } // JS 속성으로 가운데 정렬
            ],
            order: [[0, 'asc']],
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
            initComplete: function(settings, json) {
                fixLengthDropdownStyle();
                const api = this.api();

                setTimeout(() => {
                    api.draw(false);
                }, 0);
            },
            drawCallback: function(settings) {
            }
        });

        function fixLengthDropdownStyle() {
            const $length = $('.dataTables_length');
            const $select = $length.find('select');
            const selectedValue = $select.val();

            const $filter = $('#datatable_filter')
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

        var $clone = $('#myCustomFilters').clone(true);
        // 복제 후 삽입 시, ID 제거 필수!
        $clone.find('#outboundCategories').attr('id', 'outboundCategories_clone');

        $clone.find('#btnoutboundAdd').attr('id', 'btnoutboundAdd_clone');
        $clone.find('#btnoutboundEdit').attr('id', 'btnoutboundEdit_clone');
        $clone.find('#btnoutboundDelete').attr('id', 'btnoutboundDelete_clone');
        $clone.find('#btnoutboundAdd, #btnoutboundEdit, #btnoutboundDelete').remove();
        $('div.myFilterArea').html($clone.html());

        // select 태그 감싸는 구조 적용
        $('.dataTables_length select').each(function() {
            const $select = $(this);
            if (!$select.parent().hasClass('select-position')) {
                $select.wrap('<div class="col-lg-2"><div class="select-style-1"><div class="select-position"></div></div></div>');
            }
        });

        // 6-1. 이벤트 위임 방식으로 변경된 ID에 새롭게 바인딩 (body를 통해 실제 필터에 작동하게!)
        $('body').on('change', '#outboundCategories_clone', function() {
            $('#outboundSubCategories_clone').val('');
            table.draw();
        });

        $('body').on('click', '#resetFilterBtn', function () {
            const table = $('#datatable').DataTable();

            table.search('').columns().search('');

            $('#outboundCategories_clone, #outboundDateInput_clone').val('');

            table.order([[0, 'asc']]);
            table.draw();
        });

        // 7. 필터 이벤트: 드롭다운 변경 시 테이블 필터링
        $('#outboundCategories, #outboundDateInput').on('change keyup', function() {
            table.draw();
        });

        // 7-1. (7번 함수에서 각각이 변경될 때마다) 필터링 함수도 변경된 ID값을 기준으로 수정
        $.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
            const selectedOutbound = $('#outboundCategories_clone').val();
            const categoryOutbound = data[2]; // 출고상태를 기준으로

            // 일부 포함에도 검색
            if (selectedOutbound && !categoryOutbound.includes(selectedOutbound)) {
                return false;
            }

            return true;
        });


        // 모달 열릴 때마다 목록 갱신되게 하면 좋아
        $('#outboundAddModal').on('show.bs.modal', function () {
            populateManagerDropdown();
        });


        // 페이지 전체에서 한 번만 실행
        $('body').on('click', '.btn-approve', function () {
            const outboundCode = $(this).data('outbound-code'); // 버튼에서 코드 가져오기
            console.log('✅ 선택된 outboundCode:', outboundCode);

            const outboundDate = $(this).data('outbound-date');

            // server에서 내려받은 전체 리스트에서 코드로 필터링
            const filteredDetails = outboundDetails.filter(detail => detail.outboundCode === outboundCode);
            console.log('🔍 필터링된 상세내역:', filteredDetails);

            // tbody 비우고 새로 채우기
            const $tbody = $('#outboundDetailTableBody_approve');
            $tbody.empty();

            if (filteredDetails.length === 0) {
                $tbody.append('<tr><td colspan="5">데이터가 없습니다.</td></tr>');
            } else {
                filteredDetails.forEach(detail => {
                    const row = `
                <tr>
                 <td>` + detail.outboundDetailCode + `</td>
                 <td>` + detail.quantity + `</td>
                 <td>` + detail.outboundCode + `</td>
                 <td>` + detail.productCode + `</td>
                </tr>
            `;
                    $tbody.append(row);
                });

            }

            $('#outboundDate_approve').val(outboundDate);
            $('#modaloutboundCode').val(outboundCode);
            console.log(outboundDate);

            // 모달 열기
            const modal = new bootstrap.Modal(document.getElementById('outboundDetailModal'));
            modal.show();
        });



        /*$('#outboundEditModal').on('shown.bs.modal', function () {
            const today = new Date();
            console.log(today);

            const yyyy = today.getFullYear();
            const mm = String(today.getMonth() + 1).padStart(2, '0'); // 반드시 +1 필요
            const dd = String(today.getDate()).padStart(2, '0');      // 0으로 시작되게 패딩

            const minDate = ``+yyyy+`-`+mm+`-`+dd+``;

            console.log('✅ 오늘 날짜 (minDate):', minDate); // 여기서 값 확인
            $('#outboundDate').attr('min', minDate);
        });


        // 수정
        $('body').on('click', '.btn-edit', function () {
            const outboundCode = $(this).data('outbound-code'); // 버튼에서 코드 가져오기
            console.log('✅ 선택된 outboundCode:', outboundCode);

            const outboundDate = $(this).data('outbound-date');

            //출고 날짜 선택 안 하면 return
            if (!outboundDate) {
                alert('출고 날짜를 선택해주세요.');
                return;
            }

            // server에서 내려받은 전체 리스트에서 코드로 필터링
            const filteredDetails = outboundDetails.filter(detail => detail.outboundCode === outboundCode);
            console.log('🔍 필터링된 상세내역:', filteredDetails);

            // tbody 비우고 새로 채우기
            const $tbody = $('#outboundDetailTableBody_edit');
            $tbody.empty();

            if (filteredDetails.length === 0) {
                $tbody.append('<tr><td colspan="5">데이터가 없습니다.</td></tr>');
            } else {
                filteredDetails.forEach((detail, index) => {
                    const row = `
                <tr>
                     <td>` + detail.productCode + `</td>
                     <td>` + detail.productName + `</td>
                     <td>` + detail.productPrice + `</td>
                     <td>` + detail.storedType + `</td>
                     <td>
                        <input type="hidden" name="items[`+index+`].outboundCode" value=`+detail.outboundCode+` />
                        <input type="hidden" name="items[`+index+`].productCode" value=`+detail.productCode+` />
                        <input type="number" name="items[`+index+`].quantity" class="form-control quantity-input"
                               value= ` + detail.quantity + ` + step = "100" min="0" required />
                    </td>
                </tr>
            `;
                    $tbody.append(row);
                });

            }

            $('#outboundDate').val(outboundDate);
            $('#modaloutboundCode').val(outboundCode);
            console.log(outboundDate);

            // 모달 열기
            const modal = new bootstrap.Modal(document.getElementById('outboundEditModal'));
            modal.show();
        });



        //삭제

        $('body').on('click', '.btn-delete', function () {
            const outboundCode = $(this).data('outbound-code'); // 버튼에서 코드 가져오기
            console.log('✅ 선택된 outboundCode:', outboundCode);

            const outboundDate = $(this).data('outbound-date');

            // server에서 내려받은 전체 리스트에서 코드로 필터링
            const filteredDetails = outboundDetails.filter(detail => detail.outboundCode === outboundCode);
            console.log('🔍 필터링된 상세내역:', filteredDetails);

            // tbody 비우고 새로 채우기
            const $tbody = $('#outboundDetailTableBody_delete');
            $tbody.empty();

            if (filteredDetails.length === 0) {
                $tbody.append('<tr><td colspan="5">데이터가 없습니다.</td></tr>');
            } else {
                filteredDetails.forEach(detail => {
                    const row = `
                <tr>
                 <td>` + detail.productCode + `</td>
                 <td>` + detail.productName + `</td>
                 <td>` + detail.productPrice + `</td>
                 <td>` + detail.storedType + `</td>
                 <td>` + detail.quantity + `</td>
                </tr>
            `;
                    $tbody.append(row);
                });

            }

            $('#outboundDate_delete').val(outboundDate);
            $('#modaloutboundCode_delete').val(outboundCode);
            console.log(outboundDate);

            // 모달 열기
            const modal = new bootstrap.Modal(document.getElementById('outboundDeleteModal'));
            modal.show();
        });*/
    });

    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>

</script>

<%--출고승인 완료 알림창--%>
<c:if test="${not empty approveSuccessMessage}">
    <script>
        alert('${approveSuccessMessage}');
    </script>
</c:if>

<%--출고수정 완료 알림창--%>
<c:if test="${not empty editSuccessMessage}">
    <script>
        alert('${editSuccessMessage}');
    </script>
</c:if>

<%--출고취소 완료 알림창--%>
<c:if test="${not empty deleteSuccessMessage}">
    <script>
        alert('${deleteSuccessMessage}');
    </script>
</c:if>

<c:if test="${not empty errorMessage}">
    <script>
        alert('${errorMessage}');
    </script>
</c:if>
</body>
</html>

