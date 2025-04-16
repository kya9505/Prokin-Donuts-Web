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
<%@ include file="/WEB-INF/views/includes/homeSidebar.jsp" %>
<!-- ======== sidebar-nav end =========== -->

<!-- ======== main-wrapper start =========== -->
<main class="main-wrapper">
    <!-- ========== header start ========== -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-5 col-md-5 col-6">
                    <div class="header-left d-flex align-items-center">
                        <div class="menu-toggle-btn mr-15">
                            <button id="menu-toggle" class="main-btn primary-btn btn-hover">
                                <i class="lni lni-chevron-left me-2"></i> Menu
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- ========== header end ========== -->

    <!-- ========== signin-section start ========== -->
    <section class="signin-section">
        <div class="container-fluid">
            <!-- ========== title-wrapper start ========== -->
            <div class="title-wrapper"style="margin-top: 100px;">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="title">
                            <h2></h2>
                        </div>
                    </div>
                    <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- ========== title-wrapper end ========== -->

            <div class="row g-0 auth-row">
                <div class="col-lg-6">
                    <div class="auth-cover-wrapper bg-primary-100">
                        <div class="auth-cover">
                            <div class="title text-center">
                                <h1 class="text-primary mb-30">ID assistance</h1>
                                <p class="text-medium">
                                    Enter your username or email to recover your ID. <br>
                                    You will receive an email with instructions.
                                </p>
                            </div>
                            <div class="cover-image pb-30">
                                <img src="<c:url value='/resources/images/auth/reset-password.png'/>" alt="" />
                            </div>
                            <div class="shape-image">
                                <img src="<c:url value='/resources/images/auth/shape.png'/>" alt=""style="width: 300px; height: auto;" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end col -->
                <div class="col-lg-6">
                    <div class="signin-wrapper">
                        <div class="form-wrapper">
                            <h3 class="mb-15">Find ID</h3>
                            <p class="text-sm mb-25">
                            </p>
                            <form action="#">
                                <div class="row">
                                    <div class="col-12">
                                        <ul style="display: flex; align-items: center; padding: 0; margin-top: 1rem; list-style: none;">
                                            <li style="flex: 1;">
                                                <div class="input-style-1">
                                                    <label>Email</label>
                                                    <input type="email" placeholder="email" />
                                                </div>
                                            </li>
                                            <li style="margin-left: 12px;">
                                                <div class="col-4">
                                                    <a href="#0" class="main-btn primary-btn rounded-full btn-hover">
                                                        <span>Send</span><span style="margin-left: 1px;">Code</span>
                                                    </a>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- end col -->
                                <div class="col-12">
                                    <div class="input-style-1">
                                        <label>Code : Check your Email</label>
                                        <input type="text" placeholder="code"/>
                                    </div>
                                </div>
                                <!-- end col -->
                                <div class="col-12">
                                    <div class="button-group d-flex justify-content-center flex-wrap">
                                        <button class="main-btn primary-btn btn-hover w-100 text-center">
                                            <span>Find</span> <span>ID</span>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <ul style="display: flex; align-items: center; padding: 0; margin-top: 1rem; list-style: none;">
                                        <li style="flex: 1;">
                                            <a href="signup.html">Create an account</a>

                                        </li>
                                        <li style="margin-left: 12px;">
                                            <a href="index.html"> Sign In</a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-12">

                                </div>

                        </div>
                    </div>
                    <!-- end row -->
                    </form>

                </div>
            </div>
        </div>
        <!-- end col -->
        </div>
        <!-- end row -->
        </div>
    </section>
    <!-- ========== signin-section end ========== -->

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

</body>
</html>
