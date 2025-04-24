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

<!-- ======== sidebar-nav start =========== -->
<aside class="sidebar-nav-wrapper">
    <div class="navbar-logo">
        <a href="fm-dashboard.html">
            <img src="<c:url value='/resources/images/logo/menu_logo.png'/>" alt="logo" />
        </a>
    </div>
    <nav class="sidebar-nav">
        <ul>
            <li class="nav-item">
                <a href="fm-dashboard.html">
              <span style="color:  #FF9D32; margin-right: 13px;">
                <i width="20" height="20" viewBox="0 0 20 20" fill="none" class="lni lni-delivery"></i>
              </span>
                    <span style="color:  #1c1c1c;">발주관리</span>
                </a>
            </li>
        </ul>
    </nav>

</aside>
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
                            <h2>발주관리</h2>
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
                        <h6 class="mb-10">발주 목록</h6>
                        <p class="text-sm mb-20"></p>

                        <div id="myCustomFilters" style="display: none;">
                            <div class="d-flex align-items-center gap-2" style="margin-top: -30px;">
                                <!-- 오른쪽: 등록/수정/삭제 -->
                                <div class="btu-group-1 d-flex gap-2">
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm btn-xs" id="btnMemberAdd">등록</button>
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm btn-xs" id="btnMemberEdit">수정</button>
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm btn-xs" id="btnMemberDelete">삭제</button>
                                </div>
                            </div>
                        </div>
                        <div class="table-wrapper table-responsive p-0">
                            <!-- Start table -->
                            <table id="datatable" class="table striped-table w-100 member-datatable" style="width:100%">
                                <thead>
                                <tr>
                                    <th><input type="checkbox" id="select-all"></th>
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

            <!-- Modal HTML Start -->
            <!-- 등록 모달 -->
            <div class="modal fade" id="memberAddModal" tabindex="-1" aria-labelledby="memberAddModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header d-block">
                            <h3 class="modal-title mb-1" id="memberAddModalLabel">회원 등록</h3>
                            <h6 class="text-danger fw-normal mb-0">(*)는 필수 입력 항목입니다.</h6>
                            <button type="button" class="btn-close position-absolute top-0 end-0 mt-3 me-3" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="registerForm">
                                <div class="mb-3">
                                    <div class="input-style-1 ">
                                        <label>ID (*)</label>
                                        <div class="d-flex gap-2">
                                            <input type="text" placeholder="아이디" class="form-control" />
                                            <a href="#0" class="main-btn primary-btn rounded-full btn-hover ">ID Check</a>
                                        </div>
                                    </div>
                                </div>

                                <!-- end col -->
                                <div class="col-12">
                                    <div class="input-style-1">
                                        <label>Password (*)</label>
                                        <input type="Password" placeholder="초기 비밀번호" />
                                    </div>
                                </div>
                                <!-- end col -->
                                <div class="col-12">
                                    <div class="input-style-1">
                                        <label>Password Check (*)</label>
                                        <input type="password" placeholder="초기 비밀번호 확인" />
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="input-style-1">
                                        <label>Name (*)</label>
                                        <input type="name" placeholder="이름" />
                                    </div>
                                </div>
                                <!-- end col -->
                                <!-- end col -->
                                <div class="col-12">
                                    <div class="input-style-1">
                                        <label>Email (*)</label>
                                        <input type="Email" placeholder="이메일" />
                                    </div>
                                </div>
                                <!-- end col -->
                                <div class="col-12">
                                    <div class="input-style-1">
                                        <label>Phone Number</label>
                                        <input type="text" placeholder="전화번호" />
                                    </div>
                                </div>
                                <!-- end col -->
                                <div class="col-12">
                                    <div class="input-style-1">
                                        <label>address</label>
                                        <input type="text" placeholder="주소" />
                                    </div>
                                </div>

                                <!-- end col -->
                                <div class="col-12">
                                    <div class="button-group d-flex justify-content-center flex-wrap">
                                        <button class="main-btn primary-btn btn-hover w-100 text-center">
                                            회원 등록
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 수정 모달 -->
            <div class="modal fade" id="memberEditModal" tabindex="-1" aria-labelledby="memberEditModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" id="memberEditModalLabel">회원 수정</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="modifyForm">
                                <input type="hidden" id="modifyMemberId">
                                <div class="mb-3">
                                    <select class="form-select" id="modifyStoredType">
                                        <option value="QH">본사관리자</option>
                                        <option value="WM">창고관리자</option>
                                        <option value="FM">가맹점주</option>
                                    </select>
                                    <div class="mb-3">
                                        <label class="form-label">아이디</label>
                                        <input type="id" class="form-control" id="id">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">비밀번호</label>
                                        <input type="password" class="form-control" id="password">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">이름</label>
                                        <input type="text" class="form-control" id="name">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">이메일</label>
                                        <input type="email" class="form-control" id="email">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">전화번호</label>
                                        <input type="text" class="form-control" id="PhoneNumber">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">주소</label>
                                        <input type="text" class="form-control" id="address">
                                    </div>
                                </div>
                            </form>
                            <div class="text-end">
                                <button type="submit"class="main-btn primary-btn btn-hover text-center">수정</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 삭제 모달 -->
            <div class="modal fade" id="memberDeleteModal" tabindex="-1" aria-labelledby="memberDeleteModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" id="memberDeleteModalLabel">회원 삭제</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h5>선택한 회원을 정말 삭제하시겠습니까?</h5><br>
                            <ul id="deleteMemberList" class="list-group mb-3">
                                <!-- 선택된 회원 목록 삽입 -->
                            </ul>
                            <div class="d-flex justify-content-end gap-2">
                                <button type="button" class="main-btn primary-btn btn-hover text-center" id="confirmDelete">삭제</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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
    var table = $('#datatable').DataTable({
        autoWidth: false,
        columnDefs: [
            { targets: 0, orderable: false, searchable: false }, // 체크박스 컬럼
            { targets: [1, 2, 3, 4, 6, 7], className: 'text-center' }
        ],
        order: [[1, 'asc']],
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
            { // 체크박스 컬럼
                data: null,
                orderable: false,
                searchable: false,
                render: function(data, type, row, meta) {
                    return '<input type="checkbox" class="row-checkbox">';
                }
            },
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
    // 복제 후 삽입 시, ID 제거 필수

    $clone.find('#btnMemberAdd').attr('id', 'btnMemberAdd_clone');
    $clone.find('#btnMemberEdit').attr('id', 'btnMemberEdit_clone');
    $clone.find('#btnMemberDelete').attr('id', 'btnMemberDelete_clone');
    $clone.find('#btnMemberAdd, #btnMemberEdit, #btnMemberDelete').remove();
    $('div.myFilterArea').html($clone.html());

    // select 태그 감싸는 구조 적용
    $('.dataTables_length select').each(function() {
        const $select = $(this);
        if (!$select.parent().hasClass('select-position')) {
            $select.wrap('<div class="col-lg-2"><div class="select-style-1"><div class="select-position"></div></div></div>');
        }
    });
    // 8. "Select All" 체크박스 이벤트 및 페이지 변경 시 초기화 등은 그대로 유지
    $('#select-all').on('click', function() {
        const rows = table.rows({ page: 'current' }).nodes();
        $('input.row-checkbox', rows).prop('checked', this.checked);
    });
    $('#datatable tbody').on('change', 'input.row-checkbox', function() {
        if(!this.checked) {
            const el = $('#select-all').get(0);
            if(el && el.checked) {
                el.checked = false;
            }
        }
    });

    table.on('draw', function() {
        $('#select-all').prop('checked', false);
    });

    // 등록 버튼 클릭 시
    $('#btnMemberAdd_clone').on('click', function (e) {
        $('#memberAddModal').modal('show');
    });
    // 수정 버튼 클릭 시
    $('#btnMemberEdit_clone').on('click', function () {
        const selectedRows = table.rows({ page: 'current' }).nodes();
        const selectedData = [];

        $(selectedRows).each(function () {
            if ($(this).find('.row-checkbox').prop('checked')) {
                const data = table.row(this).data();
                selectedData.push(data);
            }
        });

        if (selectedData.length === 0) {
            alert('수정할 항목을 선택하세요.');
            return;
        }

        // 테이블 생성
        const $editTable = $(`
  <table class="table ">
    <thead>
      <tr>
        <th style="width: 800px;">권한</th>
        <th style="width: 800px;">아이디</th>
        <th style="width: 800px;">비밀번호</th>
        <th style="width: 800px;">이름</th>
        <th style="width: 1200px;">이메일</th>
        <th style="width: 1200px;">전화번호</th>
        <th style="width: 1200px;">주소</th>
      </tr>
    </thead>
    <tbody></tbody>
  </table>
`);


        selectedData.forEach((item, index) => {
            const $row = $(
                `<tr>
          <td>
            <select class="form-select" data-index="${index}" data-field="authCode">
              <option value="HQ" ${item.authCode == 'HQ' ? 'selected' : ''}>본사관리자</option>
              <option value="WM" ${item.authCode == 'WM' ? 'selected' : ''}>창고관리자</option>
              <option value="FM" ${item.authCode == 'FM' ? 'selected' : ''}>가맹점주</option>
            </select>
          </td>
          <td><input type="text" class="form-control" value="${item.id}" data-index="${index}" data-field="id" readonly /></td>
          <td><input type="text" class="form-control" value="${item.password}" data-index="${index}" data-field="password" /></td>
          <td><input type="text" class="form-control" value="${item.name}" data-index="${index}" data-field="name" /></td>
          <td><input type="email" class="form-control" value="${item.email}" data-index="${index}" data-field="email" /></td>
          <td><input type="tel" class="form-control" value="${item.phone}" data-index="${index}" data-field="phone" /></td>
          <td><input type="text" class="form-control" value="${item.address}" data-index="${index}" data-field="address" /></td>
        </tr>`
            );

            $editTable.find('tbody').append($row);
        });
        $('#memberEditModal form').html($editTable);
        $('#memberEditModal').modal('show');
    });


    // 삭제 버튼 클릭 시
    $('#btnMemberDelete_clone').on('click', function (e) {
        const selectedRows = table.rows({ page: 'current' }).nodes();
        const selectedData = [];

        $(selectedRows).each(function () {
            if ($(this).find('.row-checkbox').prop('checked')) {
                const data = table.row(this).data();
                selectedData.push(data);
            }
        });

        if (selectedData.length === 0) {
            alert('삭제할 항목을 선택하세요.');
            return;
        }

        // 회원 목록을 <ul> 안에 추가
        const $list = $('#deleteMemberList');
        $list.empty(); // 기존 내용 비우고

        selectedData.forEach((item) => {
            const $li = $(`
      <li class="list-group-item d-flex justify-content-between align-items-center">
        <span>${item.name} (${item.id})</span>
        <span class="badge bg-secondary">${item.authCode}</span>
      </li>
    `);
            $list.append($li);
        });

        // 모달 열기
        $('#memberDeleteModal').modal('show');
    });

    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>

</script>

</body>
</html>