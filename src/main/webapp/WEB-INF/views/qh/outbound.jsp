<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<!-- ======== sidebar-nav start =========== -->

<%@include file="/WEB-INF/views/includes/sidebar/qhSidebar.jsp"%>
<!-- ======== sidebar-nav end =========== -->

<!-- ======== main-wrapper start =========== -->
<main class="main-wrapper">
    <!-- ========== header start ========== -->
    <%@include file="/WEB-INF/views/includes/header/qhHeader.jsp"%>
    <!-- ========== header end ========== -->
    <!-- 마이페이지 모달 -->
    <%@ include file="/WEB-INF/views/includes/mypage/mypage.jsp" %>
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

<script>
    $(document).ready(function() {
        // 1. DataTable 초기화
        // 첫 번째 DataTable (예시: 발주 목록)
        const table1 = $('#datatable_1').DataTable({
            autoWidth: false,
            columnDefs: [
                { width: '95px', targets: -1 },
                { targets: [1, 2, 3, 4], className: 'text-center' }
            ],
            order: [[1, 'asc']],
            // ajax, columns, paging 등 실제 옵션을 채워주세요.
            ajax: function (data, callback, settings) {
                // 더미 데이터 예시
                const dummyOrders = [
                    { orderCode: "ORD1", orderDate: "2025-03-22", orderStatus: "승인대기", fmName: "수원영통점" },
                    { orderCode: "ORD2", orderDate: "2025-03-24", orderStatus: "승인대기", fmName: "수원영통점" },
                    { orderCode: "ORD3", orderDate: "2025-03-26", orderStatus: "승인대기", fmName: "대전둔산점" },
                    { orderCode: "ORD4", orderDate: "2025-03-28", orderStatus: "승인대기", fmName: "대전둔산점" },
                    { orderCode: "ORD5", orderDate: "2025-03-30", orderStatus: "승인대기", fmName: "대전둔산점" }
                ];
                Promise.resolve().then(() => callback({ data: dummyOrders }));
            },
            columns: [
                {
                    data: null,
                    orderable: false,
                    searchable: false,
                    render: () => '<input type="checkbox" class="row-checkbox">'
                },
                { data: 'orderCode', title: '발주코드' },
                { data: 'orderDate', title: '발주일' },
                { data: 'orderStatus', title: '발주상태' },
                { data: 'fmName', title: '지점명' }
            ],
            paging: true,
            pageLength: 10,
            lengthMenu: [[5, 10, 20, -1], ['5개', '10개', '20개', '전체']],
            searching: true,
            ordering: true,
            info: true,
            lengthChange: true,
            dom: '<"top"l<"myFilterArea_1">fr>t<"bottom"ip>',
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
            initComplete: function () {
                // 원하는 초기 스타일 설정 등
                fixLengthDropdownStyle('datatable_1');
                // 2. 요소 복제
                const $clone = $('#myCustomFilters').clone(true).css('display','block');
                $clone.find('#btnApprove').attr('id', 'btnApprove_clone');
                $(this.api().table().container())
                    .find('div.myFilterArea_1')
                    .append($clone);
            },
            drawCallback: function () {
                $('#datatable_1 thead th').eq(0).removeClass('sorting sorting_asc sorting_desc');
                $('#select-all').prop('checked', false);
            }
        });

        // 두 번째 DataTable (예시: 출고 진행 목록)
        const table2 = $('#datatable_2').DataTable({
            autoWidth: false,
            columnDefs: [
                { targets: [0, 1, 2, 3], className: 'text-center' }
            ],
            order: [[0, 'asc']],
            ajax: function (data, callback, settings) {
                const dummyOutbound = [
                    { outboundCode: "OUT1", outboundDate: "2025-03-22", fmName: "수원영통점", outboundStatus: "출고대기" },
                    { outboundCode: "OUT2", outboundDate: "2025-03-22", fmName: "대전둔산점", outboundStatus: "출고대기" },
                    { outboundCode: "OUT3", outboundDate: "2025-03-22", fmName: "대전둔산점", outboundStatus: "출고대기" },
                    { outboundCode: "OUT4", outboundDate: "2025-03-22", fmName: "수원영통점", outboundStatus: "출고대기" },
                    { outboundCode: "OUT5", outboundDate: "2025-03-22", fmName: "대전둔산점", outboundStatus: "출고대기" }
                ];
                Promise.resolve().then(() => callback({ data: dummyOutbound }));
            },
            columns: [
                { data: 'outboundCode', title: '출고코드' },
                { data: 'outboundDate', title: '발주일' },
                { data: 'fmName', title: '지점명' },
                { data: 'outboundStatus', title: '출고상태' }
            ],
            paging: true,
            pageLength: 10,
            lengthMenu: [[5, 10, 20, -1], ['5개', '10개', '20개', '전체']],
            searching: true,
            ordering: true,
            info: true,
            lengthChange: true,
            dom: '<"top"l<"myFilterArea_2">fr>t<"bottom"ip>',
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
            initComplete: function () {
                fixLengthDropdownStyle('datatable_2');
            },
            drawCallback: function () {
                // DataTables 페이징 버튼 스타일 커스터마이징 등
            }
        });

        // 3. DataTable length dropdown 및 검색 input 커스텀 스타일 함수
        function fixLengthDropdownStyle(tableId) {
            // 해당 테이블의 wrapper 선택
            const $table = $('#' + tableId);
            const $wrapper = $table.closest('.dataTables_wrapper');
            const $length = $wrapper.find('.dataTables_length');
            const $filter = $wrapper.find('.dataTables_filter');

            // 이미 스타일이 적용되어 있으면 리턴
            if ($length.find('.select-style-1').length > 0) return;

            const $select = $length.find('select');
            const selectedValue = $select.val();

            // label 안에 있는 텍스트 노드 제거 (예: "Show")
            $length.find('label').contents().filter(function () {
                return this.nodeType === 3;
            }).remove();

            // 새 wrapper 구성
            const $newWrapper = $(`
          <div class="select-style-1">
            <div class="select-position"></div>
          </div>
        `);
            const $newInput = $('<div class="input-style-1"></div>');

            // select 엘리먼트를 새 wrapper로 이동
            $select.detach();
            $newWrapper.find('.select-position').append($select);
            $length.empty().append($newWrapper);

            // filter 영역의 input 변경: placeholder를 Search...로 지정
            const $input = $filter.find('input');
            $input.detach();
            $input.attr('placeholder', 'Search...');
            $newInput.append($input);
            $filter.empty().append($newInput);

            // 기존 선택값 복원
            $select.val(selectedValue);
        }

        // 4. 테이블 그리는 함수
        // 첫 번째 테이블 draw 이벤트 (table1이 첫 번째 DataTable 객체)
        table1.on('draw', function () {
            $('#datatable_1_wrapper .dataTables_paginate .paginate_button')
                .removeClass()
                .addClass('main-btn deactive-btn-outline square-btn btn-hover mt-1 pt-2 pb-2 pl-15 pr-15');
        });

        // 두 번째 테이블 draw 이벤트 (table2이 두 번째 DataTable 객체)
        table2.on('draw', function () {
            $('#datatable_2_wrapper .dataTables_paginate .paginate_button')
                .removeClass()
                .addClass('main-btn deactive-btn-outline square-btn btn-hover mt-1 pt-2 pb-2 pl-15 pr-15');
        });

        // 5. "Select All" 체크박스 기능 (첫 번째 테이블만 예시)
        $('#select-all').on('click', function () {
            const rows = table1.rows({ page: 'current' }).nodes();
            $('input.row-checkbox', rows).prop('checked', this.checked);
        });

        // 각 행의 개별 체크박스 변경 시 "Select All" 체크 해제
        $('#datatable_1 tbody').on('change', 'input.row-checkbox', function () {
            if (!this.checked) {
                const el = $('#select-all').get(0);
                if (el && el.checked) el.checked = false;
            }
        });

        // 6. 승인 버튼 클릭 이벤트 -> 이벤트 위임 방식 사용필
        $(document).on('click', '#btnApprove_clone', function () {
            const selectedRows = table1.rows({ page: 'current' }).nodes();
            const selectedData = [];
            $(selectedRows).each(function () {
                if ($(this).find('.row-checkbox').prop('checked')) {
                    const data = table1.row(this).data();
                    selectedData.push(data);
                }
            });

            if (selectedData.length === 0) {
                alert('승인할 요청을 선택하세요.');
                return;
            }

            const $list = $('#approveList');
            $list.empty();
            selectedData.forEach((item) => {
                const $li = $(`
            <li class="list-group-item d-flex justify-content-between align-items-center">
              <span>${item.fmName} (${item.orderDate})</span>
              <span class="badge bg-secondary">${item.orderStatus}</span>
            </li>
          `);
                $list.append($li);
            });

            $('#approveModal').modal('show');
        });

        // 7. 기타 이벤트: mypage 버튼 클릭, 탈퇴 버튼 등
        $('#btnmypageEmail, #btnmypageMenu').on('click', function () {
            const userInfo = {
                id: 'kim_admin',
                password: 'dummyPassword',
                name: '김관리자',
                email: 'email@example.com',
                phone: '010-1234-5678',
                address: '서울시 강남구'
            };
            $('#id').val(userInfo.id);
            $('#password').val(userInfo.password);
            $('#name').val(userInfo.name);
            $('#email').val(userInfo.email);
            $('#PhoneNumber').val(userInfo.phone);
            $('#address').val(userInfo.address);
            $('#mypageModal').modal('show');
        });

        $('#bntMypageSecession').on('click', function (e) {
            const result = confirm('⚠️ 계정을 삭제하시겠습니까?\n삭제된 계정은 복구되지 않습니다.');
            if (result) {
                console.log('삭제 진행!');
            } else {
                console.log('삭제 취소됨!');
            }
            $('#mypageModal').modal('show');
        });
    });


    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>

</script>

</body>
</html>