<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<aside class="sidebar-nav-wrapper">
    <div class="navbar-logo">
        <a href="<c:url value='/wm/dashboard'/>">
            <img src="<c:url value='/resources/images/logo/menu_logo.png'/>" alt="logo" />
        </a>
    </div>
    <nav class="sidebar-nav">
        <ul>
            <li class="nav-item">
                <a href="<c:url value='/wm/member'/>">
          <span class="icon">
            <i class="lni lni-users"></i>
          </span>
                    <span class="text">회원관리</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<c:url value='/wm/warehouse'/>">
          <span class="icon">
            <i class="lni lni-home"></i>
          </span>
                    <span class="text">창고관리</span>
                </a>
            </li>
            <li class="nav-item nav-item-has-children">
                <a
                        href="#0"
                        class="collapsed"
                        data-bs-toggle="collapse"
                        data-bs-target="#ddmenu_55"
                        aria-controls="ddmenu_55"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                >
          <span class="icon">
            <i class="lni lni-cart"></i>
          </span>
                    <span class="text">입고관리</span>
                </a>
                <ul id="ddmenu_55" class="collapse dropdown-nav ">
                    <li>
                        <a href="<c:url value='/wm/inbound/request'/>" class="hover-text-grow">입고요청</a>
                    </li>
                    <li>
                        <a href="<c:url value='/wm/inbound/approval'/>" class="hover-text-grow">입고관리</a>
                    </li>
                    <!-- <li>
                        <a href="<c:url value='/wm/inbound/modify'/>" class="hover-text-grow">입고수정/취소</a>
                    </li> -->
                    <li>
                        <a href="<c:url value='/wm/inbound/status'/>" class="hover-text-grow">입고현황</a>
                    </li>
                </ul>
            </li>
            <li class="nav-item">
                <a href="<c:url value='/wm/outbound'/>">
          <span class="icon">
            <i class="lni lni-delivery"></i>
          </span>
                    <span class="text">출고관리</span>
                </a>
            </li>
        </ul>
    </nav>
</aside>
<div class="overlay"></div>
