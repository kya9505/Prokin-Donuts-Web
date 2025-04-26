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
                        <p class="text-sm mb-20"></p>

                            <!-- 원하는 필터(중분류, 소분류) 설정 -->
                        <div id="myCustomFilters" style="display: none;">

                            <div class="d-flex flex-wrap gap-2">
                                <!-- 창고 -->
                                <div >
                                    <div class="select-style-1">
                                        <div class="select-position">
                                            <!-- 창고 드롭다운 -->
                                            <select id="warehouseCategory">
                                                <option value="">창고</option>
                                                <c:forEach var="warehouse" items="${warehouseList}">
                                                    <option value="${warehouse}">${warehouse}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>

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

                        <div class="table-wrapper table-responsive p-0">


                            <!-- Start table -->
                            <table id="datatable" class="table striped-table w-100" style="width:100%">

                                <!-- colgroup를 통해 열 폭을 강제 지정 -->
                                <colgroup>
                                    <col style="width: 15%;" />
                                    <col style="width: 15%;" />
                                    <col style="width: 10%;" />
                                    <col style="width: 15%;" />
                                    <col style="width: 15%;" />
                                    <col style="width: 20%;" />
                                    <col style="width: 10%;" />
                                </colgroup>

                                <thead>
                                <tr>
                                    <th>재고코드</th>
                                    <th>창고</th>
                                    <th>보관타입</th>
                                    <th>중분류</th>
                                    <th>소분류</th>
                                    <th>제품명</th>
                                    <th>재고수량</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="item" items="${inventoryList}">
                                    <tr>
                                        <td>${item.inventoryCode}</td>
                                        <td>${item.warehouseName}</td>
                                        <td>${item.storedType}</td>
                                        <td>${item.categoryMid}</td>
                                        <td>${item.categorySub}</td>
                                        <td>${item.productName}</td>
                                        <td><fmt:formatNumber value="${item.quantity}" type="number" groupingUsed="true"/> 개</td>
                                    </tr>
                                </c:forEach>
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
        // 1. DataTables 초기화
        var table = $('#datatable').DataTable({
            autoWidth: false,
            columnDefs: [
                { width: '95px', targets: -1 },  // Actions 열 너비
                { targets: [0, 1, 2, 3, 4, 5, 6], className: 'text-center' } // JS 속성으로 가운데 정렬
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
        $clone.find('#warehouseCategory').attr('id', 'warehouseCategory_clone');
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
        $('#warehouseCategory_clone, #midCategory_clone, #subCategory_clone').on('change', function () {
            table.draw();
        });

        // 5. 필터링 로직 정의
        $.fn.dataTable.ext.search.push(function(settings, data) {
            const selectedWarehouse = $('#warehouseCategory_clone').val();
            const selectedMid = $('#midCategory_clone').val();
            const selectedSub = $('#subCategory_clone').val();

            const warehouseName = data[1];  // "창고" 칼럼
            const categoryMid = data[3];   // "중분류" 칼럼
            const categorySub = data[4];   // "소분류" 칼럼

            // 1) 창고 필터
            if (selectedWarehouse && selectedWarehouse !== warehouseName) {
                return false;
            }
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

        // 6. 필터 초기화 버튼
        $('body').on('click', '#resetFilterBtn', function () {
            $('#warehouseCategory_clone').val('');
            $('#midCategory_clone').val('');
            $('#subCategory_clone').val('').prop('disabled', true);
            table.draw();
        });

        // 7. 입력창 변화에 반응
        $('#productNameInput').on('keyup', function() {
            table.draw();
        });
    });

    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>
</script>
</body>
</html>
