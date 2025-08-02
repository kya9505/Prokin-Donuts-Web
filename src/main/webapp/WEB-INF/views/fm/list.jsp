<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
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

<!-- ======== sidebar-nav start =========== -->
<aside class="sidebar-nav-wrapper">
    <div class="navbar-logo">
        <a href="fm-dashboard.html">
            <img src="<c:url value='/resources/images/logo/menu_logo.png'/>" alt="logo" />
        </a>
    </div>
    <nav class="sidebar-nav">
        <ul>
            <li class="nav-item nav-order-status">
                <a href="<c:url value='/fm/order'/>">
                    <span class="icon">
                        <i class="lni lni-stats-up"></i>
                    </span>
                    <span class="text">발주요청</span>
                </a>
            </li>

            <li class="nav-item nav-order-list active">
                <a href="<c:url value='/fm/list'/>">
                    <span class="icon">
                        <i class="lni lni-list"></i>
                    </span>
                    <span class="text">발주목록</span>
                </a>
            </li>
        </ul>
    </nav>
</aside>

<style>
    .sidebar-nav-wrapper {
        visibility: hidden; /* 깜빡임 방지용 */
    }

    .sidebar-nav .nav-item.active > a {
        background-color: transparent !important;
    }

    .sidebar-nav .nav-item.active i {
        color: #FF9D32 !important;
    }

    .sidebar-nav .nav-item.active .text {
        color: #1c1c1c !important;
        font-weight: bold;
    }

    .sidebar-nav .nav-item > a {
        display: flex;
        align-items: center;
        padding: 12px 20px;
        color: #bbb;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .sidebar-nav .nav-item > a:hover {
        background-color: rgba(255, 157, 50, 0.1);
        color: #1c1c1c;
    }

    .sidebar-nav .nav-item .icon {
        margin-right: 13px;
        color: #FF9D32;
    }

    .sidebar-nav .nav-item .text {
        color: #1c1c1c;
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const path = window.location.pathname;

        // 현재 페이지에 따라 active 클래스 설정
        if (path.includes('/fm/list')) {
            document.querySelector('.nav-order-list').classList.add('active');
        } else if (path.includes('/fm/order')) {
            document.querySelector('.nav-order-status').classList.add('active');
        }

        // 깜빡임 방지 → 강조 완료 후 보여줌
        document.querySelector('.sidebar-nav-wrapper').style.visibility = 'visible';
    });
</script>

<div class="overlay"></div>
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
                            <h2>발주현황</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ========== title-wrapper end ========== -->

            <!-- Start col -->
            <div class="col-lg">
                <!-- Start card -->
                <div class="card-style mb-30 w-100">
                    <h6 class="mb-10">발주현황
                        <label>
                            <i
                                    class="mdi mdi-help-circle text-primary"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="right"
                                    data-bs-html="true"
                                    data-bs-custom-class="wide-tooltip"
                                    title="<b>요청한 모든 발주목록 조회</b><br>"
                                    style="cursor: pointer;">
                            </i>
                        </label>
                    </h6>
                    <div class="table-wrapper table-responsive w-100" style="padding:0;">


                        <!-- Start table -->
                        <table id="datatable" class="table striped-table w-100" style="width:100%; table-layout:fixed;">

                            <!-- colgroup를 통해 열 폭을 강제 지정 -->
                            <!-- colgroup 삭제: 가로폭 자동 조정 -->

                            <thead>
                            <tr>
                                <th>발주코드</th>
                                <th>발주예정일</th>
                                <th>상세조회</th>
                            </tr>
                            </thead>
                            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <td>${order.orderCode}</td>
                                    <td>${order.orderDate}</td>
                                    <td>
                                        <button class="main-btn primary-btn-outline btn-hover btn-sm btn-xs btn-detail"
                                                data-order-code="${order.orderCode}">
                                            상세조회
                                        </button>
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

        <!-- 발주 상세 조회 모달 -->
        <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="orderDetailModalLabel">발주 상세 내역</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                    </div>
                    <div class="modal-body">
                        <table class="table" id="orderDetailTable">
                            <thead>
                            <tr>
                                <th>발주코드</th>
                                <th>제품코드</th>
                                <th>제품명</th>
                                <th>제품단가</th>
                                <th>보관타입</th>
                                <th>수량</th>
                                <th>발주상태</th>
                            </tr>
                            </thead>
                            <tbody id="orderDetailTableBody">
                            <!-- JavaScript로 채워짐 -->
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
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
    /* 표 컬럼을 동일하게 분배하고, 텍스트 가운데 정렬 */
    #datatable th, #datatable td {
        text-align: center;
        vertical-align: middle;
        word-break: break-all;
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

    $(document).ready(function() {

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
            const categoryOutbound = data[2]; // 발주상태는 2번째 컬럼 (0부터 시작)

            // 일부 포함에도 검색
            if (selectedOutbound && !categoryOutbound.includes(selectedOutbound)) {
                return false;
            }

            return true;
        });

        // 상세조회 버튼 클릭 이벤트
        $('body').on('click', '.btn-detail', function () {
            const orderCode = $(this).data('order-code');
            console.log('✅ 선택된 orderCode:', orderCode);

            // AJAX로 발주 상세 정보 가져오기
            $.ajax({
                url: '/fm/list/detail',
                method: 'GET',
                data: { orderCode: orderCode },
                success: function(response) {
                    console.log('🔍 발주 상세 정보:', response);

                    // tbody 비우고 새로 채우기
                    const $tbody = $('#orderDetailTableBody');
                    $tbody.empty();

                    if (response && response.length > 0) {
                        response.forEach(detail => {
                            const row = `
                                <tr>
                                    <td>${detail.orderCode}</td>
                                    <td>${detail.productCode}</td>
                                    <td>${detail.productName}</td>
                                    <td>${detail.productPrice}</td>
                                    <td>${detail.storedType}</td>
                                    <td>${detail.quantity}</td>
                                    <td>${detail.orderStatus}</td>
                                </tr>
                            `;
                            $tbody.append(row);
                        });
                    } else {
                        $tbody.append('<tr><td colspan="7">데이터가 없습니다.</td></tr>');
                    }

                    // 모달 열기
                    const modal = new bootstrap.Modal(document.getElementById('orderDetailModal'));
                    modal.show();
                },
                error: function(xhr, status, error) {
                    console.error('발주 상세 정보 조회 실패:', error);
                    alert('발주 상세 정보를 불러오는데 실패했습니다.');
                }
            });
        });

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

