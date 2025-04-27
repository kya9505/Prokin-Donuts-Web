

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

    <!-- ========== common-footer start =========== -->
    <%@ include file="/WEB-INF/views/includes/common/Footer.jsp" %>
    <!-- ========== common-footer end =========== -->
</main>
<!-- ======== main-wrapper end =========== -->

<!-- ========== Javascript start =========== -->
<%@ include file="/WEB-INF/views/includes/common/Javascript.jsp" %>
<!-- ========== Javascript end =========== -->

<script>



    // ======== chart one start (스타일은 예전 그대로)
    const ctx1 = document.getElementById("Chart1").getContext("2d");
    const chart1 = new Chart(ctx1, {
        type: "line",
        data: {
            labels: ["도넛", "티", "텀블러"],  // ✅ 더미 데이터: 제품 이름
            datasets: [
                {
                    label: "재고 수량", // ✅ label은 '재고 수량'으로
                    backgroundColor: "transparent",
                    borderColor:  "#FF9D32",
                    data: [100, 50, 30],  // ✅ 더미 데이터: 수량
                    pointBackgroundColor: "transparent",
                    pointHoverBackgroundColor: "#365CF5",
                    pointBorderColor: "transparent",
                    pointHoverBorderColor: "#fff",
                    pointHoverBorderWidth: 5,
                    borderWidth: 5,
                    pointRadius: 8,
                    pointHoverRadius: 8,
                    cubicInterpolationMode: "monotone", // ✅ 부드러운 곡선 그대로
                },
            ],
        },
        options: {
            plugins: {
                tooltip: {
                    callbacks: {
                        labelColor: function (context) {
                            return {
                                backgroundColor: "#ffffff",
                                color: "#171717"
                            };
                        },
                    },
                    intersect: false,
                    backgroundColor: "#f9f9f9",
                    title: {
                        fontFamily: "Plus Jakarta Sans",
                        color: "#8F92A1",
                        fontSize: 12,
                    },
                    body: {
                        fontFamily: "Plus Jakarta Sans",
                        color: "#171717",
                        fontStyle: "bold",
                        fontSize: 16,
                    },
                    multiKeyBackground: "transparent",
                    displayColors: false,
                    padding: {
                        x: 30,
                        y: 10,
                    },
                    bodyAlign: "center",
                    titleAlign: "center",
                    titleColor: "#8F92A1",
                    bodyColor: "#171717",
                    bodyFont: {
                        family: "Plus Jakarta Sans",
                        size: "16",
                        weight: "bold",
                    },
                },
                legend: {
                    display: false,
                },
            },
            responsive: true,
            maintainAspectRatio: false,
            title: {
                display: false,
            },
            scales: {
                y: {
                    grid: {
                        display: false,
                        drawTicks: false,
                        drawBorder: false,
                    },
                    ticks: {
                        padding: 35,
                        max: 120,  // ✅ 최대치 수정 (예: 재고 100 넘는 경우 대비)
                        min: 0,
                    },
                },
                x: {
                    grid: {
                        drawBorder: false,
                        color: "rgba(143, 146, 161, .1)",
                        zeroLineColor: "rgba(143, 146, 161, .1)",
                    },
                    ticks: {
                        padding: 20,
                    },
                },
            },
        },
    });
    // ======== chart one end




    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>


//    // =========== chart one start
//    const ctx1 = document.getElementById("Chart1").getContext("2d");
//    const chart1 = new Chart(ctx1, {
//        type: "line",
//        data: {
//            labels: [
//                "Jan",
//                "Fab",
//                "Mar",
//                "Apr",
//                "May",
//                "Jun",
//                "Jul",
//                "Aug",
//                "Sep",
//                "Oct",
//                "Nov",
//                "Dec",
//            ],
//            datasets: [
//                {
//                    label: "",
//                    backgroundColor: "transparent",
//                    borderColor:  "#FF9D32",
//                    data: [
//                        600, 800, 750, 880, 940, 880, 900, 770, 920, 890, 976, 1100,
//                    ],
//                    pointBackgroundColor: "transparent",
//                    pointHoverBackgroundColor: "#365CF5",
//                    pointBorderColor: "transparent",
//                    pointHoverBorderColor: "#fff",
//                    pointHoverBorderWidth: 5,
//                    borderWidth: 5,
//                    pointRadius: 8,
//                    pointHoverRadius: 8,
//                    cubicInterpolationMode: "monotone", // Add this line for curved line
//                },
//            ],
//        },
//        options: {
//            plugins: {
//                tooltip: {
//                    callbacks: {
//                        labelColor: function (context) {
//                            return {
//                                backgroundColor: "#ffffff",
//                                color: "#171717"
//                            };
//                        },
//                    },
//                    intersect: false,
//                    backgroundColor: "#f9f9f9",
//                    title: {
//                        fontFamily: "Plus Jakarta Sans",
//                        color: "#8F92A1",
//                        fontSize: 12,
//                    },
//                    body: {
//                        fontFamily: "Plus Jakarta Sans",
//                        color: "#171717",
//                        fontStyle: "bold",
//                        fontSize: 16,
//                    },
//                    multiKeyBackground: "transparent",
//                    displayColors: false,
//                    padding: {
//                        x: 30,
//                        y: 10,
//                    },
//                    bodyAlign: "center",
//                    titleAlign: "center",
//                    titleColor: "#8F92A1",
//                    bodyColor: "#171717",
//                    bodyFont: {
//                        family: "Plus Jakarta Sans",
//                        size: "16",
//                        weight: "bold",
//                    },
//                },
//                legend: {
//                    display: false,
//                },
//            },
//            responsive: true,
//            maintainAspectRatio: false,
//            title: {
//                display: false,
//            },
//            scales: {
//                y: {
//                    grid: {
//                        display: false,
//                        drawTicks: false,
//                        drawBorder: false,
//                    },
//                    ticks: {
//                        padding: 35,
//                        max: 1200,
//                        min: 500,
//                    },
//                },
//                x: {
//                    grid: {
//                        drawBorder: false,
//                        color: "rgba(143, 146, 161, .1)",
//                        zeroLineColor: "rgba(143, 146, 161, .1)",
//                    },
//                    ticks: {
//                        padding: 20,
//                    },
//                },
//            },
//        },
//    });
//    // =========== chart one end
//
//




//    // =========== chart two start
//    const ctx2 = document.getElementById("Chart2").getContext("2d");
//    const chart2 = new Chart(ctx2, {
//        type: "bar",
//        data: {
//            labels: [
//                "Jan",
//                "Fab",
//                "Mar",
//                "Apr",
//                "May",
//                "Jun",
//                "Jul",
//                "Aug",
//                "Sep",
//                "Oct",
//                "Nov",
//                "Dec",
//            ],
//            datasets: [
//                {
//                    label: "",
//                    backgroundColor: "#FF9D32",
//                    borderRadius: 30,
//                    barThickness: 6,
//                    maxBarThickness: 8,
//                    data: [
//                        600, 700, 1000, 700, 650, 800, 690, 740, 720, 1120, 876, 900,
//                    ],
//                },
//            ],
//        },
//        options: {
//            plugins: {
//                tooltip: {
//                    callbacks: {
//                        titleColor: function (context) {
//                            return "#8F92A1";
//                        },
//                        label: function (context) {
//                            let label = context.dataset.label || "";
//
//                            if (label) {
//                                label += ": ";
//                            }
//                            label += context.parsed.y;
//                            return label;
//                        },
//                    },
//                    backgroundColor: "#F3F6F8",
//                    titleAlign: "center",
//                    bodyAlign: "center",
//                    titleFont: {
//                        size: 12,
//                        weight: "bold",
//                        color: "#8F92A1",
//                    },
//                    bodyFont: {
//                        size: 16,
//                        weight: "bold",
//                        color: "#171717",
//                    },
//                    displayColors: false,
//                    padding: {
//                        x: 30,
//                        y: 10,
//                    },
//                },
//            },
//            legend: {
//                display: false,
//            },
//            legend: {
//                display: false,
//            },
//            layout: {
//                padding: {
//                    top: 15,
//                    right: 15,
//                    bottom: 15,
//                    left: 15,
//                },
//            },
//            responsive: true,
//            maintainAspectRatio: false,
//            scales: {
//                y: {
//                    grid: {
//                        display: false,
//                        drawTicks: false,
//                        drawBorder: false,
//                    },
//                    ticks: {
//                        padding: 35,
//                        max: 1200,
//                        min: 0,
//                    },
//                },
//                x: {
//                    grid: {
//                        display: false,
//                        drawBorder: false,
//                        color: "rgba(143, 146, 161, .1)",
//                        drawTicks: false,
//                        zeroLineColor: "rgba(143, 146, 161, .1)",
//                    },
//                    ticks: {
//                        padding: 20,
//                    },
//                },
//            },
//            plugins: {
//                legend: {
//                    display: false,
//                },
//                title: {
//                    display: false,
//                },
//            },
//        },
//    });
    // =========== chart two end
</script>
</body>
</html>
