<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%@include file="/WEB-INF/views/includes/sidebar/wmSidebar.jsp"%>
<!-- ======== sidebar-nav end =========== -->

<!-- ======== main-wrapper start =========== -->
<main class="main-wrapper">
    <!-- ========== header start ========== -->
    <%@include file="/WEB-INF/views/includes/Header/wmHeader.jsp"%>
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
                            <h2>회원관리</h2>
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
                        <h6 class="mb-10">회원 목록</h6>
                        <p class="text-sm mb-20"></p>

                        <div id="myCustomFilters" style="display: none;">
                            <div class="d-flex align-items-center gap-2" style="margin-top: -30px;">
                            </div>
                        </div>
                        <div class="table-wrapper p-0">
                            <!-- Start table -->
                            <table id="datatable" class="table striped-table w-100 member-datatable" style="width:100%">
                                <thead>
                                <tr>
                                    <th>회원코드</th>
                                    <th>성함</th>
                                    <th>전화번호</th>
                                    <th>이메일</th>
                                    <th>주소</th>
                                    <th>아이디</th>
                                    <th>비밀번호</th>
                                </tr>
                                </thead>
                                <tbody></tbody>
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
    var table = $('#datatable').DataTable({
        autoWidth: false,
        columnDefs: [
            { targets: [0, 1, 2, 3, 4, 5 ,6], className: 'text-center' }
        ],
        order: [[0, 'asc']],
        ajax: function(data, callback, settings) {
            const dummyMembers = [
                { memberCode: "QH1", authCode: "QH", name: "김성실", phone: "010-4894-2574", email: "sungs_01@gmail.com", address: "경기도 수원 영통 덕영대로 1705 903호", id: "sungsil01", password: "sungsil01!", loginStatus: "logout" },
                { memberCode: "WM1", authCode: "WM", name: "이근면", phone: "010-5598-7895", email: "lee233@gmail.com", address: "서울 삼성117로 5층 523호", id: "lee233", password: "lee233!", loginStatus: "logout" },
                { memberCode: "WM2", authCode: "WM", name: "김세진", phone: "010–2345–6789", email: "sejin_wm2@gmail.com", address: "서울 마포구 월드컵북로 400 12층", id: "ksejin", password: "ksejin!", loginStatus: "logout" },
                { memberCode: "WM3", authCode: "WM", name: "박수연", phone: "010–3456–7890", email: "suyeon_wm3@gmail.com", address: "서울 강남구 도산대로 122", id: "psuyeon", password: "psuyeon!", loginStatus: "logout" },
                { memberCode: "WM4", authCode: "WM", name: "오민재", phone: "010–4567–8901", email: "minjae_wm4@gmail.com", address: "서울 송파구 백제고분로 55", id: "omin0316", password: "omin0316!", loginStatus: "logout" },
                { memberCode: "FM1", authCode: "FM", name: "박열정", phone: "010-6665-4589", email: "fire123@gmail.com", address: "경기도 화성 행궁동 곱창길 11-4번지, 2층", id: "fire123", password: "fire123!", loginStatus: "logout" },
                { memberCode: "FM2", authCode: "FM", name: "조아현", phone: "010–5678–9012", email: "ahyun_fm2@gmail.com", address: "경기도 성남시 분당구 불정로 90", id: "ahyun90", password: "ahyun90!", loginStatus: "logout" },
                { memberCode: "FM3", authCode: "FM", name: "백승우", phone: "010–6789–0123", email: "seungwoo_fm3@gmail.com", address: "부산 남구 수영로 222", id: "woo999", password: "woo999!", loginStatus: "logout" },
                { memberCode: "FM4", authCode: "FM", name: "윤가영", phone: "010–7890–1234", email: "gayoung_fm4@gmail.com", address: "대전 유성구 대학로 99", id: "gyoon0528", password: "gyoon0528!", loginStatus: "logout" }
            ];
            // 데이터를 비동기적으로 불러온 후 callback으로 전달
            // 페이지네이션을 위해 반드시 필요 (단, 본인 더미데이터 변수로 변경 필요)
            Promise.resolve().then(() => {
                callback({ data: dummyMembers });
            });
        },
        columns: [
            { data: 'memberCode', title: '회원코드' },
            { data: 'name', title: '성함' },
            { data: 'phone', title: '전화번호' },
            { data: 'email', title: '이메일' },
            { data: 'address', title: '주소' },
            { data: 'id', title: '아이디' },
            { data: 'password', title: '비밀번호' },
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
            $('#datatable thead th').eq(0).removeClass('sorting sorting_asc sorting_desc');
            fixLengthDropdownStyle();
        },
        // 새로고침 후 체크박스에서 정렬 화살표 지우기 (유지)
        drawCallback: function(settings) {
            $('#datatable thead th').eq(0).removeClass('sorting sorting_asc sorting_desc');
        }
    })

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

    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>
</script>
</body>
</html>