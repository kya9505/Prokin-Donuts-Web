

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
                            <h3 class="text-bold mb-10">${inboundWaiting}건</h3>
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
                            <h3 class="text-bold mb-10">${orderWaiting}건</h3>
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
                                    <h3 id="temp-fridge" class="text-bold mx-2 " style="font-size: 20px;">${coldTemp}°C</h3>
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
                                    <h3 id="temp-freezer" class="text-bold mx-2 " style="font-size: 20px;">${frozenTemp}°C</h3>
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
                                    <h3 id="temp-room" class="text-bold mx-2" style="font-size: 20px;">${roomTemp}°C</h3>
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
                                <h6 class="text-medium mb-30">입고/출고 현황</h6>
                            </div>
                            <div class="right">
                                <div class="select-style-1">
                                    <div class="select-position select-sm">
                                        <select id="chart1PeriodType" class="light-bg">
                                            <option value="month" selected>Month</option>
                                            <option value="week">Week</option>
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
                                <h3 class="text-bold">총 자산가치 : ${totalInventoryPrice} 원</h3>
                            </div>
                            <div class="right">
                                <div class="select-style-1">
                                    <div class="select-position select-sm">
                                        <select id="filterType" class="light-bg" style="width: 200px;">
                                            <option value="category" selected>Category</option>
                                            <option value="category">Section</option>
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
    <div id="inboundMonthLabelsData" style="display:none;"><c:forEach var="item" items="${inboundByMonth}" varStatus="status"><c:out value="${item.period}월"/><c:if test="${!status.last}">,</c:if></c:forEach></div>
    <!-- ====== 입고 카운트 ====== -->
    <div id="inboundMonthCountsData" style="display:none;"><c:forEach var="item" items="${inboundByMonth}" varStatus="status">${item.count}<c:if test="${!status.last}">,</c:if></c:forEach></div>

    <!-- ====== 출고 라벨 ====== -->
    <div id="orderMonthLabelsData" style="display:none;"><c:forEach var="item" items="${orderByMonth}" varStatus="status"><c:out value="${item.period}월"/><c:if test="${!status.last}">,</c:if></c:forEach></div>
    <!-- ====== 출고 카운트 ====== -->
    <div id="orderMonthCountsData" style="display:none;"><c:forEach var="item" items="${orderByMonth}" varStatus="status">${item.count}<c:if test="${!status.last}">,</c:if></c:forEach></div>

    <!-- 재고 -->
    <div id="productNamesData" style="display:none;"> <c:forEach var="item" items="${categoryInventory}" varStatus="status"> ${item.name}<c:if test="${!status.last}">,</c:if> </c:forEach> </div>
    <div id="productQuantitiesData" style="display:none;"> <c:forEach var="item" items="${categoryInventory}" varStatus="status"> ${item.quantity}<c:if test="${!status.last}">,</c:if> </c:forEach> </div>
    <!-- ====== 소분류별 제품별 재고목록 데이터 ====== -->
    <div id="subcategoryProductInventoryData" style="display:none;">  <c:forEach var="item" items="${subcategoryProductInventoryList}" varStatus="status">
        ${item.subcategoryName}/${item.productName}/${item.quantity}<c:if test="${!status.last}">,</c:if> </c:forEach>
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
    // 1) 오늘 입/출고 월별 데이터 읽기
    const rawInboundLabels = document
        .getElementById('inboundMonthLabelsData').textContent
        .split(',').map(s => s.trim());
    const rawInboundCounts = document
        .getElementById('inboundMonthCountsData').textContent
        .split(',').map(s => Number(s.trim()));
    const rawOrderLabels = document
        .getElementById('orderMonthLabelsData').textContent
        .split(',').map(s => s.trim());
    const rawOrderCounts = document
        .getElementById('orderMonthCountsData').textContent
        .split(',').map(s => Number(s.trim()));

    // 2) 1~12월 라벨·데이터 준비
    const labels12 = Array.from({ length: 12 }, function(_, i) {
        return (i + 1) + '월';
    });
    const inboundMap = Object.fromEntries(rawInboundLabels.map((l, i) => [l, rawInboundCounts[i]]));
    const orderMap   = Object.fromEntries(rawOrderLabels.map((l, i) => [l, rawOrderCounts[i]]));
    const inboundCounts12 = labels12.map(l => inboundMap[l] || 0);
    const orderCounts12   = labels12.map(l => orderMap[l]   || 0);

    // /////////////////////////////////////////////////////////////////////////////////////////////
    // /////////////////////////////////////////////////////////////////////////////////////////////
    // /////////////////////////////////////////////////////////////////////////////////////////////

    const ctx = document.getElementById('Chart1').getContext('2d');

    // 입고용 그라데이션
    const gradIn = ctx.createLinearGradient(0, 0, 0, 300);
    // gradIn.addColorStop(0, 'rgba(76,175,80,0.4)');
    // gradIn.addColorStop(1, 'rgba(76,175,80,0)');

    // 출고용 그라데이션
    const gradOut = ctx.createLinearGradient(0, 0, 0, 300);
    // gradOut.addColorStop(0, 'rgba(255,157,50,0.4)');
    // gradOut.addColorStop(1, 'rgba(255,157,50,0)');

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels12,  // 1월~12월
            datasets: [
                {
                    label: '출고 완료',
                    data: orderCounts12,
                    fill: true,
                    backgroundColor: gradOut,
                    borderColor: '#FF9D32',
                    tension: 0.4,
                    pointRadius: 0
                },
                {
                    label: '입고 완료',
                    data: inboundCounts12,
                    fill: true,
                    backgroundColor: gradIn,
                    borderColor: '#4CAF50',
                    tension: 0.4,
                    pointRadius: 0
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    mode: 'index',
                    intersect: false,
                    backgroundColor: '#F3F6F8',
                    titleColor: '#171717',
                    bodyColor: '#171717',
                    titleFont: { size: 14, weight: 'bold' },
                    bodyFont: { size: 12 },
                    padding: { top: 10, bottom: 10, left: 20, right: 20 }
                }
            },
            scales: {
                x: {
                    grid: { display: false },
                    ticks: { color: '#888', padding: 10 }
                },
                y: {
                    grid: { drawBorder: false, color: 'rgba(0,0,0,0.05)' },
                    ticks: { display: false }
                }
            },
            layout: { padding: { top: 20, right: 20, bottom: 20, left: 20 } }
        }
    });

    // /////////////////////////////////////////////////////////////////////////////////////////////
    // /////////////////////////////////////////////////////////////////////////////////////////////
    // /////////////////////////////////////////////////////////////////////////////////////////////

    // 4) 숨긴 DIV에서 소분류‒제품‒수량 데이터 읽기
    const rawSubcatData = document
        .getElementById('subcategoryProductInventoryData')
        .textContent.trim();

    const productInventoryBySubcategory = {};
    if (rawSubcatData) {
        rawSubcatData.split(',').forEach(entry => {
            const [sub, prod, qty] = entry.trim().split('/');
            const subTrim  = sub.trim();
            const prodTrim = prod.trim();
            const qtyNum   = parseInt(qty.trim(), 10);
            if (!productInventoryBySubcategory[subTrim]) {
                productInventoryBySubcategory[subTrim] = [];
            }
            productInventoryBySubcategory[subTrim].push({
                name: prodTrim,
                quantity: qtyNum
            });
        });
    }

    // 5) 소분류 리스트와 총수량 계산
    const subcategories = Object.keys(productInventoryBySubcategory);
    const subcategoryQuantities = subcategories.map(sub =>
        productInventoryBySubcategory[sub].reduce((sum, p) => sum + p.quantity, 0)
    );

    // 6) Chart2: 소분류 바 차트 + 툴팁
    const ctx2 = document.getElementById('Chart2').getContext('2d');
    new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: subcategories,
            datasets: [{
                label: '재고 수량',
                data: subcategoryQuantities,
                backgroundColor: '#FF9D32',
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
                        title: ctx => ctx[0].label,     // 소분류명
                        label: ctx => {
                            const list = productInventoryBySubcategory[ctx.label] || [];
                            return list.length ? list.map(function(p) {
                                    return '  ' + p.name + ': ' + p.quantity + '개';
                                }) : ['  (제품 없음)'];
                        }
                    },
                    backgroundColor: '#F3F6F8',
                    titleColor: '#171717',
                    bodyColor: '#171717',
                    titleFont: { size: 14, weight: 'bold' },
                    bodyFont: { size: 10 },
                    displayColors: false,
                    padding: { top: 10, bottom: 10, left: 20, right: 20 },
                    bodyAlign: 'left',
                    titleAlign: 'left'
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
