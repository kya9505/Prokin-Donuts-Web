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
                    <div class="card-style mb-30 ">
                        <div class="title d-flex flex-wrap align-items-center justify-content-between">
                            <div class="left">
                                <h6 class="text-medium mb-10">공급 우선순위 제품</h6>
                                <h3 class="text-bold">발주 요청량/총 재고량 (개)</h3>
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
                            label: '발주요청량',
                            data: orderRequest,
                            backgroundColor: '#fbd4ab',
                            borderRadius: 30,
                            barThickness: 10   ,
                            maxBarThickness: 8,
                        },
                        {
                            label: '재고량',
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
                            backgroundColor: "#fbd4ab",
                            titleColor: "#333",
                            bodyColor: "#333",
                            displayColors: false,
                            titleAlign: "center",
                            bodyAlign: "center",
                            titleFont: { size: 14, weight: "bold" },
                            bodyFont: { size: 16, weight: "bold" },
                            padding: { x: 30, y: 10 },
                            callbacks: {
                                label: function(context) {
                                    let label = context.dataset.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    label += context.parsed.x;
                                    return label;
                                },
                            },
                            backgroundColor: "#fbd4ab",
                            titleAlign: "center",
                            bodyAlign: "center",
                            titleFont: {
                                size: 12,
                                weight: "bold",
                            },
                            bodyFont: {
                                size: 16,
                                weight: "bold",
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


    //창고 필터
    $('body').on('click', '#resetFilterBtn', function () {
        $('#warehouseCategory_clone').val('')
        table.draw();
    });


    //도넛차트
    let inboundChart;  // 차크 변수 선언

    // 페이지 로딩 시 초기 차트 그리기
    document.addEventListener('DOMContentLoaded', function() {
        const firstWarehouse = document.getElementById('warehouseCategory').value;
        if (firstWarehouse) {
            fetchWarehouseData(firstWarehouse);
        }
    });

    // 창고 선택 시 호출
    $('#warehouseCategory').on('change', function() {
        const selectedWarehouse = $(this).val();
        if (selectedWarehouse) {
            fetchWarehouseData(selectedWarehouse);
        }
    });

    // 서버에서 창고 데이터 가져오기
    function fetchWarehouseData(warehouse) {
        fetch('<c:url value="/qh/inbound-order-rate"/>' + '?warehouse=' + encodeURIComponent(warehouse))
            .then(response => response.json())
            .then(data => {
                updateWarehouseChart('inboundChart-1', data.inboundRate, data.orderRate);
            })
            .catch(error => {
                console.error('창고 데이터 불러오기 실패:', error);
            });
    }

    function updateWarehouseChart(canvasId, inboundRate, orderRate) {
        if (inboundChart) {
            inboundChart.destroy();
        }
        const ctx = document.getElementById(canvasId).getContext('2d');

        const centerTextPlugin = {
            id: 'centerText',
            beforeDraw(chart) {
                const { width, height, ctx } = chart;
                ctx.save();

                ctx.font = `17px sans-serif`;
                ctx.textBaseline = 'middle';
                ctx.textAlign = 'center';
                ctx.fillStyle = '#333';

                const inboundText = '입고 ' + inboundRate + '%';
                const outboundText = '출고 ' + orderRate + '%';
                ctx.fillText(inboundText, width / 2, height / 2 - 10);
                ctx.fillText(outboundText, width / 2, height / 2 + 20);
                ctx.restore();
            }
        };

        inboundChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['진행률', '남은비율'],
                datasets: [
                    {
                        label: '입고 진행율',
                        data: [inboundRate || 0.01, 100 - (inboundRate || 0.01)],
                        backgroundColor: ['#ff9d32', '#f3f3f3'],
                        borderRadius: 30,
                        cutout: '70%',
                        radius: '80%',
                    },
                    {
                        label: '출고 진행율',
                        data: [orderRate || 0.01, 100 - (orderRate || 0.01)],
                        backgroundColor: ['#fbd4ab', '#f3f3f3'],
                        borderRadius: 30,
                        cutout: '50%',
                        radius: '60%',
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    title: { display: false },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                if (context.dataIndex === 0) {
                                    let label = context.dataset.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    label += context.parsed + '%';
                                    return label;
                                }
                                return '';
                            }
                        }
                    }
                }
            },
            plugins: [centerTextPlugin] // 플러그인 등록
        });
    }

</script>
</body>
</html>


