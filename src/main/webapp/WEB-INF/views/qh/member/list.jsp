<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                                    <th>이름</th>
                                    <th>전화번호</th>
                                    <th>이메일</th>
                                    <th>주소</th>
                                    <th>아이디</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="member" items="${qhMemberList}">
                                    <tr data-password="${member.password}">
                                        <td><input type="checkbox" class="row-checkbox" /></td>
                                        <td>${member.memberCode}</td>
                                        <td>${member.name}</td>
                                        <td>${member.phoneNumber}</td>
                                        <td>${member.email}</td>
                                        <td>${member.address}</td>
                                        <td>${member.id}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal HTML Start -->
            <!-- 회원 등록 모달 -->
            <div class="modal fade" id="memberAddModal" tabindex="-1" aria-labelledby="memberAddModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">

                        <!-- 모달 헤더 -->
                        <div class="modal-header">
                            <h3 class="modal-title" id="memberAddModalLabel">회원 등록</h3>
                            <button
                                    type="button"
                                    class="btn-close"
                                    data-bs-dismiss="modal"
                                    aria-label="Close">
                            </button>
                        </div>

                        <!-- 모달 바디 -->
                        <div class="modal-body">
                            <!-- 필수 입력 항목 안내 -->
                            <p class="text-danger fw-normal mb-3">(*)는 필수 입력 항목입니다.</p>

                            <!-- 등록 폼 -->
                            <form id="memberAddForm" action="${pageContext.request.contextPath}/qh/member/add" method="post">
                            <!-- 아이디 중복검사 폼 -->
                                 <div class="mb-3">
                                    <label for="id" class="form-label">ID (*)</label>
                                    <div class="d-flex gap-2">
                                        <input
                                                type="text"
                                                placeholder="아이디"
                                                class="form-control"
                                                name = "id"
                                                id="addId"
                                        />
                                        <button
                                                type="button"
                                                class="main-btn primary-btn btn-hover btn-smaller"
                                                id="idCheck"
                                        >
                                            ID Check
                                        </button>
                                    </div>
                                 </div>
                                <div class="mb-3">
                                    <label class="form-label">authority (*)</label>
                                    <select class="form-select" name="authorityCode" id="authority" required>
                                        <option value="QH">본사관리자</option>
                                        <option value="WM">창고관리자</option>
                                        <option value="FM">가맹점주</option>
                                    </select>
                                </div>
                                <!-- Password -->
                                <div class="mb-3">
                                    <label class="form-label">Password (*)</label>
                                    <input
                                            id="addPassword"
                                            type="password"
                                            placeholder="초기 비밀번호"
                                            class="form-control"
                                            name="password"
                                            required
                                    />
                                </div>

                                <!-- Password Check -->
                                <div class="mb-3">
                                    <label class="form-label">Password Check (*)</label>
                                    <input
                                            id="addPasswordCheck"
                                            type="password"
                                            placeholder="초기 비밀번호 확인"
                                            class="form-control"
                                            name="passwordCheck"
                                            required
                                    />
                                </div>

                                <!-- Name -->
                                <div class="mb-3">
                                    <label class="form-label">Name (*)</label>
                                    <input
                                            id="addName"
                                            type="text"
                                            placeholder="이름"
                                            class="form-control"
                                            name="name"
                                            required
                                    />
                                </div>

                                <!-- Email -->
                                <div class="mb-3">
                                    <label class="form-label">Email (*)</label>
                                    <input
                                            id="addEmail"
                                            name = "email"
                                            type="email"
                                            placeholder="이메일"
                                            class="form-control"
                                            required
                                    />
                                </div>

                                <!-- Phone Number -->
                                <div class="mb-3">
                                    <label class="form-label">Phone Number</label>
                                    <input  id="addPhoneNumber"
                                            name = "phoneNumber"
                                            type="text"
                                            placeholder="전화번호"
                                            class="form-control"
                                    />
                                </div>

                                <!-- Address -->
                                <div class="mb-3">
                                    <label class="form-label">address</label>
                                    <input  id="addAddress"
                                            name ="address"
                                            type="text"
                                            placeholder="주소"
                                            class="form-control"
                                    />
                                </div>

                                <!-- 등록 버튼 -->
                                <div class="text-center w-100 mt-1 mb-3">
                                    <button
                                            type="button"
                                            class="main-btn primary-btn btn-hover text-center"
                                            id = "add-bnt"
                                    >
                                        회원 등록
                                    </button>
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
                    <form id="memberEditForm" name="memberList" method="post" action="/qh/member/update" accept-charset="UTF-8">
                    <table class="table striped-table w-100 member-datatable" style="width:100%">
                        <thead>
                        <tr>
                            <th>권한</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>주소</th>
                            <th>아이디</th>
                        </tr>
                        </thead>
                        <tbody id="memberEditModalBody">
                        <c:if test="${not empty memberList}">
                            <c:forEach var="item" items="${memberList}" varStatus="status">
                                <tr>
                                    <td>
                                        <select class="form-select" name="memberList[${status.index}].authorityCode">
                                            <option value="QH" ${item.authorityCode eq 'QH' ? 'selected' : ''}>본사관리자</option>
                                            <option value="WM" ${item.authorityCode eq 'WM' ? 'selected' : ''}>창고관리자</option>
                                            <option value="FM" ${item.authorityCode eq 'FM' ? 'selected' : ''}>가맹점주</option>
                                        </select>
                                    </td>
                                    <td><input type="text" name="memberList[${status.index}].name" class="form-control" value="${item.name}" /></td>
                                    <td><input type="text" name="memberList[${status.index}].email" class="form-control" value="${item.email}" /></td>
                                    <td><input type="text" name="memberList[${status.index}].phoneNumber" class="form-control" value="${item.phoneNumber}" /></td>
                                    <td><input type="text" name="memberList[${status.index}].address" class="form-control" value="${item.address}" /></td>
                                    <td><input type="text" name="memberList[${status.index}].id" class="form-control" value="${item.id} " readonly/></td>
                                </tr>
                                <input type="hidden" name="memberList[${status.index}].memberCode" value="${item.memberCode}" />
                            </c:forEach>
                        </c:if>

                        </tbody>
                    </table>
                <div class="modal-footer">
                    <button type="submit" class="main-btn primary-btn btn-hover text-center" id="modify-bnt">수정</button>
                </div>
                    </form>
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

                            <form id="memberDeleteForm" method="post" action="/qh/member/delete" accept-charset="UTF-8">
                            <h5>선택한 회원을 정말 삭제하시겠습니까?</h5><br>
                            <ul id="deleteMemberList" class="list-group mb-3 ">
                                <!--선택된 회원 목록 삽입 -->
                            </ul>
                            <div class="d-flex justify-content-end gap-2">
                                <button type="button" class="main-btn primary-btn btn-hover text-center" id="confirmDelete">삭제</button>
                            </div>
                            </form>

                        </div>
                    </div>

                </div>
            </div>

            <!-- Modal HTML End -->

        </div>
    </section>
    <!-- ========== section end ========== -->

    <!-- ==========footer start =========== -->
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
<!-- 다음 우편번호 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
        var table = $('#datatable').DataTable({
        autoWidth: false,
        columnDefs: [
            { width: '95px', targets: -1 },  // Actions 열 너비

            {targets: 0, orderable: false, searchable: false}, // 체크박스 컬럼
            {targets: [1, 2, 3, 4,5, 6], className: 'text-center'}

        ],
        order: [[1, 'asc']],
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
    // 복제 후 삽입 시, ID 제거 필수

    $clone.find('#btnMemberAdd').attr('id', 'btnMemberAdd_clone');
    $clone.find('#btnMemberEdit').attr('id', 'btnMemberEdit_clone');
    $clone.find('#btnMemberDelete').attr('id', 'btnMemberDelete_clone');
    $clone.find('#btnMemberAdd, #btnMemberEdit, #btnMemberDelete').remove();
    $('div.myFilterArea').html($clone.html());

    // select 태그 감싸는 구조 적용
    $('.dataTables_length select').each(function () {
        const $select = $(this);
        if (!$select.parent().hasClass('select-position')) {
            $select.wrap('<div class="col-lg-2"><div class="select-style-1"><div class="select-position"></div></div></div>');
        }
    });
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

    // 등록 버튼 클릭 시
        let isIdChecked = false;
        let isEmailChecked = false;

        function resetRegisterForm() {

            $('#idCheckForm input[name="id"]').val('');
            $('#idCheckForm .id-check-message').text('');
            $('#memberAddForm')[0].reset();
            isIdChecked = false;
        }

        // 모달이 완전히 닫혔을 때
        $('#memberAddModal').on('hidden.bs.modal', function() {
            resetRegisterForm();
        });

        // 1. 등록 모달 열기
        $('#btnMemberAdd_clone').on('click', function (e) {
            resetRegisterForm();
            $("#memberAddModal").modal("show");
        });
        // 2.중복 체크 초기화
        $("#addId").on("input", function () {
            isIdChecked = false;
        });

        // 3. 중복 확인 버튼 (SSR과 연계된 fetch 방식)
        $("#idCheck").on("click", function () {
            const id = $("#addId").val().trim();
            if (!id) {
                alert("아이디를 입력하세요");
                return;
            }

            const contextPath = "${pageContext.request.contextPath}";
            fetch(contextPath + "/qh/member/idCheck?id=" + encodeURIComponent(id))
                .then(function (res) { return res.text(); })  //
                .then(function (text) {
                    const isDup = (text === 'true');  // 문자열 비교
                    if (isDup) {
                        alert("이미 존재하는 아이디입니다.");
                        isIdChecked = false;
                    } else {
                        alert("사용 가능한 아이디입니다.");
                        isIdChecked = true;
                    }
                })
                .catch(function () {
                    alert("중복 확인 중 오류가 발생했습니다.");
                });
        });

        // 등록 버튼 클릭 시
        $('#add-bnt').on('click', async function (e) {
            e.preventDefault();

            const id = $('#addId').val().trim();
            const authority = $('#authority').val().trim();
            const password = $('#addPassword').val().trim();
            const passwordCheck = $('#addPasswordCheck').val().trim();
            const name = $('#addName').val().trim();
            const email = $('#addEmail').val().trim();
            const phoneNumber = $('#addPhoneNumber').val().trim();
            const address = $('#addAddress').val().trim();
            const regName = /^[A-Za-z가-힣]{1,10}$/;
            const regPhone = /^[0-9]{10,11}$/;
            const regEmail = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

            if (!isIdChecked) {
                alert("아이디 중복확인을 해주세요.");
                return;
            }

            if (password !== passwordCheck) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                return;
            }

            if (!regName.test(name)) {
                alert("이름은 한글/영어 조합이며 최대 10글자입니다.");
                return;
            }

            if (!regEmail.test(email)) {
                alert("올바른 이메일 형식을 입력해주세요.");
                return;
            }

            const contextPath = "${pageContext.request.contextPath}";
            try {
                const res = await fetch(contextPath + "/qh/member/emailCheck?email=" + encodeURIComponent(email));
                const text = await res.text();
                if (text === 'true') {
                    alert("이미 존재하는 이메일입니다.");
                    return;
                }
            } catch (error) {
                alert("이메일 중복 확인 중 오류가 발생했습니다.");
                return;
            }

            if (!id || !authority || !password || !passwordCheck || !name || !email) {
                alert("필수 항목을 모두 입력해주세요.");
                return;
            }

            if (phoneNumber && !regPhone.test(phoneNumber)) {
                alert("전화번호는 하이픈 없이 10~11자리 숫자입니다.");
                return;
            }

            const result = confirm('입력하신 정보로 등록 하시겠습니까?');
            if (result) {
                $('#memberAddForm').submit();
            } else {
                console.log('등록 취소');
            }
        });



        // 수정 버튼 클릭 시
        $('#modify-bnt').on('click', async function (e) {
            e.preventDefault();

            const regName = /^[A-Za-z가-힣]{1,10}$/;
            const regEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const regPhone = /^[0-9]{10,11}$/;
            const contextPath = '${pageContext.request.contextPath}';

            const $rows = $('#memberEditModal tbody tr');
            const memberList = [];

            for (let i = 0; i < $rows.length; i++) {
                const $tr = $($rows[i]);
                const name = $tr.find('input[name$=".name"]').val().trim();
                const emailInput = $tr.find('input[name$=".email"]');
                const email = emailInput.val().trim();
                const originalEmail = emailInput.attr('data-original-email');
                const phoneNumber = $tr.find('input[name$=".phoneNumber"]').val().trim();
                const authorityCode = $tr.find('select[name$=".authorityCode"]').val();
                const id = $tr.find('input[name$=".id"]').val().trim();
                const memberCode = $tr.next('input[type="hidden"]').val();
                const password = $tr.next('input[type="hidden"][name$=".password"]').val();

                if (!regName.test(name)) {
                    alert(name + ' 님의 이름이 올바르지 않습니다. (한글/영어 최대 10자)');
                    return;
                }
                if (!regEmail.test(email)) {
                    alert(name + ' 님의 이메일 형식이 올바르지 않습니다.');
                    return;
                }
                if (email !== originalEmail) {
                    try {
                        const res = await fetch(contextPath + '/qh/member/emailCheck?email=' + encodeURIComponent(email));
                        const text = await res.text();
                        if (text === 'true') {
                            alert(name + ' 님의 이메일은 이미 사용 중입니다.');
                            return;
                        }
                    } catch (err) {
                        alert('이메일 중복 확인 중 오류가 발생했습니다.');
                        return;
                    }
                }
                if (phoneNumber && !regPhone.test(phoneNumber)) {
                    alert(name + ' 님의 전화번호 형식이 올바르지 않습니다. (10~11자리 숫자)');
                    return;
                }

                // 검증 통과한 데이터만 리스트에 추가
                memberList.push({
                    authorityCode,
                    name,
                    email,
                    phoneNumber,
                    address: $tr.find('input[name$=".address"]').val().trim(),
                    id,
                    memberCode,
                    password
                });
            }

            // 최종 확인
            if (!confirm('입력하신 정보로 수정하시겠습니까?')) return;

            try {
                const res = await fetch(contextPath + '/qh/member/update', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'  // JSON 보내겠다고 명시
                    },
                    body: JSON.stringify({ memberList: memberList })  // JSON 배열로 보내기
                });

                if (res.ok) {
                    alert('수정 완료되었습니다.');
                    $('#memberEditModal').modal('hide');
                    location.reload();
                } else {
                    alert('수정 중 오류가 발생했습니다.');
                }
            } catch (err) {
                console.error(err);
                alert('서버와 연결에 실패했습니다.');
            }
        });

        //valid시 에러시 모달 원복
    window.addEventListener('DOMContentLoaded', function () {
        <c:if test="${not empty errorMessage}">
        alert('${fn:replace(fn:escapeXml(errorMessage), "'", "\\'")}');
        </c:if>

        <c:if test="${not empty memberList}">
        const modal = new bootstrap.Modal(document.getElementById('memberEditModal'));
        modal.show();

        </c:if>

        <c:if test="${not empty errorMessage and empty memberList}">
        const modal = new bootstrap.Modal(document.getElementById('memberAddModal'));
        modal.show();
        </c:if>
    });

    // 삭제 버튼 클릭 시
    $('#btnMemberDelete_clone').on('click', function (e) {
        const selectedData = [];

        $('#datatable tbody input.row-checkbox:checked').each(function () {
            const $tr = $(this).closest('tr');
            const rowData = {
                id: $tr.find('td').eq(6).text().trim(),
                name: $tr.find('td').eq(2).text().trim(),
                memberCode: $tr.find('td').eq(1).text().trim() // 예: 첫 번째 열에 권한
            };
            console.log('삭제 대상:', rowData);
            selectedData.push(rowData);
        });

        if (selectedData.length == 0) {
            alert('삭제할 항목을 선택하세요.');
            return;
        }

        // 회원 목록을 <ul> 안에 추가
        const $list = $('#deleteMemberList');
        $list.empty(); // 기존 내용 비우고

        selectedData.forEach((item) => {
            const li = `
      <li class="list-group-item d-flex justify-content-between align-items-center">
        <span>` + item.name + ` (` + item.id + `)</span>
        <span class="badge bg-secondary">` + item.memberCode + `</span>
      </li>
    `;
            $list.append(li);
        });

            $('#confirmDelete').off('click').on('click', function (e) {
                const $form = $('#memberDeleteForm');

        // 혹시 이전에 추가된 hidden input이 있으면 제거
        $form.find('input[name="memberCodeList"]').remove();

                // 🔥 새로운 hidden input 추가
                selectedData.forEach((item) => {
                    $form.append(`
                <input type="hidden" name="memberCodeList" value="`+item.memberCode+`">
            `);
                });

                const result = confirm('선택하신 회원을 삭제 하시겠습니까?');
                if (result) {
                    console.log('삭제');
                    $form.submit();
                } else {
                    console.log('삭제 취소');
                }
            });

            // 모달 열기
            $('#memberDeleteModal').modal('show');
        });

    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>


</script>
</body>
</html>