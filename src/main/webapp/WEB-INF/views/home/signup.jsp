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
            <div class="title-wrapper pt-30">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="title">
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
                                <h1 class="text-primary mb-10">Get Started</h1>
                                <p class="text-medium">
                                    You can use the system after admin approval upon signing up.
                                    <br class="d-sm-block" />
                                    for you customers.
                                </p>
                            </div>
                            <div class="cover-image">
                                <img src="<c:url value='/resources/images/auth/signin-image.png'/>" alt="" />
                            </div>
                            <div class="shape-image">
                                <img src="<c:url value='/resources/images/auth/shape.png'/>" alt=""style="width: 500px; height: auto;" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end col -->
                <div class="col-lg-6">
                    <div class="signup-wrapper">
                        <div class="form-wrapper">
                            <div class="d-flex align-items-end gap-2 mb-3">
                                <h2 class="mb-0">Sign Up</h2>
                                <small class="text-danger" style="font-weight: 400; padding-bottom: 2px;">
                                    (*)는 필수 입력 항목입니다.
                                </small>
                            </div>
                                <form id="memberRequestForm" action="${pageContext.request.contextPath}/home/signup" method="post">
                                <div class="row">
                                    <div class="col-12">
                                        <ul style="display: flex; align-items: center; padding: 0; margin-top: 1rem; list-style: none;">
                                            <li style="flex: 1;">
                                                <div class="input-style-1">
                                                    <label>ID (*)</label>
                                                    <input type="text" placeholder="ID" name="id" id="id" />
                                                </div>
                                            </li>
                                            <li style="margin-left: 12px;">
                                                <div class="col-2">
                                                    <button type="button" id="idCheck" class="main-btn primary-btn rounded-full btn-hover">ID Check</button>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <!-- end col -->
                                    <div class="col-12">
                                        <div class="input-style-1">
                                            <label>Password (*)</label>
                                            <input type="Password" placeholder="Password" name="password" id="password" required/>
                                        </div>
                                    </div>
                                    <!-- end col -->
                                    <div class="col-12">
                                        <div class="input-style-1">
                                            <label>Password Check (*)</label>
                                            <input type="password" placeholder="Password Check" id="passwordCheck" name="passwordCheck" required/>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="input-style-1">
                                            <label>Name (*)</label>
                                            <input type="text" placeholder="Name" name="name" id="name" />
                                        </div>
                                    </div>
                                    <!-- end col -->
                                    <!-- end col -->
                                    <div class="col-12">
                                        <div class="input-style-1">
                                            <label>Email (*)</label>
                                            <input type="Email" placeholder="Email" name = "email" id = "email" required/>
                                        </div>
                                    </div>
                                    <!-- end col -->
                                    <div class="col-12">
                                        <div class="input-style-1">
                                            <label>Phone Number</label>
                                            <input type="text" placeholder="Phone Number" name = "phoneNumber" id = "phoneNumber" />
                                        </div>
                                    </div>
                                    <!-- end col -->
                                    <div class="col-12">
                                        <div class="input-style-1">
                                            <label>address</label>
                                            <input type="text" placeholder="address" name ="address" id ="address"/>
                                        </div>
                                    </div>

                                    <!-- end col -->
                                    <div class="col-12">
                                        <div class="button-group d-flex justify-content-center flex-wrap">
                                            <button type="button"
                                                    class="main-btn primary-btn btn-hover w-100 text-center"
                                                    id = "signup-bnt">
                                                Sign Up
                                            </button>
                                        </div>
                                    </div>
                                    <div class="singin-option pt-40">
                                        <p class="text-sm text-medium text-dark text-center">
                                            Already have an account?
                                            <a href="<c:url value='/home/login'/>">Sign In</a>
                                        </p>
                                    </div>
                                </div>
                            </form>
                        </div>
                                <!-- end row -->
                    </div>
                                <!-- end col -->
                </div>
                        <!-- end row -->
            </div>
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


    let isIdChecked = false;

    $(document).ready(function () {

        // ID 중복 체크
        $("#idCheck").on("click", function () {
            const id = $("#id").val().trim();
            if (!id) {
                alert("아이디를 입력하세요");
                return;
            }

            const contextPath = "${pageContext.request.contextPath}";
            fetch(contextPath + "/home/check?id=" + encodeURIComponent(id))
                .then(res => res.text())
                .then(text => {
                    const isDup = (text === 'true');
                    if (isDup) {
                        alert("이미 존재하는 아이디입니다.");
                        isIdChecked = false;
                    } else {
                        alert("사용 가능한 아이디입니다.");
                        isIdChecked = true;
                    }
                })
                .catch(() => {
                    alert("중복 확인 중 오류가 발생했습니다.");
                    isIdChecked = false;
                });
        });

        // Sign Up 버튼 → 유효성 검사 후 submit
        $("#signup-bnt").on("click", function () {
            const id = $("#id").val().trim();
            const password = $("#password").val().trim();
            const passwordCheck = $("#passwordCheck").val().trim();
            const name = $("#name").val().trim();
            const email = $("#email").val().trim();
            const phoneNumber = $("#phoneNumber").val().trim();
            const regName = /^[A-Za-z가-힣]{1,10}$/;
            const regPhone = /^[0-9]{10,11}$/;
            const regEmail = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;



            if (!isIdChecked) {
                alert("아이디 중복확인을 해주세요.");
                return;
            }

            if (password !== passwordCheck) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                return;
            }
            if (!regName.test(name)) {
                alert("이름은 한글/영어 조합이며 최대 10글자입니다.");
                return;

            }

            if (!regEmail.test(email)) {
                alert("올바른 이메일 형식을 입력해주세요.");
                return;

            }

            if (!id || !password || !passwordCheck || !name || !email) {
                alert("필수 항목을 모두 입력해주세요.");
                return;
            }

            if (phoneNumber && !regPhone.test(phoneNumber)) {
                alert("전화번호는 하이픈 없이 10~11자리 숫자입니다.");
                return;
            }


            $('#memberRequestForm').on('click', function (e) {

                const result = confirm('입력하신 정보로 회원가입 요청을 하시겠습니까? ');

                if (result) {
                    console.log('회원가입 요청');
                } else {
// 취소 눌렀을 때 실행
                    console.log('회원가입 요청 취소');
                }
            });
            // 통과 시 제출
            $("#memberRequestForm").submit();
        });
    });

</script>
</body>
</html>
