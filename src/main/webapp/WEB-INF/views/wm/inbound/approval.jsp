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
    <%@include file="/WEB-INF/views/includes/header/wmHeader.jsp"%>
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
                            <h2>입고관리</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ========== title-wrapper end ========== -->

            <!-- Start col -->
            <div class="col-lg">
                <!-- Start card -->
                <div class="card-style mb-30">
                    <h6 class="mb-10">입고 목록</h6>
                    <p class="text-sm mb-20">

                        <!-- 원하는 필터(중분류, 소분류) 설정 -->
                    <div id="myCustomFilters" style="display: none;">

                        <div class="d-flex flex-wrap gap-2">
                            <!-- 중분류 -->
                            <div >
                                <div class="select-style-1">
                                    <div class="select-position">
                                        <select id="InboundCategories">
                                            <option value="">입고 상태</option>
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
                                <!-- <col style="width: 20%; background-color: null;" /> -->
                                <!-- <col style="width: 10%; background-color: null;" /> -->
                            </colgroup>

                            <thead>
                            <tr>
                                <th>입고코드</th>
                                <th>입고일</th>
                                <th>입고상태</th>
                                <th>창고코드</th>
                                <th>승인|수정|취소</th> <!-- 수정/삭제 열 -->
                            </tr>
                            </thead>

                            <tbody>
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- 승인 모달 -->
        <!-- 입고 승인 상세 보기 모달 -->
        <div class="modal fade" id="inboundDetailModal" tabindex="-1" aria-labelledby="inboundDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg"> <!-- 크기 조정 가능: modal-sm, modal-lg 등 -->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="inboundDetailModalLabel">입고 상세 내역</h5>
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
                            <tbody id="inboundDetailTableBody">
                            <!-- JavaScript로 채워짐 -->
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer d-flex justify-content-between align-items-center">
                        <!-- 왼쪽: 입고 날짜 -->
                        <div class="form-group mb-0">
                            <label for="inboundDate" class="mr-2 mb-0">입고 날짜:</label>
                            <input type="date" class="form-control form-control-sm d-inline-block" id="inboundDate" style="width: auto;" />
                        </div>

                        <!-- 오른쪽: 버튼 묶음 -->
                        <!-- <div>
                          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                          <button type="button" class="btn btn-primary">입고 요청 완료</button>
                        </div> -->

                        <div>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                            <button type="button" class="main-btn primary-btn btn-primary btn-sm">입고 요청 완료</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 입고 요청 수정 모달 -->
        <div class="modal fade" id="inboundEditModal" tabindex="-1" aria-labelledby="inboundEditModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document"> <!-- modal-lg: 큰 창 -->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">입고 요청 수정</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                        </button>
                    </div>
                    <div class="modal-body">
                        <p>수량과 입고 날짜를 선택하고 입고수정정 완료 버튼을 클릭하세요.</p>
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
                            <button type="button" class="main-btn primary-btn btn-primary btn-sm">입고 수정 완료</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>


        <!-- 입고 삭제 모달 ! -->
        <div class="modal fade" id="inboundDeleteModal" tabindex="-1" aria-labelledby="inboundDeleteModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg"> <!-- 크기 조정 가능: modal-sm, modal-lg 등 -->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="inboundDetailModalLabel">입고 상세 내역</h5>
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
                            <tbody id="inboundDetailTableBody">
                            <!-- JavaScript로 채워짐 -->
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
                            <button type="button" class="main-btn primary-btn btn-primary btn-sm">삭제</button>
                        </div>
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
    $(document).ready(function() {
        // 1. 더미 데이터 정의 (소재지)
        const dummyInboundCategories = [
            { "id": "입고요청", "name": "입고요청" },
            { "id": "입고승인", "name": "입고승인" },
            { "id": "입고완료", "name": "입고완료" },

        ];

        // 2. 원본 필터 영역에 소재지 옵션 채우기
        var $midSelect = $('#myCustomFilters #InboundCategories');
        $.each(dummyInboundCategories, function(index, item) {
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
            ajax: function(data, callback, settings) {
                const dummyData = [
                    {
                        "inboundCode": "IN1",
                        "inboundDate": "2025-04-13",
                        "inboundStatus": "입고요청",
                        "warehouseCode": "GG1",
                    },
                    {
                        "inboundCode": "IN2",
                        "inboundDate": "2025-04-14",
                        "inboundStatus": "입고승인",
                        "warehouseCode": "GG1",

                    },
                    {
                        "inboundCode": "IN3",
                        "inboundDate": "2025-04-15",
                        "inboundStatus": "입고완료",
                        "warehouseCode" : "DG1",

                    },
                    {
                        "inboundCode": "IN1",
                        "inboundDate": "2025-04-13",
                        "inboundStatus": "입고요청",
                        "warehouseCode": "GG1",
                    },
                    {
                        "inboundCode": "IN1",
                        "inboundDate": "2025-04-13",
                        "inboundStatus": "입고요청",
                        "warehouseCode": "GG1",
                    },
                    {
                        "inboundCode": "IN1",
                        "inboundDate": "2025-04-13",
                        "inboundStatus": "입고요청",
                        "warehouseCode": "GG1",
                    },
                    {
                        "inboundCode": "IN1",
                        "inboundDate": "2025-04-13",
                        "inboundStatus": "입고요청",
                        "warehouseCode": "GG1",
                    },
                ];
                Promise.resolve().then(() => {
                    callback({ data: dummyData });
                });
            },
            columns: [
                { data: 'inboundCode', title: '입고코드' },
                { data: 'inboundDate', title: '입고일' },
                { data: 'inboundStatus', title: '입고상태' },
                { data: 'warehouseCode', title: '창고코드' },
                { // Edit/Delete 버튼
                    data: null,
                    orderable: false,
                    searchable: false,
                    render: function(data, type, row, meta) {
                        return `
                <div class="btu-group-2">
                  <button class="btn btn-approve text-success" title="입고 승인" data-inbound-code="INBOUND123">
                    <i class="lni lni-checkmark-circle"></i>
                  </button>
                  <button class="btn btn-edit text-primary-2">
                    <i class="lni lni-pencil"></i>
                  </button>
                  <button class="btn btn-delete text-danger">
                    <i class="lni lni-trash-can"></i>
                  </button>
                </div>
              `;
                    },
                    title: '승인&nbsp&nbsp|&nbsp&nbsp수정&nbsp&nbsp|&nbsp&nbsp취소'
                }
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
            initComplete: function(settings, json) {
                fixLengthDropdownStyle();
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

        // 6. 사용자 정의 필터 영역에 원본 필터를 복제하여 주입
        var $clone = $('#myCustomFilters').clone(true);
        // 복제 후 삽입 시, ID 제거 필수!
        $clone.find('#InboundCategories').attr('id', 'InboundCategories_clone');

        $clone.find('#btninboundAdd').attr('id', 'btninboundAdd_clone');
        $clone.find('#btninboundEdit').attr('id', 'btninboundEdit_clone');
        $clone.find('#btninboundDelete').attr('id', 'btninboundDelete_clone');
        $clone.find('#btninboundAdd, #btninboundEdit, #btninboundDelete').remove();
        $('div.myFilterArea').html($clone.html());

        // select 태그 감싸는 구조 적용
        $('.dataTables_length select').each(function() {
            const $select = $(this);
            if (!$select.parent().hasClass('select-position')) {
                $select.wrap('<div class="col-lg-2"><div class="select-style-1"><div class="select-position"></div></div></div>');
            }
        });

        // 6-1. 이벤트 위임 방식으로 변경된 ID에 새롭게 바인딩 (body를 통해 실제 필터에 작동하게!)
        $('body').on('change', '#InboundCategories_clone', function() {
            $('#InboundSubCategories_clone').val('');
            table.draw();
        });

        $('body').on('click', '#resetFilterBtn', function () {
            const table = $('#datatable').DataTable();

            table.search('').columns().search('');

            $('#InboundCategories_clone, #inboundDateInput_clone').val('');

            table.order([[0, 'asc']]);
            table.draw();
        });

        // 7. 필터 이벤트: 드롭다운 변경 시 테이블 필터링
        $('#InboundCategories, #inboundDateInput').on('change keyup', function() {
            table.draw();
        });

        // 7-1. (7번 함수에서 각각이 변경될 때마다) 필터링 함수도 변경된 ID값을 기준으로 수정
        $.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
            const selectedInbound = $('#InboundCategories_clone').val();
            const categoryInbound = data[2]; // 입고상태를 기준으로

            // 일부 포함에도 검색
            if (selectedInbound && !categoryInbound.includes(selectedInbound)) {
                return false;
            }

            return true;
        });

        // 입고상세 목업 데이터
        const inboundDetails = [
            { inboundCode: 'INBOUND123', productName: '오리지널 도넛', quantity: 100 },
            { inboundCode: 'INBOUND123', productName: '초코 도넛', quantity: 50 },
            { inboundCode: 'INBOUND456', productName: '커피', quantity: 30 },
        ];


        // 9. Edit/Delete 버튼 이벤트 (제품명 대신 productName 사용)
        // 등록 버튼 클릭 시
        const dummyManagers = [
            { id: "FM1", name: "박열정" },
            { id: "FM2", name: "조아현" },
            { id: "FM3", name: "백승우" },
            { id: "FM4", name: "윤가영" }
        ];

        function populateManagerDropdown() {
            const $select = $('#registerinboundManager');
            $select.empty().append(`<option value="">점주 선택</option>`); // 기본값 초기화

            dummyManagers.forEach(manager => {
                const label = `${manager.id} | ${manager.name}`;
                $select.append(`<option value="${manager.id}">${label}</option>`);
            });
        }

        // 모달 열릴 때마다 목록 갱신되게 하면 좋아
        $('#inboundAddModal').on('show.bs.modal', function () {
            populateManagerDropdown();
        });

        // 이 부분 전체를 바꿔주세요!
        $('body').on('click', '.btn-approve', function () {
            const inboundCode = this.dataset.inboundCode;

            const filteredDetails = inboundDetails.filter(detail => detail.inboundCode === inboundCode);

            const tbody = document.getElementById('inboundDetailTableBody');
            tbody.innerHTML = '';

            if (filteredDetails.length > 0) {
                filteredDetails.forEach(detail => {
                    const row = `
              <tr>
                <td>${detail.productName}</td>
                <td>${detail.quantity}</td>
              </tr>
            `;
                    tbody.insertAdjacentHTML('beforeend', row);
                });
            } else {
                tbody.innerHTML = '<tr><td colspan="2">데이터가 없습니다.</td></tr>';
            }

            // 모달 띄우기
            const modal = new bootstrap.Modal(document.getElementById('inboundDetailModal'));
            modal.show();
        });



        // 수정 버튼 이벤트
        // 수정 모달용 드롭다운 채우기 함수: 현재 점주(warehouseCode)가 있으면 그 항목이 목록 최상단에 오도록 정렬
        function populateinboundManagerDropdown(currentMemberCode) {
            const $select = $('#modifyinboundManager');
            // 기존 옵션 초기화 및 플레이스홀더 추가
            $select.empty().append('<option value="">점주 선택</option>');

            let sortedManagers;
            if (currentMemberCode) {
                // 현재 점주와 나머지 점주를 분리 (dummyManagers의 id 기준 비교)
                const currentManager = dummyManagers.filter(function(m) {
                    return m.id === currentMemberCode;
                });
                const otherManagers = dummyManagers.filter(function(m) {
                    return m.id !== currentMemberCode;
                });
                // 현재 점주가 가장 먼저 오도록 배열 합치기
                sortedManagers = currentManager.concat(otherManagers);
            } else {
                sortedManagers = dummyManagers;
            }

            sortedManagers.forEach(function(manager) {
                $select.append(`<option value="${manager.id}">${manager.id} | ${manager.name}</option>`);
            });

            // 현재 점주가 있다면 선택 처리
            $select.val(currentMemberCode);
        }

        // 수정 버튼 클릭시
        $('#datatable tbody').on('click', '.btn-edit', function(e) {
            e.preventDefault();
            var table = $('#datatable').DataTable();
            var $row = $(this).closest('tr');
            var rowData = table.row($row).data();

            if (!rowData) {
                alert('데이터를 찾을 수 없습니다.');
                return;
            }

            $('#modifyinboundDate').val(rowData.inboundDate);

            // 행 데이터의 담당자 ID가 담긴 필드는 dummy 데이터에서는 "warehouseCode"로 되어 있으므로,
            // 만약 이름이 아닌 고유 id를 기준으로 한다면, 그 값(예: rowData.warehouseCode)을 넘겨야 합니다.
            populateinboundManagerDropdown(rowData.warehouseCode);

            $('#inboundEditModal').modal('show');
        });

        // 삭제 버튼 이벤트
        $('#datatable tbody').on('click', '.btn-delete', function(e) {
            e.preventDefault();

            var table = $('#datatable').DataTable();
            var $row = $(this).closest('tr');
            var rowData = table.row($row).data();

            if (!rowData) {
                alert('데이터를 찾을 수 없습니다.');
                return;
            }

            // 삭제 모달의 리스트 영역을 비우고, 해당 행의 가맹점 이름을 추가
            $('#deleteinboundList').empty().append(
                '<li class="list-group-item">' + rowData.inboundDate + '</li>'
            );

            // 삭제 모달을 열기
            $('#inboundDeleteModal').modal('show');
        });

    });

    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>

</script>
</body>
</html>