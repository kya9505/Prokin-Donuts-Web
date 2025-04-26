<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

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
                    </div>
                    <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- ========== title-wrapper end ========== -->
            <div class="row">
                <a href="<c:url value='/qh/member/request'/>" class="col-xl-3 col-lg-4 col-sm-6" style="text-decoration: none; color: inherit;">
                    <div class="icon-card mb-30">
                        <div class="icon purple">
                            <i class="lni lni-user"></i>
                        </div>
                        <div class="content">
                            <h6 class="mb-10">미승인 회원가입 요청</h6>
                            <h3 class="text-bold mb-10" name="CountNewRequest">${CountNewRequest}건</h3>
                        </div>
                    </div>
                </a>

                <a href="<c:url value='/qh/inbound/request'/>" class="col-xl-3 col-lg-4 col-sm-6" style="text-decoration: none; color: inherit;">
                    <div class="icon-card mb-30">
                        <div class="icon success">
                            <i class="lni lni-cart"></i>
                        </div>
                        <div class="content">
                            <h6 class="mb-10">미승인 입고요청</h6>
                            <h3 class="text-bold mb-10" name="CountNewInbound">${CountNewInbound}건</h3>
                        </div>
                    </div>
                </a>

                <a href="<c:url value='/qh/franchise'/>" class="col-xl-3 col-lg-4 col-sm-6" style="text-decoration: none; color: inherit;">
                    <div class="icon-card mb-30">
                        <div class="icon orange">
                            <i class="lni lni-grow"></i>
                        </div>
                        <div class="content">
                            <h6 class="mb-10">총 가맹점 수</h6>
                            <h3 class="text-bold mb-10" name="TotalFranchise">${TotalFranchise}개</h3>
                        </div>
                    </div>
                </a>

                <a href="<c:url value='/qh/warehouse'/>" class="col-xl-3 col-lg-4 col-sm-6" style="text-decoration: none; color: inherit;">
                    <div class="icon-card mb-30">
                        <div class="icon primary">
                            <i class="lni lni-delivery"></i>
                        </div>
                        <div class="content">
                            <h6 class="mb-10">총 창고 수</h6>
                            <h3 class="text-bold mb-10" name="TotalWarehouse">${TotalWarehouse}개</h3>
                        </div>
                    </div>
                </a>
            </div>
            <!-- ========== row end ========== -->

            <!-- End Row -->
            <div class="row">
                <div class="col-lg-7">
                    <div class="card-style mb-30">
                        <div class="title d-flex flex-wrap justify-content-between">
                            <div class="left">
                                <h6 class="text-medium mb-10">Yearly Stats</h6>
                                <h3 class="text-bold">$245,479</h3>
                            </div>
                            <div class="right">
                                <div class="select-style-1">
                                    <div class="select-position select-sm">
                                        <select class="light-bg">
                                            <option value="">Yearly</option>
                                            <option value="">Monthly</option>
                                            <option value="">Weekly</option>
                                        </select>
                                    </div>
                                </div>
                                <!-- end select -->
                            </div>
                        </div>
                        <!-- End Title -->
                        <div class="chart">
                            <canvas id="Chart1" style="width: 100%; height: 400px; margin-left: -35px;"></canvas>
                        </div>
                        <!-- End Chart -->
                    </div>
                </div>
                <!-- End Col -->
                <div class="col-lg-5">
                    <div class="card-style mb-30 w-100">
                        <div class="title d-flex flex-wrap align-items-center justify-content-between">
                            <div class="left">
                                <h6 class="text-medium mb-30">상품별 입고량 / 현재 재고량</h6>
                            </div>
                        </div>
                        <!-- End Title -->
                        <div class="chart">
                            <canvas id="Chart5" style="width: 100%; height: 400px;"></canvas>
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
    //mypageData
    <%@ include file="/WEB-INF/views/includes/mypage/mypageData.jsp" %>

    // ======== jvectormap activation
    var markers = [
        { name: "Egypt", coords: [26.8206, 30.8025] },
        { name: "Russia", coords: [61.524, 105.3188] },
        { name: "Canada", coords: [56.1304, -106.3468] },
        { name: "Greenland", coords: [71.7069, -42.6043] },
        { name: "Brazil", coords: [-14.235, -51.9253] },
    ];


    var jvm = new jsVectorMap({
        map: "world_merc",
        selector: "#map",
        zoomButtons: true,

        regionStyle: {
            initial: {
                fill: "#d1d5db",
            },
        },

        labels: {
            markers: {
                render: (marker) => marker.name,
            },
        },

        markersSelectable: true,
        selectedMarkers: markers.map((marker, index) => {
            var name = marker.name;

            if (name === "Russia" || name === "Brazil") {
                return index;
            }
        }),
        markers: markers,
        markerStyle: {
            initial: { fill: "#4A6CF7" },
            selected: { fill: "#ff5050" },
        },
        markerLabelStyle: {
            initial: {
                fontWeight: 400,
                fontSize: 14,
            },
        },
    });
    // ====== calendar activation
    document.addEventListener("DOMContentLoaded", function () {
        var calendarMiniEl = document.getElementById("calendar-mini");
        var calendarMini = new FullCalendar.Calendar(calendarMiniEl, {
            initialView: "dayGridMonth",
            headerToolbar: {
                end: "today prev,next",
            },
        });
        calendarMini.render();
    });

    // =========== chart one start
    const ctx1 = document.getElementById("Chart1").getContext("2d");
    const chart1 = new Chart(ctx1, {
        type: "line",
        data: {
            labels: [
                "Jan",
                "Fab",
                "Mar",
                "Apr",
                "May",
                "Jun",
                "Jul",
                "Aug",
                "Sep",
                "Oct",
                "Nov",
                "Dec",
            ],
            datasets: [
                {
                    label: "",
                    backgroundColor: "transparent",
                    borderColor: " #FF9D32",
                    data: [
                        600, 800, 750, 880, 940, 880, 900, 770, 920, 890, 976, 1100,
                    ],
                    pointBackgroundColor: "transparent",
                    pointHoverBackgroundColor: "#FF9D32",
                    pointBorderColor: "transparent",
                    pointHoverBorderColor: "#fff",
                    pointHoverBorderWidth: 5,
                    borderWidth: 5,
                    pointRadius: 8,
                    pointHoverRadius: 8,
                    cubicInterpolationMode: "monotone", // Add this line for curved line
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
                        max: 1200,
                        min: 500,
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
    // =========== chart five start (입고량 vs 재고량) ==========
    const ctx5 = document.getElementById("Chart5").getContext("2d");
    const chart5 = new Chart(ctx5, {
        type: "bar",
        data: {
            labels: ["도넛A", "도넛B", "도넛C", "도넛D","도넛D"],
            datasets: [
                {
                    label: "입고량",
                    backgroundColor: "#FF9D32",
                    borderRadius: 30,
                    barThickness: 40,
                    maxBarThickness: 8,
                    data: [120, 90, 150, 100 , 30],
                    backgroundColor: "#fbd4ab"
                },
                {
                    label: "현재 재고량",
                    backgroundColor: "#FF9D32",
                    borderRadius: 40,
                    barThickness: 6,
                    maxBarThickness: 8,
                    data: [30, 70, 50, 20 , 10],
                    backgroundColor: "#ff9d32"
                }
            ]
        },
        options: {
            indexAxis: 'y',  //  가로 막대 설정
            plugins: {
                tooltip: {
                    callbacks: {
                        titleColor: function (context) {
                            return "#8F92A1";
                        },
                        label: function (context) {
                            let label = context.dataset.label || "";

                            if (label) {
                                label += ": ";
                            }
                            label += context.parsed.y;
                            return label;
                        },
                    },
                    backgroundColor: "#F3F6F8",
                    titleAlign: "center",
                    bodyAlign: "center",
                    titleFont: {
                        size: 12,
                        weight: "bold",
                        color: "#8F92A1",
                    },
                    bodyFont: {
                        size: 16,
                        weight: "bold",
                        color: "#171717",
                    },
                    displayColors: false,
                    padding: {
                        x: 30,
                        y: 10,
                    },
                },
            },
            legend: {
                display: false,
            },
            legend: {
                display: false,
            },
            layout: {
                padding: {
                    top: 15,
                    right: 15,
                    bottom: 15,
                    left: 0,
                },
            },
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    grid: {
                        display: false,
                        drawTicks: false,
                        drawBorder: false,
                    },
                    ticks: {
                        padding: 10,
                        font: {
                            size: 17,
                        }
                    },
                },
                x: {
                    grid: {
                        display: false,
                        drawBorder: false,
                        color: "rgba(143, 146, 161, .1)",
                        drawTicks: false,
                        zeroLineColor: "rgba(143, 146, 161, .1)",
                    },
                    ticks: {
                        padding: 20,
                    },
                },
            },
            plugins: {
                legend: {
                    display: false,
                },
                title: {
                    display: false,
                },
            },
        },
    });
    // =========== chart two end

</script>
</body>
</html>
