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
                <div class="col-lg-6">
                    <div class="card-style mb-30">
                        <div class="title d-flex flex-wrap justify-content-between">
                            <div class="left">
                                <h6 class="text-medium mb-10">창고별 입고/출고</h6>
                                <h3 class="text-bold">진행율(%)</h3>
                            </div>
                            <div class="right">
                                <div class="select-style-1">
                                    <div class="select-position select-sm">
                                        <!-- 창고 드롭다운 -->
                                        <select id="warehouseCategory">
                                            <c:forEach var="warehouse" items="${warehouseList}">
                                                <option value="${warehouse}">${warehouse}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <!-- end select -->
                            </div>
                        </div>
                        <!-- End Title -->
                        <div class="chart">
                            <canvas id="inboundChart-1" style="width: 100%; height: 420px;"></canvas>
                        </div>
                        <!-- End Chart -->
                    </div>
                </div>
                <!-- End Col -->
                <div class="col-lg-6">
                    <div class="card-style mb-30 w-100">
                        <div class="title d-flex flex-wrap align-items-center justify-content-between">
                            <div class="left">
                                <h6 class="text-medium mb-30">발주 요청량/ 총 재고량 </h6>
                            </div>
                        </div>
                        <!-- End Title -->
                        <div class="chart">
                            <canvas id="Chart5" style="width: 100%; height: 420px;"></canvas>
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
<script src="<c:url value='/resources/js/moment.min.js'/>"></script>
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

    fetch('<c:url value="/qh/order-vs-inventory"/>')
        .then(response => response.json())
        .then(data => {
            const productName = data.map(item => item.productName);
            const orderRequest = data.map(item => item.totalOrderRequest);
            const inventory = data.map(item => item.totalInventory);

            const ctx5 = document.getElementById("Chart5").getContext("2d");
            new Chart(ctx5, {
                type: 'bar',
                data: {
                    labels: productName,
                    datasets: [
                        {
                            label: 'orderRequest',
                            data: orderRequest,
                            backgroundColor: '#fbd4ab',
                            borderRadius: 30,
                            barThickness: 10   ,
                            maxBarThickness: 8,
                        },
                        {
                            label: 'inventory',
                            data: inventory,
                            backgroundColor: '#ff9d32',
                            borderRadius: 30,
                            barThickness: 10,
                            maxBarThickness: 8,
                        }
                    ]
                },
                options: {
                    indexAxis: 'y',
                    responsive: true,
                    maintainAspectRatio: false,
                    layout: {
                        padding: {
                            top: 15,
                            right: 15,
                            bottom: 15,
                            left: 0,
                        },
                    },
                    plugins: {
                        legend: {
                            display: false
                        },
                        title: {
                            display: false
                        },
                        tooltip: {
                            callbacks: {
                                titleColor: function (context) { return "#f58636"; },
                                label: function (context) {
                                    let label = context.dataset.label || "";
                                    if (label) { label += ": "; }
                                    label += context.parsed.x; // 가로 막대 x축 값
                                    return label;
                                },
                            },
                            backgroundColor: "#fbd4ab",
                            titleAlign: "center",
                            bodyAlign: "center",
                            titleFont: {
                                size: 12,
                                weight: "bold",
                                color: "#0e0e0e",
                            },
                            bodyFont: {
                                size: 16,
                                weight: "bold",
                                color: "#171717",
                            },
                            displayColors: false,
                            padding: { x: 30, y: 10 },
                        }
                    },
                    scales: {
                        y: {
                            grid: {
                                display: false,
                                drawTicks: false,
                                drawBorder: false,
                            },
                            ticks: {
                                padding: 10,
                                font: { size: 17 },
                            },
                            barPercentage: 0.6 ,
                        },
                        x: {
                            grid: {
                                display: false,
                                drawBorder: false,
                                color: "rgba(143, 146, 161, .1)",
                                drawTicks: false,
                            },
                            ticks: {
                                max: 900,
                                padding: 20,
                                stepSize: 50,    // ★ 추가 : 50단위로 끊기
                            }
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error('Chart5 데이터 불러오기 실패:', error);
        });

    var $clone = $('#myCustomFilters').clone(true);
    // 복제 후 삽입 시, ID 제거 필수!
    $clone.find('#warehouseCategory').attr('id', 'warehouseCategory_clone');

    $('div.myFilterArea').html($clone.html());


    // 5. 필터링 로직 정의
    $.fn.dataTable.ext.search.push(function(settings, data) {
        const selectedWarehouse = $('#warehouseCategory_clone').val();

        const warehouseName = data[1];

        // 1) 창고 필터
        if (selectedWarehouse && selectedWarehouse !== warehouseName) {
            return false;
        }

        // 조건 만족 시 표시
        return true;
    });
    // 6. 필터 초기화 버튼
    $('body').on('click', '#resetFilterBtn', function () {
        $('#warehouseCategory_clone').val('')
        table.draw();
    });


    //도넛차트
    function drawWarehouseChart(canvasId, label1, value1, label2, value2) {
        const ctx = document.getElementById(canvasId).getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: [label1, label2],
                datasets: [{
                    data: [value1, 100 - value1],  // 예: 완료%와 나머지
                    backgroundColor: ['#ff9d32', '#f3f3f3'],
                    borderRadius: 30,
                    cutout: '70%',
                    radius: '80%',
                },
                    {
                        data: [value2, 100 - value2],  // 출고용
                        backgroundColor: ['#fbd4ab', '#f3f3f3'],
                        borderRadius: 30,
                        cutout: '50%',   // 하나는 살짝 안쪽
                        radius: '60%',
                    }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    title: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            titleColor: function (context) { return "#f58636"; },
                            label: function (context) {
                                let label = context.dataset.label || "";
                                if (label) { label += ": "; }
                                label += context.parsed.x; // 가로 막대 x축 값
                                return label;
                            },
                        },
                        backgroundColor: "#fbd4ab",
                        titleAlign: "center",
                        bodyAlign: "center",
                        titleFont: {
                            size: 12,
                            weight: "bold",
                            color: "#0e0e0e",
                        },
                        bodyFont: {
                            size: 16,
                            weight: "bold",
                            color: "#171717",
                        },
                        displayColors: false,
                        padding: { x: 30, y: 10 },
                    }
                }
            }
        });
    }
    drawWarehouseChart('inboundChart-1', '입고', 85, '출고', 70);

</script>
</body>
</html>


