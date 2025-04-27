

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

                    </div>
                    <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- ========== title-wrapper end ========== -->
            <div class="row">
                <!-- 미승인 입고요청 -->
                <div class="col-xl-3 col-lg-6">
                    <div class="icon-card mb-30">
                        <div class="icon purple">
                            <i class="lni lni-package"></i>
                        </div>
                        <div class="content">
                            <h6 class="mb-10">미승인 입고요청</h6>
                            <h3 class="text-bold mb-10">${todayWaitingInboundCount}건</h3>
                        </div>
                    </div>
                </div>

                <!-- 미승인 출고요청 -->
                <div class="col-xl-3 col-lg-6">
                    <div class="icon-card mb-30">
                        <div class="icon success">
                            <i class="lni lni-delivery"></i>
                        </div>
                        <div class="content">
                            <h6 class="mb-10">미승인 출고요청</h6>
                            <h3 class="text-bold mb-10">${todayWaitingOrderCount}건</h3>
                        </div>
                    </div>
                </div>

                <!-- 냉장섹션 -->
                <div class="col-xl-2 col-lg-4">
                    <div class="icon-card mb-30 text-center">
                        <div class="content">
                            <h6 class="mb-10">냉장섹션</h6>
                            <div class="d-flex justify-content-center ml-15">
                                <div class="d-flex align-items-center" style="margin-bottom: 6px;">
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1 " onclick="changeTemp('fridge', -1)">-</button>
                                    <h3 id="temp-fridge" class="text-bold mx-2 " style="font-size: 20px;">7°C</h3>
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1 " onclick="changeTemp('fridge', 1)">+</button>
                                    <button class="main-btn primary-btn btn-hover btn-sm px-3 py-1 ms-2" onclick="confirmTemp('fridge')">결정</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 냉동섹션 -->
                <div class="col-xl-2 col-lg-4">
                    <div class="icon-card mb-30 text-center">
                        <div class="content">
                            <h6 class="mb-10">냉동섹션</h6>
                            <div class="d-flex justify-content-center ml-10">
                                <div class="d-flex align-items-center" style="margin-bottom: 6px;">
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1" onclick="changeTemp('freezer', -1)">-</button>
                                    <h3 id="temp-freezer" class="text-bold mx-2 " style="font-size: 20px;">-21°C</h3>
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1 " onclick="changeTemp('freezer', 1)">+</button>
                                    <button class="main-btn primary-btn btn-hover btn-sm px-3 py-1 ms-2 " onclick="confirmTemp('freezer')">결정</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 상온섹션 -->
                <div class="col-xl-2 col-lg-4">
                    <div class="icon-card mb-30 text-center">
                        <div class="content">
                            <h6 class="mb-10">상온섹션</h6>
                            <div class="d-flex justify-content-center ml-15">
                                <div class="d-flex align-items-center" style="margin-bottom: 6px;">
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1" onclick="changeTemp('room', -1)">-</button>
                                    <h3 id="temp-room" class="text-bold mx-2" style="font-size: 20px;">20°C</h3>
                                    <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1 " onclick="changeTemp('room', 1)">+</button>
                                    <button class="main-btn primary-btn btn-hover btn-sm px-3 py-1 ms-2 " onclick="confirmTemp('room')">결정</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- End Row -->

<%--            -------------------------------------------------------------------------------                --%>

            <div class="row">
                <div class="col-xl-6 col-lg-6">
                    <div class="card-style mb-30">
                        <div class="title d-flex flex-wrap align-items-center justify-content-between">
                            <div class="left">
                                <h6 class="text-medium mb-30">역대 입고/출고 현황</h6>
                            </div>
                            <div class="right">
                                <div class="select-style-1">
                                    <div class="select-position select-sm">
                                        <select class="light-bg">
                                            <option value="">주별 조회</option>
                                            <option value="" selected>월별 조회</option>
                                            <option value="">연별 조회</option>
                                        </select>
                                    </div>
                                </div>
                                <!-- end select -->
                            </div>
                        </div>
                        <!-- End Title -->
                        <div class="chart">
                            <canvas id="Chart1" style="width: 100%; height: 400px; margin-left: -45px;"></canvas>
                        </div>
                        <!-- End Chart -->
                    </div>
                </div>


                <!-- End Col -->
                <div class="col-xl-6 col-lg-6">
                    <div class="card-style mb-30">
                        <div class="title d-flex flex-wrap justify-content-between">
                            <div class="left">
                                <h6 class="text-medium mb-10">재고현황</h6>
                                <h3 class="text-bold">총 자산 : ${totalInventoryPrice} 원</h3>
                            </div>
                            <div class="right">
                                <div class="select-style-1">
                                    <div class="select-position select-sm">
                                        <select id="filterType" class="light-bg" style="width: 200px;">
                                            <option value="product" selected>제품별 조회</option>
                                            <option value="category">카테고리별 조회</option>
                                            <option value="category">섹션별 조회</option>
                                        </select>
                                    </div>
                                </div>
                                <!-- end select -->
                            </div>
                        </div>
                        <!-- End Title -->
                        <div class="chart">
                            <canvas id="Chart2" style="width: 100%; height: 400px; margin-left: -35px;"></canvas>
                        </div>
                        <!-- End Chart -->
                    </div>
                </div>
                <!-- End Col -->


            </div>
            <!-- End Row -->
        </div>
        <!-- end container -->
    </section>
    <!-- ========== section end ========== -->

    <!-- ====== 입고 라벨 ====== -->
    <div id="inboundMonthLabelsData" style="display:none;"><c:forEach var="item" items="${inboundMonthData}" varStatus="status"><c:out value="${item.period}월"/><c:if test="${!status.last}">,</c:if></c:forEach></div>
    <!-- ====== 입고 카운트 ====== -->
    <div id="inboundMonthCountsData" style="display:none;"><c:forEach var="item" items="${inboundMonthData}" varStatus="status">${item.count}<c:if test="${!status.last}">,</c:if></c:forEach></div>

    <!-- ====== 출고 라벨 ====== -->
    <div id="orderMonthLabelsData" style="display:none;"><c:forEach var="item" items="${orderMonthData}" varStatus="status"><c:out value="${item.period}월"/><c:if test="${!status.last}">,</c:if></c:forEach></div>
    <!-- ====== 출고 카운트 ====== -->
    <div id="orderMonthCountsData" style="display:none;"><c:forEach var="item" items="${orderMonthData}" varStatus="status">${item.count}<c:if test="${!status.last}">,</c:if></c:forEach></div>

    <!-- 재고 -->
    <div id="productNamesData" style="display:none;">
        <c:forEach var="item" items="${productInventoryList}" varStatus="status">
            ${item.name}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    </div>

    <div id="productQuantitiesData" style="display:none;">
        <c:forEach var="item" items="${productInventoryList}" varStatus="status">
            ${item.quantity}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    </div>

    <!-- ========== common-footer start =========== -->
    <%@ include file="/WEB-INF/views/includes/common/Footer.jsp" %>
    <!-- ========== common-footer end =========== -->
</main>
<!-- ======== main-wrapper end =========== -->

<!-- ========== Javascript start =========== -->
<%@ include file="/WEB-INF/views/includes/common/Javascript.jsp" %>
<!-- ========== Javascript end =========== -->

<script>
    // 1) 숨겨둔 div에서 입고/출고 데이터 가져오기
    const rawInbound = document
        .getElementById('inboundMonthLabelsData')
        .textContent
        .split(',')
        .map(s => s.trim());
    const rawInboundCounts = document
        .getElementById('inboundMonthCountsData')
        .textContent
        .split(',')
        .map(s => Number(s.trim()));

    const rawOrder = document
        .getElementById('orderMonthLabelsData')
        .textContent
        .split(',')
        .map(s => s.trim());
    const rawOrderCounts = document
        .getElementById('orderMonthCountsData')
        .textContent
        .split(',')
        .map(s => Number(s.trim()));

    // ✅ 추가: 재고 데이터 가져오기
    const productNames = document.getElementById('productNamesData')
        .textContent.split(',').map(s => s.trim());
    const productQuantities = document.getElementById('productQuantitiesData')
        .textContent.split(',').map(s => Number(s.trim()));

    console.log('✅ 제품명:', productNames);
    console.log('✅ 수량:', productQuantities);

    // 2) 1월~12월 라벨 생성
    const labels12 = [];
    for (let m = 1; m <= 12; m++) {
        labels12.push(m + '월');
    }

    // 3) Map 변환
    const inboundMap = rawInbound.reduce((m, label, idx) => {
        m[label] = rawInboundCounts[idx];
        return m;
    }, {});
    const orderMap = rawOrder.reduce((m, label, idx) => {
        m[label] = rawOrderCounts[idx];
        return m;
    }, {});

    // 4) 12개월 데이터 채우기
    const inboundCounts12 = labels12.map(label => inboundMap[label] || 0);
    const orderCounts12   = labels12.map(label => orderMap[label]   || 0);

    console.log('✅ labels12       :', labels12);
    console.log('✅ inboundCounts12:', inboundCounts12);
    console.log('✅ orderCounts12  :', orderCounts12);

    // 5) Chart1: 입고/출고 같이 그리기
    const ctx1 = document.getElementById("Chart1").getContext("2d");
    new Chart(ctx1, {
        type: "line",
        data: {
            labels: labels12,
            datasets: [
                {
                    label: "월별 입고 수량",
                    data: inboundCounts12,
                    backgroundColor: "transparent",
                    borderColor: "#FF9D32",
                    borderWidth: 5,
                    pointRadius: 8,
                    pointHoverRadius: 8,
                    cubicInterpolationMode: "monotone",
                    pointBackgroundColor: "transparent",
                    pointHoverBackgroundColor: "#FF9D32"
                },
                {
                    label: "월별 출고 수량",
                    data: orderCounts12,
                    backgroundColor: "transparent",
                    borderColor: "#4CAF50",
                    borderWidth: 5,
                    pointRadius: 8,
                    pointHoverRadius: 8,
                    cubicInterpolationMode: "monotone",
                    pointBackgroundColor: "transparent",
                    pointHoverBackgroundColor: "#4CAF50"
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: true },
                tooltip: { intersect: false, displayColors: true }
            },
            scales: {
                y: { ticks: { beginAtZero: true, padding: 35 }, grid: { display: false } },
                x: { ticks: { padding: 20 }, grid: { drawBorder: false, color: "rgba(143,146,161,.1)" } }
            }
        }
    });


    // ✅ Chart2: 재고현황 (DB기반으로 변경)
    const ctx2 = document.getElementById("Chart2").getContext("2d");
    new Chart(ctx2, {
        type: "bar",
        data: {
            labels: productNames,
            datasets: [{
                label: "재고 수량",
                data: productQuantities,
                backgroundColor: "#FF9D32",
                borderRadius: 30,
                barThickness: 20,
                maxBarThickness: 30
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || "";
                            if (label) label += ": ";
                            label += context.parsed.y;
                            return label;
                        }
                    },
                    backgroundColor: "#F3F6F8",
                    displayColors: false,
                    padding: { x: 30, y: 10 }
                }
            },
            scales: {
                y: { ticks: { beginAtZero: true, padding: 35 }, grid: { display: false } },
                x: { ticks: { padding: 20 }, grid: { display: false } }
            },
            layout: { padding: { top: 15, right: 15, bottom: 15, left: 15 } }
        }
    });
</script>
</body>
</html>
