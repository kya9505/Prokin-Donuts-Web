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
                            <h2>재고관리</h2>
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
                        <h6 class="mb-10">재고 목록</h6>
                        <p class="text-sm mb-20">

                            <!-- 원하는 필터(중분류, 소분류) 설정 -->
                        <div id="myCustomFilters" style="display: none;">

                            <div class="d-flex flex-wrap gap-2">

                                <!-- 중분류 -->
                                <div >
                                    <div class="select-style-1">
                                        <div class="select-position">
                                            <select id="midCategory">
                                                <option value="">중분류</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- 소분류 -->
                                <div >
                                    <div class="select-style-1">
                                        <div class="select-position">
                                            <select id="subCategory">
                                                <option value="">소분류</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- 필터 초기화 -->
                                <div class="mb-20">
                                    <button class="main-btn warning-btn-outline square-btn btn-hover btn-sm btn-xs" id="resetFilterBtn" style="height:auto; min-height:auto;">
                                        필터 초기화
                                    </button>
                                </div>

                                <!-- 오른쪽: 등록/수정/삭제 -->
                                <div class="ms-auto gap-2 mb-20">
                                </div>
                            </div>

                        </div>

                        </p>
                        <div class="table-wrapper table-responsive p-0">


                            <!-- Start table -->
                            <table id="datatable" class="table striped-table w-100" style="width:100%">

                                <!-- colgroup를 통해 열 폭을 강제 지정 -->
                                <colgroup>
                                    <col style="width: 20%; background-color: null;" />
                                    <col style="width: 10%; background-color: null;" />
                                    <col style="width: 10%; background-color: null;" />
                                    <col style="width: 15%; background-color: null;" />
                                    <col style="width: 25%; background-color: null;" />
                                    <col style="width: 10%; background-color: null;" />
                                </colgroup>

                                <thead>
                                <tr>
                                    <th>재고코드</th>
                                    <th>보관타입</th>
                                    <th>중분류</th>
                                    <th>소분류</th>
                                    <th>제품명</th>
                                    <th>재고수량</th>
                                </tr>
                                </thead>

                                <tbody>
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 모달 위치 -->

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
        // 1. 더미 데이터 정의 (중분류, 소분류)
        const dummyMidCategories = [
            { id: "도넛", name: "도넛" },
            { id: "베이글", name: "베이글" },
            { id: "커피", name: "커피" },
            { id: "티", name: "티" },
            { id: "머그컵", name: "머그컵" },
            { id: "텀블러", name: "텀블러" }
        ];
        const dummySubCategories = [
            { id: "프로틴 도넛", name: "프로틴 도넛", midCategory: "도넛" },
            { id: "글루텐 프리 도넛", name: "글루텐 프리 도넛", midCategory: "도넛" },
            { id: "저당 도넛", name: "저당 도넛", midCategory: "도넛" },
            { id: "글루텐프리베이글", name: "글루텐프리베이글", midCategory: "베이글" },
            { id: "디카페인", name: "디카페인", midCategory: "커피" },
            { id: "제로음료", name: "제로음료", midCategory: "티" },
            { id: "프로킨머그컵", name: "프로킨머그컵", midCategory: "머그컵" },
            { id: "프로킨텀블러", name: "프로킨텀블러", midCategory: "텀블러" }
        ];

        // 2. 원본 필터 영역에 중분류, 소분류 옵션 채우기
        var $midSelect = $('#myCustomFilters #midCategory');
        $.each(dummyMidCategories, function(index, item) {
            $midSelect.append($('<option>', {
                value: item.id,
                text: item.name
            }));
        });

        var $subSelect = $('#myCustomFilters #subCategory');
        $.each(dummySubCategories, function(index, item) {
            $subSelect.append($('<option>', {
                value: item.id,
                text: item.name
            }));
        });

        // 3. 소분류 -> 중분류 매핑 객체
        const mapping = {
            "프로틴 도넛": "도넛",
            "글루텐 프리 도넛": "도넛",
            "저당 도넛": "도넛",
            "글루텐프리베이글": "베이글",
            "디카페인": "커피",
            "제로음료": "티",
            "프로킨머그컵": "머그컵",
            "프로킨텀블러": "텀블러"
        };

        // 4. 이벤트 바인딩: 중분류 선택 시 소분류 리셋, 소분류 선택 시 자동 중분류 선택
        $('#myCustomFilters #midCategory').on('change', function() {
            $('#myCustomFilters #subCategory').val('');
        });
        $('#myCustomFilters #subCategory').on('change', function() {
            var selectedSub = $(this).val();
            if (selectedSub) {
                var correspondingMid = mapping[selectedSub];
                if (correspondingMid) {
                    $('#myCustomFilters #midCategory').val(correspondingMid);
                }
            }
        });

        // 5. DataTable 초기화 (dom 옵션에 사용자 정의 영역 포함)
        var table = $('#datatable').DataTable({
            autoWidth: false,
            columnDefs: [
                { width: '95px', targets: -1 },  // Actions 열 너비
                { targets: [0, 1, 2, 3, 4, 5], className: 'text-center' } // JS 속성으로 가운데 정렬
            ],
            ajax: function(data, callback, settings) {
                const dummyData = [
                    {
                        "inventoryCode": "GG1-BGL1-20250612",
                        "warehouseName": "남양주DT센터",
                        "productName": "글루텐프리베이글",
                        "quantity": 589,
                        "storedType": "냉동",
                        "categoryMid": "베이글",
                        "categorySub": "글루텐프리베이글"
                    },
                    {
                        "inventoryCode": "GG1-CDC1-20250523",
                        "warehouseName": "남양주DT센터",
                        "productName": "디카페인커피",
                        "quantity": 902,
                        "storedType": "상온",
                        "categoryMid": "커피",
                        "categorySub": "디카페인"
                    },
                    {
                        "inventoryCode": "GG1-DGL1-20250626",
                        "warehouseName": "남양주DT센터",
                        "productName": "글루텐프리초코도넛",
                        "quantity": 169,
                        "storedType": "냉장",
                        "categoryMid": "도넛",
                        "categorySub": "글루텐 프리 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DGL2-20250504",
                        "warehouseName": "남양주DT센터",
                        "productName": "글루텐프리딸기도넛",
                        "quantity": 284,
                        "storedType": "냉장",
                        "categoryMid": "도넛",
                        "categorySub": "글루텐 프리 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DGL2-20250605",
                        "warehouseName": "남양주DT센터",
                        "productName": "글루텐프리딸기도넛",
                        "quantity": 299,
                        "storedType": "냉장",
                        "categoryMid": "도넛",
                        "categorySub": "글루텐 프리 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DGL4-20250617",
                        "warehouseName": "남양주DT센터",
                        "productName": "냉동동글루텐프리초코도넛",
                        "quantity": 134,
                        "storedType": "냉동",
                        "categoryMid": "도넛",
                        "categorySub": "글루텐 프리 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DGL4-20250818",
                        "warehouseName": "남양주DT센터",
                        "productName": "냉동동글루텐프리초코도넛",
                        "quantity": 780,
                        "storedType": "냉동",
                        "categoryMid": "도넛",
                        "categorySub": "글루텐 프리 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DGL5-20250815",
                        "warehouseName": "남양주DT센터",
                        "productName": "냉동글루텐프리딸기도넛",
                        "quantity": 116,
                        "storedType": "냉동",
                        "categoryMid": "도넛",
                        "categorySub": "글루텐 프리 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DGL6-20250928",
                        "warehouseName": "남양주DT센터",
                        "productName": "냉동글루텐프리글레이즈드도넛",
                        "quantity": 797,
                        "storedType": "냉동",
                        "categoryMid": "도넛",
                        "categorySub": "글루텐 프리 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DLW1-20250822",
                        "warehouseName": "남양주DT센터",
                        "productName": "저당초코도넛",
                        "quantity": 199,
                        "storedType": "냉장",
                        "categoryMid": "도넛",
                        "categorySub": "저당 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DLW2-20250629",
                        "warehouseName": "남양주DT센터",
                        "productName": "저당딸기도넛",
                        "quantity": 266,
                        "storedType": "냉장",
                        "categoryMid": "도넛",
                        "categorySub": "저당 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DLW2-20250821",
                        "warehouseName": "남양주DT센터",
                        "productName": "저당딸기도넛",
                        "quantity": 528,
                        "storedType": "냉장",
                        "categoryMid": "도넛",
                        "categorySub": "저당 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DLW4-20250721",
                        "warehouseName": "남양주DT센터",
                        "productName": "냉동저당초코도넛",
                        "quantity": 608,
                        "storedType": "냉동",
                        "categoryMid": "도넛",
                        "categorySub": "저당 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DPN1-20250521",
                        "warehouseName": "남양주DT센터",
                        "productName": "프로틴초코도넛",
                        "quantity": 959,
                        "storedType": "냉장",
                        "categoryMid": "도넛",
                        "categorySub": "프로틴 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DPN2-20250905",
                        "warehouseName": "남양주DT센터",
                        "productName": "프로틴딸기도넛",
                        "quantity": 780,
                        "storedType": "냉장",
                        "categoryMid": "도넛",
                        "categorySub": "프로틴 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DPN2-20250907",
                        "warehouseName": "남양주DT센터",
                        "productName": "프로틴딸기도넛",
                        "quantity": 133,
                        "storedType": "냉장",
                        "categoryMid": "도넛",
                        "categorySub": "프로틴 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DPN3-20250624",
                        "warehouseName": "남양주DT센터",
                        "productName": "프로틴글레이즈드도넛",
                        "quantity": 406,
                        "storedType": "냉장",
                        "categoryMid": "도넛",
                        "categorySub": "프로틴 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DPN6-20250528",
                        "warehouseName": "남양주DT센터",
                        "productName": "냉동프로틴글레이즈드도넛",
                        "quantity": 305,
                        "storedType": "냉동",
                        "categoryMid": "도넛",
                        "categorySub": "프로틴 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DPN6-20250912",
                        "warehouseName": "남양주DT센터",
                        "productName": "냉동프로틴글레이즈드도넛",
                        "quantity": 977,
                        "storedType": "냉동",
                        "categoryMid": "도넛",
                        "categorySub": "프로틴 도넛"
                    },
                    {
                        "inventoryCode": "GG1-DPN6-20250919",
                        "warehouseName": "남양주DT센터",
                        "productName": "냉동프로틴글레이즈드도넛",
                        "quantity": 429,
                        "storedType": "냉동",
                        "categoryMid": "도넛",
                        "categorySub": "프로틴 도넛"
                    },
                    {
                        "inventoryCode": "GG1-MPK1-20250505",
                        "warehouseName": "남양주DT센터",
                        "productName": "프로킨머그컵",
                        "quantity": 623,
                        "storedType": "상온",
                        "categoryMid": "머그컵",
                        "categorySub": "프로킨머그컵"
                    },
                    {
                        "inventoryCode": "GG1-MPK1-20250725",
                        "warehouseName": "남양주DT센터",
                        "productName": "프로킨머그컵",
                        "quantity": 717,
                        "storedType": "상온",
                        "categoryMid": "머그컵",
                        "categorySub": "프로킨머그컵"
                    },
                    {
                        "inventoryCode": "GG1-TPK1-20250616",
                        "warehouseName": "남양주DT센터",
                        "productName": "프로킨텀블러",
                        "quantity": 955,
                        "storedType": "상온",
                        "categoryMid": "텀블러",
                        "categorySub": "프로킨텀블러"
                    },
                    {
                        "inventoryCode": "GG1-TPK1-20250617",
                        "warehouseName": "남양주DT센터",
                        "productName": "프로킨텀블러",
                        "quantity": 595,
                        "storedType": "상온",
                        "categoryMid": "텀블러",
                        "categorySub": "프로킨텀블러"
                    },
                    {
                        "inventoryCode": "GG1-TPK1-20250716",
                        "warehouseName": "남양주DT센터",
                        "productName": "프로킨텀블러",
                        "quantity": 820,
                        "storedType": "상온",
                        "categoryMid": "텀블러",
                        "categorySub": "프로킨텀블러"
                    }
                ];
                Promise.resolve().then(() => {
                    callback({ data: dummyData });
                });
            },
            columns: [
                { data: 'inventoryCode', title: '재고코드' },
                { data: 'storedType', title: '보관타입' },
                { data: 'categoryMid', title: '중분류' },
                { data: 'categorySub', title: '소분류' },
                { data: 'productName', title: '제품명' },
                { data: 'quantity', title: '재고수량' }
            ],
            paging: true,
            pageLength: 10,
            lengthMenu: [[10, 20, 30, -1], ['10개', '20개', '30개', '전체']],
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
        $clone.find('#midCategory').attr('id', 'midCategory_clone');
        $clone.find('#subCategory').attr('id', 'subCategory_clone');

        $('div.myFilterArea').html($clone.html());

        // select 태그 감싸는 구조 적용
        $('.dataTables_length select').each(function() {
            const $select = $(this);
            if (!$select.parent().hasClass('select-position')) {
                $select.wrap('<div class="col-lg-2"><div class="select-style-1"><div class="select-position"></div></div></div>');
            }
        });

        // (2) 중분류 필터가 바뀔 때 소분류를 초기화하고 테이블 다시 draw
        $('body').on('change', '#midCategory_clone', function() {
            $('#subCategory_clone').val('');  // 소분류 리셋
            table.draw();
        });

        // (3) 소분류 필터가 바뀔 때, 소분류 -> 중분류 자동 보정
        $('body').on('change', '#subCategory_clone', function() {
            const selectedSub = $(this).val();
            if (selectedSub) {
                const correspondingMid = mapping[selectedSub];
                if (correspondingMid) {
                    $('#midCategory_clone').val(correspondingMid);
                }
            }
            table.draw();
        });

        // (4) 필터 초기화 버튼
        $('body').on('click', '#resetFilterBtn', function () {
            $('#midCategory_clone').val('');
            $('#subCategory_clone').val('');
            table.draw();
        });

        // 7. 필터 이벤트: 드롭다운 변경 시 테이블 필터링
        $('#midCategory, #subCategory, #productNameInput').on('change keyup', function() {
            table.draw();
        });

        // 7-1. 필터링 함수도 변경된 ID값을 기준으로 수정
        $.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
            const selectedMid = $('#midCategory_clone').val();
            const selectedSub = $('#subCategory_clone').val();

            const categoryMid = data[2];   // "중분류" 칼럼
            const categorySub = data[3];   // "소분류" 칼럼

            // 2) 중분류 필터
            if (selectedMid && selectedMid !== categoryMid) {
                return false;
            }
            // 3) 소분류 필터
            if (selectedSub && selectedSub !== categorySub) {
                return false;
            }

            // 조건 만족 시 표시
            return true;
        });

    });

    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>

</script>
</body>
</html>
