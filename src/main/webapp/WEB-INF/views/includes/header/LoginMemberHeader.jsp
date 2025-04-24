<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<header class="header">
    <div class="container-fluid">
        <div class="row">
            <!-- 왼쪽: 메뉴 토글 -->
            <div class="col-lg-5 col-md-5 col-6">
                <div class="header-left d-flex align-items-center">
                    <div class="menu-toggle-btn mr-15">
                        <button id="menu-toggle" class="main-btn primary-btn btn-hover">
                            <i class="lni lni-chevron-left me-2"></i> Menu
                        </button>
                    </div>
                </div>
            </div>
            <!-- 오른쪽: 프로필 박스 -->
            <div class="col-lg-7 col-md-7 col-6">
                <div class="header-right">
                    <div class="profile-box ml-15">
                        <button
                                class="dropdown-toggle bg-transparent border-0"
                                type="button"
                                id="profile"
                                data-bs-toggle="dropdown"
                                aria-expanded="false"
                        >
                            <div class="profile-info">
                                <div class="info d-flex align-items-center">
                                    <div class="image me-2">
                                        <img
                                                src="<c:url value='/resources/images/profile/user_profile.png'/>"
                                                alt="프로필 이미지"
                                        />
                                    </div>
                                    <div>
                                        <!-- 로그인 사용자 이름 -->

                                        <sec:authorize access="isAuthenticated()">
                                            <!-- 디버깅: member가 null인지 출력 -->
                                            <!-- 실제 화면에 보여줄 때 -->
                                            <h6 class="fw-500">${member.name}</h6>
                                        </sec:authorize>
                                        <!-- 권한별 라벨 -->
                                        <p>
                                            <c:choose>
                                                <c:when test="${member.authorityCode == 'QH'}">QH Admin</c:when>
                                                <c:when test="${member.authorityCode == 'WM'}">WM Admin</c:when>
                                                <c:otherwise>User</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profile">
                            <li>
                                <div class="flex items-center !p-1">
                                    <div class="content-a">
                                        <!-- 상세 내 정보 -->
                                        <h6>${member.name}</h6>
                                        <p>${member.email}</p>
                                    </div>
                                </div>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <!-- 마이페이지 모달 오픈 -->
                                <a href="#mypageModal" data-bs-toggle="modal" id="btnmypageMenu">
                                    <i class="lni lni-user"></i> My Page
                                </a>
                            </li>
                            <li>
                                <!-- 로그아웃 -->
                                <a href="<c:url value='/home/logout'/>">
                                    <i class="lni lni-exit"></i> Sign Out
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
