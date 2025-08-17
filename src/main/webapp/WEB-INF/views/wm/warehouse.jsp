

<!-- ======== common-header start =========== -->
<%@ include file="/WEB-INF/views/includes/common/Header.jsp" %>
<!-- ======== common-header end =========== -->

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
                            <h2>창고관리</h2>
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
                        <h6 class="mb-10">재고 목록 : ${warehouseName} ( ${warehouseCode} )</h6>
                        <input type="hidden" id="hiddenWarehouseCode" value="${warehouseCode}">
                        <p class="text-sm mb-20"></p>

                            <!-- 원하는 필터(중분류, 소분류) 설정 -->
                        <div id="myCustomFilters" style="display: none;">

                            <div class="d-flex flex-wrap gap-2">

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
                                <div class="btu-group-1 d-flex gap-2 mb-30">
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm btn-xs" id="btnCheckExpiry">유통기한 점검</button>
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm btn-xs" id="btnSetStockThreshold">적정재고량 설정</button>
                                </div>
                            </div>

                        </div>

                        <div class="table-wrapper table-responsive p-0">


                            <!-- Start table -->
                            <table id="datatable" class="table striped-table w-100" style="width:100%">

                                <!-- colgroup를 통해 열 폭을 강제 지정 -->
                                <colgroup>
                                    <col style="width: 18%;" /> <!-- 재고코드 -->
                                    <col style="width: 10%;" /> <!-- 보관타입 -->
                                    <col style="width: 14%;" /> <!-- 중분류 -->
                                    <col style="width: 14%;" /> <!-- 소분류 -->
                                    <col style="width: 18%;" /> <!-- 제품명 -->
                                    <col style="width: 13%;" /> <!-- 유통기한 -->
                                    <col style="width: 13%;" /> <!-- 재고수량 -->
                                </colgroup>

                                <thead>
                                <tr>
                                    <th>재고코드</th>
                                    <th>보관타입</th>
                                    <th>중분류</th>
                                    <th>소분류</th>
                                    <th>제품명</th>
                                    <th>유통기한</th>
                                    <th>재고수량</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="item" items="${inventoryList}">
                                <tr>
                                    <td>${item.barcode}</td>
                                    <td>${item.storedType}</td>
                                    <td>${item.categoryMid}</td>
                                    <td>${item.categorySub}</td>
                                    <td>${item.productName}</td>
                                    <td>${item.expirationDate}</td>
                                    <!-- 재고수량이 숫자를 기준으로 정렬되도록 수정 -->
                                    <td data-order="${item.quantity}">
                                        <fmt:formatNumber value="${item.quantity}" type="number" groupingUsed="true"/> 개
                                    </td>
                                </tr>
                                </c:forEach>
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 모달 위치 -->

            <!-- 유통기한 점검 모달 -->
            <div class="modal fade" id="expiredItemCheckModal" tabindex="-1" aria-labelledby="expiredItemCheckLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="expiredItemCheckLabel">유통기한 점검</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                        </div>
                        <div class="modal-body" id="expiredItemModalBody">
                            <!-- 메시지 및 버튼이 JS로 삽입됨 -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- 적정재고량 메인 모달 -->
            <div class="modal fade" id="stockThresholdModal" tabindex="-1" aria-labelledby="stockThresholdLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">

                        <!-- 헤더 -->
                        <div class="modal-header">
                            <h5 class="modal-title" id="stockThresholdLabel">적정재고량 설정</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
                        </div>

                        <!-- 바디 -->
                        <div class="modal-body">
                            <p class="text-danger mb-2">※ 적정 재고량을 입력하고 저장하세요.</p>

                            <!-- 버튼 그룹 -->
                            <div class="d-flex justify-content-between mb-2">
                                <!-- 왼쪽 버튼 -->
                                <div>
                                    <button type="button" class="main-btn danger-btn-outline btn-sm" onclick="removeSelectedItems()">선택 삭제</button>
                                </div>

                                <!-- 오른쪽 버튼 -->
                                <div class="d-flex gap-2">
                                    <button type="button" class="main-btn warning-btn-outline btn-sm" onclick="openProductSearchModal()">+ 제품 추가</button>
                                    <button type="button" class="main-btn warning-btn-outline btn-sm" id="btnSuggestMinStock">적정재고량 제안 받기</button>
                                </div>
                            </div>

                            <!-- 테이블 -->
                            <div class="table-responsive">
                                <table class="table text-center align-middle">
                                    <thead class="table-light">
                                    <tr>
                                        <th style="width: 40px;">
                                            <input type="checkbox" class="form-check-input row-checkbox" id="selectAllStockItems">
                                        </th>
                                        <th style="width: 300px;">제품명</th>
                                        <th style="width: 160px;">적정 재고량</th>
                                    </tr>
                                    </thead>
                                    <tbody id="stockThresholdTableBody">
                                    <!-- 동적으로 삽입됨 -->
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- 푸터 -->
                        <div class="modal-footer">
                            <button type="button" class="main-btn gray-btn btn-sm" data-bs-dismiss="modal">취소</button>
                            <button type="button" class="main-btn primary-btn btn-sm" onclick="submitStockThreshold()">저장</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 적정재고량 서브 모달 -->
            <div class="modal fade" id="productSearchModal" tabindex="-1" aria-labelledby="productSearchLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">제품 검색</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group mb-2">
                                <input type="text" class="form-control" id="productSearchInput" placeholder="제품명을 입력하세요">
                                <button class="main-btn warning-btn-outline btn-sm btn-hover" type="button" id="productSearchBtn">검색</button>
                            </div>
                            <ul class="list-group" id="productSearchResultList">
                                <!-- 검색 결과 -->
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </section>
    <!-- ========== section end ========== -->

    <!-- ========== common-footer start =========== -->
    <%@ include file="/WEB-INF/views/includes/common/Footer.jsp" %>
    <!-- ========== common-footer end =========== -->
</main>
<!-- ======== main-wrapper end =========== -->

<!-- ========== Javascript start =========== -->
<%@ include file="/WEB-INF/views/includes/common/Javascript.jsp" %>
<!-- ========== Javascript end =========== -->

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

            const categoryMid = data[2];   // "중분류" 칼럼
            const categorySub = data[3];   // "소분류" 칼럼

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

        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////

        // 1. 유통기한 점검 버튼 클릭
        $(document).on('click', '#btnCheckExpiry', function () {
            fetch('/wm/warehouse/expired/check')
                .then(res => {
                    if (!res.ok) throw new Error("서버 오류");
                    return res.json();
                })
                .then(data => {
                    openExpiredItemModal(data); // data: expired 재고 목록
                })
                .catch(err => {
                    alert('유통기한 점검 중 오류 발생');
                    console.error(err);
                });
        });

        function openExpiredItemModal(items) {
            const body = document.getElementById('expiredItemModalBody');
            const count = items.length;

            console.log("넘긴 데이터:", items);
            console.log("갯수:", items.length);

            body.innerHTML = count > 0
                ? '<p>유통기한이 지난 재고가 ' + count + '건 있습니다. 일괄 폐기하시겠습니까?</p>'
                + `<div class="d-flex justify-content-end gap-2 mt-3">
                <button class="main-btn warning-btn-outline btn-sm" data-bs-dismiss="modal">아니오</button>
                <button class="main-btn primary-btn btn-sm" onclick="handleDiscardExpired()">예</button>
             </div>`
                        : `<p>유통기한이 지난 재고가 없습니다.</p>
             <div class="text-end mt-3">
                <button class="main-btn primary-btn btn-sm" data-bs-dismiss="modal">확인</button>
             </div>`;

            new bootstrap.Modal(document.getElementById('expiredItemCheckModal')).show();
        }

        window.handleDiscardExpired = function () {
            fetch('/wm/warehouse/expired/discard', {
                method: 'POST'
            })
                .then(res => {
                    if (res.ok) {
                        alert('일괄 폐기 완료');
                        bootstrap.Modal.getInstance(document.getElementById('expiredItemCheckModal')).hide();
                        location.reload(); // 전체 페이지 새로고침 또는 테이블만 리로딩 가능
                    } else {
                        alert('폐기 실패');
                    }
                })
                .catch(err => {
                    alert('폐기 요청 중 오류 발생');
                    console.error(err);
                });
        };

        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////

        // 2. 적정재고량 설정 모달 열기
        $(document).on('click', '#btnSetStockThreshold', function () {
            // 1) 서버에서 적정재고량 불러오기
            fetch(`/wm/warehouse/threshold/list`)
                .then(res => {
                    console.log(res);
                    if (!res.ok) throw new Error('서버 오류');
                    return res.json();
                })
                .then(items => {
                    $('#stockThresholdTableBody').empty();

                    // 2) 데이터가 없을 경우 안내 메시지
                    if (items.length === 0) {
                        $('#stockThresholdTableBody').html(`
                    <tr class="text-center text-muted">
                        <td colspan="3">적정재고량이 등록된 제품이 없습니다.</td>
                    </tr>
                `);
                    } else {
                        // 3) 테이블에 행 추가
                        items.forEach(item => appendStockRow(item.productCode, item.productName, item.minStock));
                    }

                    // 4) 모달 열기 및 전체 체크박스 해제
                    $('#selectAllStockItems').prop('checked', false);
                    $('#stockThresholdModal').modal('show');
                })
                .catch(err => {
                    alert('적정재고량 조회 중 오류 발생');
                    console.error(err);
                });
        });

        // 행 추가 함수
        function appendStockRow(code, name, threshold) {
            if (isDuplicate(code)) return;

            // ✅ 기존 "없음 메시지" 제거
            $('#stockThresholdTableBody tr.text-muted').remove();

            const row =
                '<tr data-code="' + code + '">' +
                '  <td><input type="checkbox" class="form-check-input row-checkbox"></td>' +
                '  <td>' +
                '    <input type="hidden" name="stockItems[][productCode]" value="' + code + '" class="product-code-input"/>' +
                '    <span class="form-control form-control-sm text-muted bg-light">' + name + '</span>' +
                '  </td>' +
                '  <td>' +
                '    <div class="input-group">' +
                '      <input type="number" class="form-control form-control-sm required-field threshold-input" ' +
                '             name="stockItems[][threshold]" value="' + (threshold || '') + '" min="0" step="100">' +
                '      <span class="input-group-text form-control-sm px-2 py-0" style="height: 30px; line-height: 1.2; font-size: 0.875rem;">개</span>' +
                '    </div>' +
                '  </td>' +
                '</tr>';

            $('#stockThresholdTableBody').append(row);
        }

        // 모달 표에 이미 값이 있으면 threshold만 갱신, 없으면 추가
        function appendOrUpdateStockRow(code, name, suggested) {
            const $row = $('#stockThresholdTableBody tr[data-code="' + code + '"]');
            if ($row.length) {
                $row.find('input[name*="threshold"]').val(suggested);
            } else {
                appendStockRow(code, name, suggested);
            }
        }

        // 선택된 항목 삭제
        window.removeSelectedItems = function () {
            const checked = $('#stockThresholdTableBody .row-checkbox:checked');

            if (checked.length === 0) {
                alert('삭제할 항목을 선택하세요.');
                return;
            }

            if (!confirm('선택한 항목을 삭제하시겠습니까?')) {
                return;
            }

            checked.closest('tr').remove();

            // ✅ 남은 항목 체크
            const remaining = $('#stockThresholdTableBody tr').length;

            if (remaining === 0) {
                // 전체 선택 체크박스 해제
                $('#selectAllStockItems').prop('checked', false);

                // "항목 없음" 메시지 표시
                $('#stockThresholdTableBody').html(`
            <tr class="text-center text-muted">
                <td colspan="3">적정재고량이 등록된 제품이 없습니다.</td>
            </tr>
        `);
            }
        };

        // 저장 버튼
        window.submitStockThreshold = function () {
            const warehouseCode = $('#hiddenWarehouseCode').val();

            const result = [];
            let isValid = true;

            $('#stockThresholdTableBody tr').each(function () {
                const code = $(this).data('code');
                const name = $(this).find('td:nth-child(2) span').text().trim();
                const thresholdStr = $(this).find('input[name*="threshold"]').val();
                const threshold = parseInt(thresholdStr);

                if (!code || thresholdStr === '' || isNaN(threshold) || threshold < 1) {
                    isValid = false;
                    return false;
                }

                result.push({
                    productName: name,
                    productCode: code,
                    minStock: threshold,
                    warehouseCode: warehouseCode });
            });

            // 전체 삭제 상황 → warehouseCode만 포함해 전송
            if (result.length === 0) {
                result.push({
                    warehouseCode: warehouseCode
                });
            }

            // 실제 저장 요청
            fetch('/wm/warehouse/threshold/save', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(result),
                credentials: 'include'
            })
                .then(res => {
                    if (res.ok) {
                        alert('저장 성공');
                        $('#stockThresholdModal').modal('hide');
                    } else {
                        alert('저장 실패');
                    }
                })
                .catch(err => {
                    alert('요청 중 오류 발생');
                    console.error(err);
                });
        };

        // 중복 체크
        function isDuplicate(code) {
            return $('.product-code-input').toArray().some(el => $(el).val() === code);
        }

        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////

        // 3. 제품 검색 모달 열기
        window.openProductSearchModal = function () {
            $('#productSearchModal').modal('show');

            // 1. 검색 입력 초기화
            $('#productSearchInput').val('');

            // 2. 검색 결과 목록 초기화
            $('#productSearchResultList').empty();
        };

        // 포커스 이동(Optional)
        $('#productSearchModal').on('shown.bs.modal', function () {
            $('#productSearchInput').focus();
        });

        // 검색 입력창에서 Enter 키 누르면 검색 실행
        $(document).on('keydown', '#productSearchInput', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault(); // form submit 방지
                $('#productSearchBtn').click(); // 검색 버튼 클릭 트리거
            }
        });

        // 검색 후 목록 출력
        $(document).on('click', '#productSearchBtn', function () {
            const keyword = $('#productSearchInput').val().trim();
            const resultList = $('#productSearchResultList');
            resultList.empty();

            if (!keyword) {
                resultList.append('<li class="list-group-item text-muted">검색어를 입력하세요</li>');
                return;
            }

            fetch('/wm/warehouse/threshold/search?keyword=' + encodeURIComponent(keyword))
                .then(res => {
                    if (!res.ok) throw new Error("서버 응답 실패");
                    return res.json();
                })
                .then(products => {
                    if (!products.length) {
                        resultList.append('<li class="list-group-item text-muted">검색 결과 없음</li>');
                        return;
                    }

                    products.forEach(prod => {
                        const item =
                            '<li class="list-group-item d-flex justify-content-between align-items-center">' +
                            '<span>' + prod.productName + '</span>' +
                            '<button class="main-btn primary-btn btn-sm btn-select-product" ' +
                            'data-code="' + prod.productCode + '" data-name="' + prod.productName + '">' +
                            '추가' +
                            '</button>' +
                            '</li>';
                        resultList.append(item);
                    });
                })
                .catch(err => {
                    console.error('❌ fetch 실패:', err);
                    resultList.append('<li class="list-group-item text-danger">검색 중 오류 발생</li>');
                });
        });

        // 선택 버튼 클릭시 메인 모달에 추가
        $(document).on('click', '.btn-select-product', function () {
            const code = $(this).data('code');
            const name = $(this).data('name');

            if (isDuplicate(code)) {
                alert('이미 추가된 상품입니다.');
                return;
            }

            $('#productSearchModal').modal('hide');
            appendStockRow(code, name);
        });

        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////

        // 적정재고량 제안 받기 버튼 클릭
        $(document).on('click', '#btnSuggestMinStock', function () {
            const $btn = $(this);
            const warehouseCode = $('#hiddenWarehouseCode').val();

            // 리드타임/서비스레벨/묶음단위(임시 기본값) — 필요시 서버/설정값으로 치환
            const L = 4;         // 리드타임(일)
            const z = 1.65;      // 서비스레벨 95%
            const packSize = 1;  // 묶음 단위 없으면 1

            const params = new URLSearchParams({
                warehouseCode: warehouseCode ?? '',
                L: String(L),
                z: String(z),
                packSize: String(packSize),
            });

            const url = '/wm/warehouse/threshold/suggest?' + params.toString();

            // 로딩 표시
            const prevHTML = $btn.html();
            $btn.prop('disabled', true).html('계산 중...');

            fetch(url)
                .then(res => {
                    if (!res.ok) throw new Error('서버 오류');
                    return res.json();
                })
                .then(list => {
                    // 기대 응답: [{ productCode, productName, suggestedMinStock }, ...]
                    if (!Array.isArray(list) || list.length === 0) {
                        alert('제안할 적정재고량이 없습니다.');
                        return;
                    }

                    // "항목 없음" 안내행 제거
                    $('#stockThresholdTableBody tr.text-muted').remove();

                    list.forEach(item => {
                        appendOrUpdateStockRow(item.productCode, item.productName, item.suggestedMinStock);
                    });

                    alert('제안값을 테이블에 반영했습니다.');
                })
                .catch(err => {
                    alert('적정재고량 제안 중 오류 발생');
                    console.error(err);
                })
                .finally(() => {
                    $btn.prop('disabled', false).html(prevHTML);
                });
        });
    });

    // 체크박스 전체 선택/해제 (제목행)
    $(document).on('change', '#selectAllStockItems', function () {
        const checked = $(this).is(':checked');
        $('#stockThresholdTableBody .row-checkbox').prop('checked', checked);
    });

    // 체크박스 전체 선택/해제 (내용행)
    $(document).on('change', '#stockThresholdTableBody .row-checkbox', function () {
        const all = $('#stockThresholdTableBody .row-checkbox').length;
        const checked = $('#stockThresholdTableBody .row-checkbox:checked').length;

        $('#selectAllStockItems').prop('checked', all === checked);
    });


    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>

</script>
</body>
</html>
