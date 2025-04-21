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

    <!-- ========== section start ========== -->
    <section class="section">
        <div class="container-fluid">
            <!-- ========== title-wrapper start ========== -->
            <div class="title-wrapper pt-30">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="title">
                            <h2>가맹점 관리</h2>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ========== title-wrapper end ========== -->

            <div class="row">

                <!-- Start col -->
                <div class="col-lg-4">
                    <!-- Start card -->

                    <!-- 지도 API 띄울 공간 -->
                    <div class="card-style mb-30">
                        <h6 class="mb-10">가맹점 위치</h6>
                        <div id="map" style="width:100%;height:715px;"></div>
                    </div>
                </div>

                <!-- Start col -->
                <div class="col-lg-8">
                    <!-- Start card -->
                    <div class="card-style mb-30">
                        <h6 class="mb-10">가맹점 목록</h6>
                        <p class="text-sm mb-20"></p>

                        <!-- 원하는 필터(중분류, 소분류) 설정 -->
                        <div id="myCustomFilters" style="display: none;">

                            <div class="d-flex flex-wrap gap-2">
                                <!-- 중분류 -->
                                <div >
                                    <div class="select-style-1">
                                        <div class="select-position">
                                            <select id="LocationCategories">
                                                <option value="">소재지</option>
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

                                <!-- 오른쪽: 등록/수정/삭제 -->
                                <div class="btu-group-1 ms-auto gap-2 mb-20">
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm btn-xs" id="btnFranchiseAdd">등록</button>
                                </div>
                            </div>

                        </div>

                        <div class="table-wrapper table-responsive p-0">

                            <!-- Start table -->
                            <table id="datatable" class="table striped-table w-100" style="width:100%">

                                <!-- colgroup를 통해 열 폭을 강제 지정 -->
                                <colgroup>
                                    <col style="width: 10%;" />
                                    <col style="width: 18%;" />
                                    <col style="width: 14%;" />
                                    <col style="width: 13%;" />
                                    <col style="width: 10%;" />
                                    <col style="width: 20%;" />
                                </colgroup>

                                <thead>
                                <tr>
                                    <th>가맹점코드</th>
                                    <th>가맹점명</th>
                                    <th>소재지</th>
                                    <th>점주</th>
                                    <th>점주 이메일</th>
                                    <th>수정 | 취소</th> <!-- 수정/삭제 열 -->
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="f" items="${franchiseList}">
                                <tr
                                        data-franchise-code="${f.franchiseCode}"
                                        data-franchise-name="${f.franchiseName}"
                                        data-franchise-addr="${f.franchiseLocation}"
                                        data-status="${f.status}"
                                        data-member-code="${f.memberCode}"
                                        data-member-name="${f.memberName}">
                                    <td>${f.franchiseCode}</td>
                                    <td>${f.franchiseName}</td>
                                    <td>${f.franchiseLocation}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty f.memberName}">
                                                ${f.memberName}
                                            </c:when>
                                            <c:otherwise>
                                                담당자없음
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty f.memberEmail}">
                                                ${f.memberEmail}
                                            </c:when>
                                            <c:otherwise>
                                                없음
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="display: none;">${f.status}</td>
                                    <td style="display: none;">${f.memberCode}</td>
                                    <td>
                                        <div class="btn-group-2">
                                            <button class="btn btn-edit text-primary-2" data-code="${f.memberCode}">
                                                <i class="lni lni-pencil"></i>
                                            </button>
                                            <button class="btn btn-delete text-danger" data-code="${f.memberCode}">
                                                <i class="lni lni-trash-can"></i>
                                            </button>
                                        </div>
                                    </td>
                                    </c:forEach>
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal HTML Start -->

            <!-- 가맹점 등록 모달 (단 하나만 선언) -->
            <div class="modal fade" id="franchiseAddModal" tabindex="-1"
                 aria-labelledby="franchiseAddModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">

                        <!-- 모달 헤더 -->
                        <div class="modal-header">
                            <h3 class="modal-title" id="franchiseAddModalLabel">가맹점 등록</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <!-- 모달 바디 -->
                        <div class="modal-body">
                            <p class="text-danger fw-normal mb-3">(*)는 필수 입력 항목입니다.</p>
                            <form id="franchiseRegisterForm" action="${pageContext.request.contextPath}/qh/franchise/add" method="post">

                                <!-- 가맹점명 (중복확인 버튼 포함) -->
                                <div class="mb-3">
                                    <label class="form-label" for="franchiseName" >가맹점명 (*)</label>
                                    <div class="d-flex gap-2">
                                        <input type="text" class="form-control" id="franchiseName" name="franchiseName" placeholder="가맹점명을 입력하세요" />
                                        <button type="button" class="main-btn primary-btn btn-hover btn-smaller" id="checkDuplicate">중복 확인</button>
                                    </div>
                                </div>

                                <!-- 소재지 (우편번호 및 상세주소) -->
                                <div class="mb-3">
                                    <label class="form-label">소재지 (*)</label>
                                    <div class="d-flex gap-2">
                                        <input type="text" class="form-control" id="zonecode_disp" placeholder="우편번호" disabled />
                                        <button type="button" class="main-btn primary-btn btn-hover btn-smaller" id="search-btn">우편번호</button>
                                    </div>
                                    <input type="text" class="form-control mt-1" id="roadAddress_disp" placeholder="도로명 주소" disabled />
                                    <input type="text" class="form-control mt-1" id="detailAddress_disp" placeholder="상세주소를 입력해주세요." />
                                    <!-- 숨긴 필드 (서버 전송용) -->
                                    <input type="hidden" name="zonecode" id="zonecode_hidden" />
                                    <input type="hidden" name="roadAddress" id="roadAddress_hidden" />
                                    <input type="hidden" name="detailAddress" id="detailAddress_hidden" />
                                    <input type="hidden" name="franchiseLocation" id="fullAddress" />
                                </div>

                                <!-- 점주 드롭박스 -->
                                <div class="mb-3">
                                    <label class="form-label">점주</label>
                                    <select class="form-select" id="member" name="memberCode">
                                        <option value="null">점주 없음</option>
                                        <c:forEach var="m" items="${unassignedFMs}">
                                            <option value="${m.memberCode}">${m.memberCode} | ${m.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- 등록 버튼 -->
                                <div class="text-center w-100 mt-1 mb-3">
                                    <button type="submit" class="main-btn primary-btn btn-hover text-center" id="franchiseRegisterBtn">등록</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 가맹점 수정 모달 -->
            <div class="modal fade" id="franchiseEditModal"
                 tabindex="-1" aria-labelledby="franchiseEditModalLabel" aria-hidden="true" role="dialog" >
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">

                        <!-- 모달 헤더 -->
                        <div class="modal-header">
                            <h3 class="modal-title" id="franchiseEditModalLabel">가맹점 정보 수정</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <!-- 모달 바디 -->
                        <div class="modal-body">
                            <p class="text-danger fw-normal mb-3">(*)는 필수 입력 항목입니다.</p>
                            <form id="modifyFranchiseForm" action="${pageContext.request.contextPath}/qh/franchise/update" method="post">
                                <!-- 수정할 가맹점 구분용 숨은 필드 -->
                                <input type="hidden" id="modifyFranchiseCode" name="franchiseCode">

                                <!-- 가맹점명 (중복 체크 버튼 포함) -->
                                <div class="mb-3">
                                    <label class="form-label" for="modifyFranchiseName">가맹점명 (*)</label>
                                    <div class="d-flex gap-2">
                                        <input type="text" class="form-control" id="modifyFranchiseName" name="franchiseName" placeholder="가맹점명을 입력하세요">
                                        <button type="button" class="main-btn primary-btn btn-hover btn-smaller" id="modifyCheckDuplicateFranchise">중복 확인</button>
                                    </div>
                                </div>

                                <!-- 점주 드롭박스 -->
                                <div class="mb-3">
                                    <label class="form-label" for="modifyFranchiseMember">점주</label>
                                    <select class="form-select" id="modifyFranchiseMember" name="memberCode">
                                        <c:forEach var="m" items="${unassignedFMs}">
                                            <option value="${m.memberCode}">${m.memberCode} | ${m.name}</option>
                                        </c:forEach>
                                        <option value="null">점주 없음</option>
                                    </select>
                                </div>

                                <!-- 수정 버튼 -->
                                <div class="text-end">
                                    <button type="submit" class="main-btn primary-btn btn-hover text-center" id="franchiseModifyBtn">수정</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 삭제 모달 -->
            <div class="modal fade" id="franchiseDeleteModal" tabindex="-1" aria-labelledby="franchiseDeleteModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">

                        <!-- 모달 헤더 -->
                        <div class="modal-header">
                            <h3 class="modal-title" id="franchiseDeleteModalLabel">가맹점 삭제</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <!-- 모달 바디 -->
                        <div class="modal-body">

                            <form id="franchiseDeleteForm" action="${pageContext.request.contextPath}/qh/franchise/delete" method="post">
                                <input type="hidden" name="franchiseCode" id="deleteFranchiseCode" />

                                <!-- JS에서 체크한 행에 따라 채워질 영역 -->
                                <div id="deleteContentOk" style="display:none;"></div>
                                <div id="deleteContentNo" style="display:none;"></div>

                                <div class="d-flex justify-content-end gap-2">
                                    <button type="submit" class="main-btn primary-btn btn-hover text-center" id="confirmDeleteFranchise">삭제</button>
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

<!-- 다음 우편번호 API -->
<script src="<c:url value='//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js'/>"></script>
<!-- 카카오맵 API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a5f2e41113ad6da9ca9746f7bcb47f6&libraries=services"></script>
<script>
    document.addEventListener('DOMContentLoaded', async () => {
        const map = new kakao.maps.Map(document.getElementById('map'), {
            center: new kakao.maps.LatLng(36.5, 127.5), // 대한민국 중심
            level: 7 // 초기에는 살짝 넓게
        });

        // 지도 클릭 → 다음 우편번호 팝업 + 모달 열기
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            geocoder.coord2Address(
                mouseEvent.latLng.getLng(),
                mouseEvent.latLng.getLat(),
                function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        // 1) 도로명주소 추출
                        var roadAddr = result[0].road_address
                            ? result[0].road_address.address_name
                            : result[0].address.address_name;

                        // 2) 다음 우편번호 팝업 호출 (검색 창에 roadAddr 가 바로 채워짐)
                        new daum.Postcode({
                            autoClose: true,
                            oncomplete: function(data) {
                                // 팝업에서 선택한 결과로 필드 채우기
                                $('#zonecode_disp').val(data.zonecode);
                                $('#zonecode_hidden').val(data.zonecode);
                                $('#roadAddress_disp').val(data.roadAddress);
                                $('#roadAddress_hidden').val(data.roadAddress);

                                // 모달 열기 (주소 선택이 완료된 직후)
                                $('#franchiseAddModal').modal('show');

                                // 상세주소 입력 필드만 포커스
                                $('#detailAddress_disp').val('').focus();
                            }
                        }).open({
                            q: roadAddr
                        });
                    }
                }
            );
        });

        // 지도에 확대 축소 컨트롤을 생성한다
        var zoomControl = new kakao.maps.ZoomControl();

        // 지도의 우측에 확대 축소 컨트롤을 추가한다
        map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

        const geocoder = new kakao.maps.services.Geocoder();
        const rows = Array.from(document.querySelectorAll('#datatable tbody tr'));
        const bounds = new kakao.maps.LatLngBounds();

        // 1) 주소별 마커 + 레이블 생성 + bounds 계산
        await Promise.all(rows.map(row => new Promise(resolve => {
            const addr = row.dataset.franchiseAddr;
            const name = row.dataset.franchiseName;

            geocoder.addressSearch(addr, (res, status) => {
                if (status === kakao.maps.services.Status.OK) {
                    const lat = res[0].y;
                    const lng = res[0].x;
                    const pos = new kakao.maps.LatLng(lat, lng);

                    // 마커 & 레이블
                    new kakao.maps.Marker({ map, position: pos });
                    new kakao.maps.CustomOverlay({
                        map,
                        position: pos,
                        content: `<div style="
                              display:inline-block;
                              padding:4px 8px;
                              font-size:12px;
                              white-space:nowrap;
                              text-align:center;
                              background:rgba(255,255,255,0.9);
                              border:1px solid rgba(0,0,0,0.2);
                              border-radius:4px;
                              box-shadow:0 1px 4px rgba(0,0,0,0.2);
                              transform:translateY(-35px);
                            ">` + name + `</div>`,
                        yAnchor: 1
                    });

                    // 다음 클릭을 위한 좌표 저장
                    row.dataset.lat = lat;
                    row.dataset.lng = lng;

                    bounds.extend(pos);
                }
                resolve();
            });
        })));

        // 2) 초기 지도: 전체 마커가 보이게 축소/이동
        map.setBounds(bounds);

        // 3) 클릭 시 확대 후 이동 (순서 매우 중요)
        rows.forEach(row => {
            row.addEventListener('click', () => {
                const lat = row.dataset.lat;
                const lng = row.dataset.lng;

                if (lat && lng) {
                    const pos = new kakao.maps.LatLng(lat, lng);

                    map.setLevel(3); // 먼저 확대
                    setTimeout(() => {
                        map.setCenter(pos); // 그다음 이동
                    }, 100);
                } else {
                    // 비상: geocoding이 아직 안 된 경우
                    geocoder.addressSearch(row.dataset.franchiseAddr, (res, st) => {
                        if (st === kakao.maps.services.Status.OK) {
                            const pos = new kakao.maps.LatLng(res[0].y, res[0].x);
                            map.setLevel(3);
                            setTimeout(() => {
                                map.setCenter(pos);
                            }, 100);

                            row.dataset.lat = res[0].y;
                            row.dataset.lng = res[0].x;
                        }
                    });
                }
            });
        });
    });
</script>

<script>
    $(document).ready(function() {
        // 1. 더미 데이터 정의 (소재지)
        const dummyLocationCategories = [
            { "id": "SL", "name": "서울특별시" },
            { "id": "GG", "name": "경기도" },
            { "id": "IC", "name": "인천광역시" },
            { "id": "GW", "name": "강원특별자치도" },
            { "id": "CB", "name": "충청북도" },
            { "id": "CN", "name": "충청남도" },
            { "id": "JB", "name": "전라북도" },
            { "id": "JN", "name": "전라남도" },
            { "id": "GB", "name": "경상북도" },
            { "id": "GN", "name": "경상남도" },
            { "id": "JJ", "name": "제주특별자치도" },
            { "id": "DJ", "name": "대전광역시" },
            { "id": "DG", "name": "대구광역시" },
            { "id": "GJ", "name": "광주광역시" },
            { "id": "BS", "name": "부산광역시" },
            { "id": "US", "name": "울산광역시" },
            { "id": "SJ", "name": "세종특별자치시" },
            { "id": "ETC", "name": "기타" }
        ];

        // 2. 원본 필터 영역에 소재지 옵션 채우기
        var $midSelect = $('#myCustomFilters #LocationCategories');
        $.each(dummyLocationCategories, function(index, item) {
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
                { targets: [0, 1, 2, 3, 4, 7], className: 'text-center' } // JS 속성으로 가운데 정렬
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
            $('.dataTables_paginate .paginate_button')
                .removeClass()
                .addClass('main-btn deactive-btn-outline square-btn btn-hover mt-1 pt-2 pb-2 pl-15 pr-15');
        });

        // 6. 사용자 정의 필터 영역에 원본 필터를 복제하여 주입
        var $clone = $('#myCustomFilters').clone(true);
        // 복제 후 삽입 시, ID 제거 필수!
        $clone.find('#LocationCategories').attr('id', 'LocationCategories_clone');

        $clone.find('#btnFranchiseAdd').attr('id', 'btnFranchiseAdd_clone');
        $clone.find('#btnFranchiseEdit').attr('id', 'btnFranchiseEdit_clone');
        $clone.find('#btnFranchiseDelete').attr('id', 'btnFranchiseDelete_clone');
        $clone.find('#btnFranchiseAdd, #btnFranchiseEdit, #btnFranchiseDelete').remove();
        $('div.myFilterArea').html($clone.html());

        // select 태그 감싸는 구조 적용
        $('.dataTables_length select').each(function() {
            const $select = $(this);
            if (!$select.parent().hasClass('select-position')) {
                $select.wrap('<div class="col-lg-2"><div class="select-style-1"><div class="select-position"></div></div></div>');
            }
        });

        // 6-1. 이벤트 위임 방식으로 변경된 ID에 새롭게 바인딩 (body를 통해 실제 필터에 작동하게!)
        $('body').on('change', '#LocationCategories_clone', function() {
            $('#LocationSubCategories_clone').val('');
            table.draw();
        });

        $('body').on('click', '#resetFilterBtn', function () {
            const table = $('#datatable').DataTable();

            table.search('').columns().search('');

            $('#LocationCategories_clone, #franchiseNameInput_clone').val('');

            table.order([[0, 'asc']]);
            table.draw();
        });

        // 7. 필터 이벤트: 드롭다운 변경 시 테이블 필터링
        $('#LocationCategories, #franchiseNameInput').on('change keyup', function() {
            table.draw();
        });

        // 7-1. (7번 함수에서 각각이 변경될 때마다) 필터링 함수도 변경된 ID값을 기준으로 수정
        $.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
            const selectedLocation = $('#LocationCategories_clone').val();
            const categoryLocation = data[0]; // 가맹점코드를 기준으로

            // 일부 포함에도 검색
            if (selectedLocation && !categoryLocation.includes(selectedLocation)) {
                return false;
            }

            return true;
        });

        // 9. Edit/Delete 버튼 이벤트 (제품명 대신 productName 사용)
        // 등록 버튼 클릭 시
        // 전역 변수: 가맹점명 중복 체크 상태 (초기값 false)
        var isFranchiseNameChecked = false;

        // 폼 초기화 함수
        function resetRegisterForm() {
            // HTMLFormElement.reset() 으로 기본 input 값(placeholder 외) 모두 초기화
            $('#franchiseRegisterForm')[0].reset();

            // hidden 필드, 플래그, 버튼 상태도 명시적으로 초기화
            $('#zonecode_disp, #roadAddress_disp, #detailAddress_disp').val('');
            $('#zonecode_hidden, #roadAddress_hidden, #detailAddress_hidden, input[name="address"]').val('');
            isFranchiseNameChecked = false;

            $('#search-btn').prop('disabled', false).removeClass('disabled');
        }

        // 모달이 완전히 닫혔을 때
        $('#franchiseAddModal').on('hidden.bs.modal', function() {
            resetRegisterForm();
        });

        // 1. 등록 모달 열기
        $("#btnFranchiseAdd_clone").on("click", function () {
            resetRegisterForm();
            $("#franchiseAddModal").modal("show");
        });

        // 2. 가맹점명 변경 시 중복 체크 초기화
        $("#franchiseName").on("input", function () {
            isFranchiseNameChecked = false;
        });

        // 3. 중복 확인 버튼 (SSR과 연계된 fetch 방식)
        $("#checkDuplicate").on("click", function () {
            const name = $("#franchiseName").val().trim();
            if (!name) {
                alert("가맹점명을 입력하세요.");
                return;
            }
            const reg = /^[A-Za-z0-9가-힣]{1,10}$/;
            if (!reg.test(name)) {
                alert("한글/영어/숫자만 가능하며 최대 10글자입니다.");
                return;
            }

            const contextPath = "${pageContext.request.contextPath}";
            fetch(contextPath + "/qh/franchise/check?franchiseName=" + encodeURIComponent(name))
                .then(function (res) { return res.text(); })  // ← 여기!!
                .then(function (text) {
                    const isDup = (text === 'true');  // 문자열 비교
                    if (isDup) {
                        alert("이미 존재하는 가맹점명입니다.");
                        isFranchiseNameChecked = false;
                    } else {
                        alert("사용 가능한 가맹점명입니다.");
                        isFranchiseNameChecked = true;
                    }
                })
                .catch(function () {
                    alert("중복 확인 중 오류가 발생했습니다.");
                });
        });

        // 4. 다음 주소 API 연동
        $("#search-btn").on("click", function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    $("#zonecode_disp").val(data.zonecode);
                    $("#roadAddress_disp").val(data.roadAddress);
                }
            }).open();
        });

        // 5. 상세 주소 입력 시 숨겨진 필드 업데이트
        $("#detailAddress_disp").on("change", function () {
            $("#detailAddress_hidden").val($(this).val());
        });

        // 6. 폼 제출 전 유효성 검사 및 address 합치기
        $("#franchiseRegisterForm").on("submit", function () {
            const name = $("#franchiseName").val().trim();
            const zonecode = $("#zonecode_disp").val().trim();
            const roadAddress = $("#roadAddress_disp").val().trim();
            const detailAddress = $("#detailAddress_disp").val().trim();
            const regName = /^[A-Za-z0-9가-힣]{1,10}$/;
            const regCap = /^[0-9]+$/;
            // 상세주소: 한글, 영어, 숫자, 띄어쓰기, 특수문자 허용
            const regDetail = /^[\uAC00-\uD7A3A-Za-z0-9\s~`!@#$%^&*()\-_=+\[\]{};:'",.<>\/?\\|]*$/;

            if (!name || !zonecode || !roadAddress || !detailAddress) {
                alert("필수 항목을 모두 입력해주세요.");
                return false;
            }

            if (!regName.test(name)) {
                alert("가맹점명은 한글/영어/숫자 조합이며 최대 10글자입니다.");
                return false;
            }

            if (!regDetail.test(detailAddress)) {
                alert("상세주소는 한글, 영어, 숫자, 띄어쓰기 및 특수문자만 입력 가능합니다.");
                return false;
            }

            if (!isFranchiseNameChecked) {
                alert("가맹점명 중복확인을 해주세요.");
                return false;
            }

            // address 하나로 합쳐서 hidden 필드 추가
            const $existing = $("input[name='franchiseLocation']");
            const fullAddress = (roadAddress + " " + detailAddress).replace(/^,/, "").trim();
            if ($existing.length > 0) {
                $existing.val(fullAddress); // 기존 필드 있으면 값만 바꿈
            } else {
                $("<input>").attr({
                    type: "hidden",
                    name: "franchiseLocation",
                    value: fullAddress
                }).appendTo(this);
            }
        });

        let isModifyNameChecked = true;

        // 1. 수정 버튼 클릭 시 - 모달 열기
        $('#datatable tbody').on('click', '.btn-edit', function (e) {
            e.preventDefault();

            const $tr = $(this).closest('tr');
            const rowData = table.row($tr).data();

            const code = rowData[0];        // 가맹점코드
            const name = rowData[1];        // 가맹점명
            const memberCode = rowData[6];  // 숨겨진 td: 담당자코드
            const memberName = rowData[3];  // 담당자이름

            // 모달 input 세팅
            $('#modifyFranchiseCode').val(code);
            $('#modifyFranchiseName').val(name);

            const $selectTag = $('#modifyFranchiseMember');

            // 1. 이전에 추가한 현재 담당자 option 제거
            $selectTag.find('option[data-current="true"]').remove();

            // 2. 현재 값 선택 또는 새로 추가
            const $select = $('#modifyFranchiseMember');
            if ($select.find("option[value='" + memberCode + "']").length > 0) {
                $select.val(memberCode);
            } else {
                if (memberCode) {
                    const label = memberCode + " | " + memberName;
                    $select.prepend(`<option value="` + memberCode + `" selected data-current="true" selected>` + label +` </option>`);
                    $select.val(memberCode);
                } else {
                    // 담당자 없는 경우에는 '담당자 없음'을 선택
                    $select.val("null");
                }
            }

            // 중복확인 상태 초기화
            isModifyNameChecked = true;

            // 모달 열기
            $('#franchiseEditModal').modal('show');
        });

        // 2. 가맹점명 입력 시 중복확인 초기화
        $("#modifyFranchiseName").on("input", function () {
            isModifyNameChecked = false;
        });

        // 3. 중복 확인 버튼 클릭 시
        $("#modifyCheckDuplicateFranchise").on("click", function (e) {
            e.preventDefault(); // 폼 제출 막기

            const name = $("#modifyFranchiseName").val().trim();
            const code = $("#modifyFranchiseCode").val().trim();

            if (!name) {
                alert("가맹점명을 입력하세요.");
                return;
            }

            const reg = /^[A-Za-z0-9가-힣]{1,10}$/;
            if (!reg.test(name)) {
                alert("한글/영어/숫자만 가능하며 최대 10글자입니다.");
                return;
            }

            const contextPath = "${pageContext.request.contextPath}";
            fetch(contextPath + "/qh/franchise/check?franchiseName=" + encodeURIComponent(name) + "&franchiseCode=" + encodeURIComponent(code))
                .then((res) => res.text())
                .then((text) => {
                    const isDup = (text === 'true');
                    if (isDup) {
                        alert("이미 존재하는 가맹점명입니다.");
                        isModifyNameChecked = false;
                    } else {
                        alert("사용 가능한 가맹점명입니다.");
                        isModifyNameChecked = true;
                    }
                })
                .catch(() => {
                    alert("중복 확인 중 오류가 발생했습니다.");
                });
        });

        // 4. 최종 제출 시 유효성검사 + 중복확인 여부 체크
        $("#modifyFranchiseForm").on("submit", function (e) {
            const name = $("#modifyFranchiseName").val().trim();
            const reg = /^[A-Za-z0-9가-힣]{1,10}$/;

            if (!name) {
                alert("가맹점명을 입력하세요.");
                e.preventDefault();
                return;
            }

            if (!reg.test(name)) {
                alert("가맹점명은 한글/영어/숫자 조합이며 최대 10글자입니다.");
                e.preventDefault();
                return;
            }

            if (!isModifyNameChecked) {
                alert("가맹점명 중복확인을 해주세요.");
                e.preventDefault();
                return;
            }
        });

        // 삭제 버튼 클릭 시
        $(document).on('click', '.btn-delete', function(e) {
            e.preventDefault();

            var $tr = $(this).closest('tr');
            var franchiseCode = $tr.data('franchise-code');
            var franchiseName = $tr.data('franchise-name');
            var status        = $tr.data('status') || '';
            var memberCode    = $tr.data('member-code') || '';
            var memberName    = $tr.data('member-name') || '담당자없음';

            // 배지 클래스
            var badgeClass = (status === '삭제가능') ? 'bg-success' : 'bg-secondary';
            var badge = '<span class="badge ' + badgeClass + '">' + status + '</span>';

            // 리스트 아이템 HTML
            var liHTML =
                '<li class="list-group-item d-flex justify-content-between align-items-center">' +
                franchiseName + ' (' +
                (memberCode ? (memberCode + ' | ' + memberName) : '담당자없음') +
                ')' +
                badge +
                '</li>';

            // 모달 form hidden 세팅
            $('#deleteFranchiseCode').val(franchiseCode);

            // 내용 초기화
            $('#deleteContentOk').hide().empty();
            $('#deleteContentNo').hide().empty();

            if (status === '삭제가능') {
                $('#deleteContentOk')
                    .html(
                        '<h5>선택한 가맹점를 정말 삭제하시겠습니까?</h5><br>' +
                        '<ul class="list-group mb-3">' + liHTML + '</ul>'
                    )
                    .show();
                $('#confirmDeleteFranchise').show();
            } else {
                $('#deleteContentNo')
                    .html(
                        '<h5>선택한 가맹점는 진행 중인 업무로 인해 삭제할 수 없습니다.</h5><br>' +
                        '<ul class="list-group mb-3">' + liHTML + '</ul>'
                    )
                    .show();
                $('#confirmDeleteFranchise').hide();
            }

            // 모달 띄우기
            $('#franchiseDeleteModal').modal('show');
        });

        // 삭제 폼 전송
        $('#confirmDeleteFranchise').on('click', function() {
            if ($(this).is(':hidden')) {
                alert('삭제할 수 없는 가맹점입니다.');
                return;
            }
            $('#franchiseDeleteForm').submit();
        });
    });
    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>

</script>
</body>
</html>
