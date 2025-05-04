

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
                            <div class="d-flex justify-content-center align-items-center" style="gap: 8px; margin-bottom: 6px;">
                                <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1"
                                        onclick="changeTemp('fridge', -1)">-</button>
                                <h3 id="temp-fridge" class="text-bold mx-2" style="font-size: 20px; width: 50px;">
                                    ${coldTemp}°C
                                </h3>
                                <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1"
                                        onclick="changeTemp('fridge', 1)">+</button>
                                <button class="main-btn primary-btn btn-hover btn-sm px-3 py-1 ms-2"
                                        onclick="confirmTemp('fridge')">결정</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 냉동섹션 -->
                <div class="col-xl-2 col-lg-4">
                    <div class="icon-card mb-30 text-center">
                        <div class="content">
                            <h6 class="mb-10">냉동섹션</h6>
                            <div class="d-flex justify-content-center align-items-center" style="gap: 8px; margin-bottom: 6px;">
                                <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1"
                                        onclick="changeTemp('freezer', -1)">-</button>
                                <h3 id="temp-freezer" class="text-bold mx-2" style="font-size: 20px; width: 50px;">
                                    ${frozenTemp}°C
                                </h3>
                                <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1"
                                        onclick="changeTemp('freezer', 1)">+</button>
                                <button class="main-btn primary-btn btn-hover btn-sm px-3 py-1 ms-2"
                                        onclick="confirmTemp('freezer')">결정</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 상온섹션 -->
                <div class="col-xl-2 col-lg-4">
                    <div class="icon-card mb-30 text-center">
                        <div class="content">
                            <h6 class="mb-10">상온섹션</h6>
                            <div class="d-flex justify-content-center align-items-center" style="gap: 8px; margin-bottom: 6px;">
                                <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1"
                                        onclick="changeTemp('room', -1)">-</button>
                                <h3 id="temp-room" class="text-bold mx-2" style="font-size: 20px; width: 50px;">
                                    ${roomTemp}°C
                                </h3>
                                <button class="main-btn warning-btn-outline btn-hover btn-sm px-2 py-1"
                                        onclick="changeTemp('room', 1)">+</button>
                                <button class="main-btn primary-btn btn-hover btn-sm px-3 py-1 ms-2"
                                        onclick="confirmTemp('room')">결정</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div> <!-- ← 이 부분이 빠져 있었음 -->
                <input type="hidden" id="warehouseCode" value="${warehouseCode}" />

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
                                            <option value="year">Year</option>
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
                            <canvas id="Chart1" style="width: 100%; height: 400px; margin-left: 0px;"></canvas>
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
                                <h3 class="text-bold">
                                    총 자산가치 :
                                    <fmt:formatNumber value="${totalInventoryPrice}" type="number" groupingUsed="true"/> 원
                                </h3>
                            </div>
                            <div class="right">
                                <div class="select-style-1">
                                    <div class="select-position select-sm">
                                        <select id="filterType" class="light-bg" style="width: 200px;">
                                            <option value="category" selected>Category</option>
                                            <option value="section">Section</option>
                                        </select>
                                    </div>
                                </div>
                                <!-- end select -->
                            </div>
                        </div>
                        <!-- End Title -->
                        <div class="chart">
                            <canvas id="Chart2" style="width: 100%; height: 400px; margin-left: -20px;"></canvas>
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
    <div id="inboundMonthLabelsData" style="display:none;">
        <c:forEach var="item" items="${inboundByMonth}" varStatus="status">
            ${item.period}월<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    </div>

    <!-- ====== 입고 카운트 ====== -->
    <div id="inboundMonthCountsData" style="display:none;">
        <c:forEach var="item" items="${inboundByMonth}" varStatus="status">
            ${item.count}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    </div>

    <!-- ====== 출고 라벨 ====== -->
    <div id="orderMonthLabelsData" style="display:none;">
        <c:forEach var="item" items="${orderByMonth}" varStatus="status">
            ${item.period}월<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    </div>

    <!-- ====== 출고 카운트 ====== -->
    <div id="orderMonthCountsData" style="display:none;">
        <c:forEach var="item" items="${orderByMonth}" varStatus="status">
            ${item.count}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    </div>

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

    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>

    var warehouseCode = document.getElementById('warehouseCode').value;
    let isSubmitting = false;

    function changeTemp(section, delta) {
        console.log('[changeTemp] section =', section, 'delta =', delta);

        var tempElement = document.getElementById('temp-' + section);
        var currentTemp = parseInt(tempElement.textContent.trim().replace('°C',''), 10);
        var newTemp = currentTemp + delta;

        // 상수 방식 범위 체크
        if (section === 'fridge') {
            if (newTemp < 0 || newTemp > 10) {
                alert('냉장 온도는 ' + 0 + '°C ~ ' + 10 + '°C 사이여야 합니다.');
                return;
            }
        }
        else if (section === 'freezer') {
            if (newTemp < -9999 || newTemp > -18) {
                alert('냉동 온도는 ' + -9999 + '°C ~ ' + -18 + '°C 사이여야 합니다.');
                return;
            }
        }
        else if (section === 'room') {
            if (newTemp < 1 || newTemp > 35) {
                alert('상온 온도는 ' + 1 + '°C ~ ' + 35 + '°C 사이여야 합니다.');
                return;
            }
        }

        tempElement.textContent = '' + newTemp + '°C';
    }

    function confirmTemp(section) {
        if (isSubmitting) {
            console.log('[confirmTemp] 중복 요청 방지');
            return;
        }
        isSubmitting = true;

        setTimeout(function() {
            var tempElement = document.getElementById('temp-' + section);
            var finalTemp = parseInt(tempElement.textContent.trim().replace('°C',''), 10);

            // 최종값 상수 방식 체크
            if (section === 'fridge') {
                if (finalTemp < 0 || finalTemp > 10) {
                    alert('최종 냉장 온도가 허용 범위를 벗어났습니다: ' + 0 + '°C ~ ' + 10 + '°C');
                    isSubmitting = false;
                    return;
                }
            }
            else if (section === 'freezer') {
                if (finalTemp < -9999 || finalTemp > -18) {
                    alert('최종 냉동 온도가 허용 범위를 벗어났습니다: ' + -9999 + '°C ~ ' + -18 + '°C');
                    isSubmitting = false;
                    return;
                }
            }
            else if (section === 'room') {
                if (finalTemp < 1 || finalTemp > 35) {
                    alert('최종 상온 온도가 허용 범위를 벗어났습니다: ' + 1 + '°C ~ ' + 35 + '°C');
                    isSubmitting = false;
                    return;
                }
            }

            // storedType 결정
            var storedType = '';
            if (section === 'fridge')      storedType = '냉장';
            else if (section === 'freezer') storedType = '냉동';
            else                            storedType = '상온';

            var url = '/wm/Dashboard/temperature/edit'
                + '?warehouseCode=' + encodeURIComponent(warehouseCode)
                + '&storedType='   + encodeURIComponent(storedType)
                + '&temperature='  + encodeURIComponent(finalTemp);

            console.log('[confirmTemp] section =', section,
                'storedType =', storedType,
                'finalTemp =', finalTemp);
            console.log('[confirmTemp] Fetch URL →', url);

            fetch(url, { method: 'GET' })
                .then(function(res) {
                    isSubmitting = false;
                    if (!res.ok) throw new Error('status ' + res.status);
                    return res.text();
                })
                .then(function(text) {
                    if (text === 'ok') {
                        alert('[' + storedType + '] 온도가 ' + finalTemp + '°C로 저장되었습니다!');
                    } else {
                        alert('온도 저장 실패: ' + text);
                    }
                })
                .catch(function(err) {
                    isSubmitting = false;
                    console.error('[confirmTemp] 에러 →', err);
                    alert('서버 오류 발생: ' + err.message);
                });
        }, 600);
    }
</script>

<script>
    // === 1) 숨겨둔 DIV에서 “월별” 데이터 읽어두기 ===
    var rawInboundLabels = document.getElementById('inboundMonthLabelsData').textContent
        .split(',').map(s => s.trim());

    rawInboundLabels = rawInboundLabels.map(s => {
        const monthNum = parseInt(s.split('-')[1], 10);
        return monthNum + '월';
    });

    var rawInboundCounts = document.getElementById('inboundMonthCountsData').textContent
        .split(',').map(s => Number(s.trim()));

    var rawOrderLabels = document.getElementById('orderMonthLabelsData').textContent
        .split(',').map(s => s.trim());

    rawOrderLabels = rawOrderLabels.map(s => {
        const monthNum = parseInt(s.split('-')[1], 10);
        return monthNum + '월';
    });

    var rawOrderCounts = document.getElementById('orderMonthCountsData').textContent
        .split(',').map(s => Number(s.trim()));

    // "1월" ~ "12월" 라벨 고정
    var monthlyLabels = Array.from({ length: 12 }, function(_, i) {
        return (i + 1) + '월';
    });


    console.log('rawInboundLabels:', rawInboundLabels);
    console.log('monthlyLabels:', monthlyLabels);

    // 라벨 → 값 매핑
    var inboundMap = {};
    rawInboundLabels.forEach(function(l, i){
        inboundMap[l] = rawInboundCounts[i];
    });
    var orderMap = {};
    rawOrderLabels.forEach(function(l, i){
        orderMap[l] = rawOrderCounts[i];
    });

    // 값 없으면 0 처리
    var monthlyInbound = monthlyLabels.map(function(m){
        return inboundMap[m] != null ? inboundMap[m] : 0;
    });
    var monthlyOrder = monthlyLabels.map(function(m){
        return orderMap[m] != null ? orderMap[m] : 0;
    });

    var ctx1 = document.getElementById('Chart1').getContext('2d');
    var gradientInbound = ctx1.createLinearGradient(0, 0, 0, 400);
    gradientInbound.addColorStop(0, 'rgba(255, 157, 50, 0.4)');
    gradientInbound.addColorStop(1, 'rgba(255, 157, 50, 0.05)');
    var gradientOrder = ctx1.createLinearGradient(0, 0, 0, 400);
    gradientOrder.addColorStop(0, 'rgba(76, 175, 80, 0.4)');
    gradientOrder.addColorStop(1, 'rgba(76, 175, 80, 0.05)');

    var chart1 = new Chart(ctx1, {
        type: 'line',
        data: {
            labels: monthlyLabels,
            datasets: [
                {
                    label: '출고 완료',
                    data: monthlyOrder,
                    borderColor: '#4CAF50',
                    backgroundColor: gradientOrder,
                    tension: 0.3,
                    pointRadius: 4,
                    pointHoverRadius: 8,
                    fill: true
                },
                {
                    label: '입고 완료',
                    data: monthlyInbound,
                    borderColor: '#FF9D32',
                    backgroundColor: gradientInbound,
                    tension: 0.3,
                    pointRadius: 4,
                    pointHoverRadius: 8,
                    fill: true
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        usePointStyle: true,
                        pointStyle: 'rectRounded',
                        padding: 20,
                        font: { size: 12, weight: 'bold' },
                        color: '#555'
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(ctx) {
                            return ctx.dataset.label + ': ' + ctx.raw.toLocaleString() + '건';
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
                x: { grid: { display: false }, ticks: { padding: 10 } },
                y: {
                    grid: { color: 'rgba(0,0,0,0.05)' },
                    ticks: {
                        beginAtZero: true,
                        padding: 10,
                        callback: function(value) {
                            return value.toLocaleString() + '건';
                        }
                    }
                }
            }
        }
    });

    // “월별/주별” Select 처리 ===
    document.getElementById('chart1PeriodType').addEventListener('change', function(e) {
        var type = e.target.value;  // 'month', 'week', or 'year'
        var code = '' + document.getElementById('warehouseCode').value;

        fetch('/wm/Dashboard/stat/inbound-order'
            + '?warehouseCode=' + code
            + '&periodType=' + type)
            .then(function(res) { return res.json(); })
            .then(function(json) {
                var inStats  = json.inboundStats;
                var outStats = json.orderStats;

                var labelSuffix = '';
                if (type === 'week') labelSuffix = '주';
                else if (type === 'year') labelSuffix = '년';
                else if (type === 'month') labelSuffix = '월';

                var labels = inStats.map(function(o) {
                    const parts = o.period.split('-');
                    if (type === 'month') return parseInt(parts[1], 10) + labelSuffix;  // ex: 05월
                    return o.period + labelSuffix;
                });

                var inCounts = inStats.map(o => o.count);
                var outCounts = outStats.map(o => o.count);

                chart1.data.labels = labels;
                chart1.data.datasets[0].data = outCounts;
                chart1.data.datasets[1].data = inCounts;
                chart1.update();
            })
            .catch(function(err) {
                console.error(type + '별 데이터 로딩 실패:', err);
            });
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
        rawSubcatData.split(',').forEach(function(entry) {
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
    const subcategoryQuantities = subcategories.map(function(sub) {
        return productInventoryBySubcategory[sub].reduce(function(sum, p) {
            return sum + p.quantity;
        }, 0);
    });

    // 6) Chart2: 소분류 바 차트 + 툴팁
    const ctx2 = document.getElementById('Chart2').getContext('2d');
    const chart2 = new Chart(ctx2, {   // ✅ chart2 변수로 저장
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
                        title: function(ctx) {
                            return ctx[0].label;
                        },
                        label: function(ctx) {
                            if (document.getElementById('filterType').value === 'section') {
                                return '  사용률: ' + ctx.raw + '%';
                            } else {
                                const list = productInventoryBySubcategory[ctx.label] || [];
                                return list.length
                                    ? list.map(function(p) {
                                        return '  ' + p.name + ': ' + p.quantity + '개';
                                    })
                                    : ['  (제품 없음)'];
                            }
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

    document.getElementById('filterType')
        .addEventListener('change', function(e){
            const selected = e.target.value;
            const code = '' + warehouseCode;

            if (selected === 'section') {
                // 섹션 사용률 가져오기
                fetch('/wm/Dashboard/inventory/stat?warehouseCode=' + code + '&type=section')
                    .then(function(res){ return res.json(); })
                    .then(function(data){
                        const labels = data.map(function(item){ return item.storedType; });
                        const values = data.map(function(item){ return item.usedRate; });

                        // ✅ chart2 업데이트
                        chart2.data.labels = labels;
                        chart2.data.datasets[0].label = '섹션 사용률';
                        chart2.data.datasets[0].data = values;
                        chart2.data.datasets[0].backgroundColor = '#4CAF50'; // (선택사항) 색상 변경
                        chart2.update();
                    })
                    .catch(function(err){
                        console.error('섹션 사용률 로딩 실패:', err);
                    });
            } else {
                // 카테고리 선택일 때 → 원래 소분류 기준으로 돌아가기
                chart2.data.labels = subcategories;
                chart2.data.datasets[0].label = '재고 수량';
                chart2.data.datasets[0].data = subcategoryQuantities;
                chart2.data.datasets[0].backgroundColor = '#FF9D32'; // 다시 색상 복원
                chart2.update();
            }
        });

</script>

<script>
    window.addEventListener('DOMContentLoaded', function() {
        document.getElementById('chart1PeriodType').dispatchEvent(new Event('change'));
    });
</script>

</body>
</html>
