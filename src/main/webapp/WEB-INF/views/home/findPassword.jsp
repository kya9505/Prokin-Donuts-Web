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
<%@ include file="/WEB-INF/views/includes/sidebar/homeSidebar.jsp" %>
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
                                <h1 class="text-primary mb-30">Password assistance</h1>
                                <p class="text-medium">
                                    Enter your username or email to recover your ID. <br>
                                    You will receive an email with instructions.
                                </p>
                            </div>
                            <div class="cover-image pb-30">
                                <img src="<c:url value='/resources/images/auth/reset-password.png'/>" alt="" />
                            </div>
                            <div class="shape-image">
                                <img src="<c:url value='/resources//images/auth/shape.png'/>" alt=""style="width: 300px; height: auto;" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end col -->
                <div class="col-lg-6">
                    <div class="signin-wrapper">
                        <div class="form-wrapper">
                            <h3 class="mb-15">Find Password</h3>
                            <p class="text-sm mb-25">
                            </p>
                            <form id="findPasswordForm" action="${pageContext.request.contextPath}/home/findPassword" method="get">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="input-style-1">
                                            <label>ID</label>
                                            <input type="id" placeholder="ID" id="id" name="id" />
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <ul style="display: flex; align-items: center; padding: 0; margin-top: 1rem; list-style: none;">
                                            <li style="flex: 1;">
                                                <div class="input-style-1">
                                                    <label>Email</label>
                                                    <input type="email" placeholder="email" id="email" name="email"/>
                                                </div>
                                            </li>
                                            <li style="margin-left: 12px;">
                                                <div class="col-4">
                                                    <button type="button" id="sendCode" name="sendCode" class="main-btn primary-btn rounded-full btn-hover">
                                                        <span>Send</span><span style="margin-left: 1px;">Code</span>
                                                    </button>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <!-- end col -->

                                </div>
                                <!-- end col -->
                                <div class="col-12">
                                    <div class="input-style-1">
                                        <label>Code : Check your Email</label>
                                        <input type="text" placeholder="code" id="code" name="code"/>
                                    </div>
                                </div>
                                <!-- end col -->
                                <div class="col-12">
                                    <div class="button-group d-flex justify-content-center flex-wrap">
                                        <button  type="button" id="findPs-bnt" name="findPassword" class="main-btn primary-btn btn-hover w-100 text-center">
                                            <span>Find</span> <span>Password</span>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <ul style="display: flex; align-items: center; padding: 0; margin-top: 1rem; list-style: none;">
                                        <li style="flex: 1;">
                                            <a href="<c:url value='/home/signup'/>">Create an account</a>

                                        </li>
                                        <li style="margin-left: 12px;">
                                            <a href="<c:url value='/home/login'/>">Sign In</a>

                                        </li>
                                    </ul>
                                </div>
                                <div class="col-12">

                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- end row -->

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
<script>


    let sendCheck = false;

    $(document).ready(function () {

        // 메일발송 확인
        $("#sendCode").on("click", function () {
            const email = $("#email").val().trim();
            const id = $("#id").val().trim();
            const regEmail = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

            if (!id) {
                alert("아이디를 입력하세요.");
                return;
            }

            if (!email) {
                alert("이메일을 입력하세요.");
                return;
            }
            if (!regEmail.test(email)) {
                alert("올바른 이메일 형식을 입력해주세요.");
                return;
            }

            const contextPath = "${pageContext.request.contextPath}";
            fetch(contextPath + "/home/sendCode?email=" + encodeURIComponent(email))
                .then(res => res.text())
                .then(text => {
                    const result = text.trim();
                    console.log("메일 응답:", result);

                    if (result === "success") {
                        alert("메일을 발송했습니다.");
                        sendCheck = true;
                    } else if (result === "notFound") {
                        alert("입력한 이메일로 등록된 회원이 없습니다.");
                        sendCheck = false;
                    } else {
                        alert("메일 전송 중 문제가 발생했습니다. 잠시 후 다시 시도해주세요.");
                        sendCheck = false;
                    }
                })
                .catch(() => {
                    alert("서버 오류가 발생했습니다.");
                    sendCheck = false;
                });
        });
        // 비밀번호찾기 → 유효성 검사 후 아이디 조회
        $("#findPs-bnt").on("click", async function () {
            const code = $("#code").val().trim();
            const id = $("#id").val().trim();
            const email = $("#email").val().trim();
            const regCode = /^[0-9]{6}$/;

            if (!sendCheck) {
                alert("이메일로 인증번호를 발급받으세요.");
                return;
            }

            if (!regCode.test(code)) {
                alert("인증번호는 6자리 숫자 입니다.");
                return;

            }

            const contextPath = "${pageContext.request.contextPath}";
            try {
                const res = await fetch(contextPath + "/home/resultPassword?email=" + encodeURIComponent(email) + "&inputCode=" + encodeURIComponent(code) + "&id=" + encodeURIComponent(id));
                const result = await res.text();
                const password = result.trim();

                if (result === "IdCheck") {
                    alert("아이디가 일치하지 않습니다.");
                } else if (password && password !== "false") {
                    alert("찾으시는 비밀번호 : " + password);
                } else {
                    alert("유효한 인증번호가 아닙니다. 다시 입력해주세요. \n (발급받은 인증번호는 10분동안만 유효합니다.)");
                }
            } catch (error) {
                alert("서버 요청 중 오류가 발생했습니다.");
            }
        });
    });

</script>
</body>
</html>
