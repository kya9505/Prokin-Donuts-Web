<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<aside class="sidebar-nav-wrapper">
    <div class="navbar-logo">
        <a href="qh-dashboard.html">
            <img src="<c:url value='/resources/images/logo/menu_logo.png'/>" alt="logo" />
        </a>
    </div>

    <nav class="sidebar-nav">
        <ul>
            <li class="nav-item"></li>

            <li class="nav-item nav-item-has-children">
                <a href="#0" class="collapsed" data-bs-toggle="collapse"
                   data-bs-target="#ddmenu_2" aria-controls="ddmenu_2"
                   aria-expanded="false" aria-label="Toggle navigation">
                    <span class="icon">
                        <i width="20" height="20" viewBox="0 0 20 20"
                           fill="none" class="lni lni-users"></i>
                    </span>
                    <span class="text">회원관리</span>
                </a>
                <ul id="ddmenu_2" class="collapse dropdown-nav">
                    <li>
                        <a href="<c:url value='/qh/member/list'/>" class="hover-text-grow">회원목록</a>
                    </li>
                    <li>
                        <a href="<c:url value='/qh/member/request'/>" class="hover-text-grow">회원 가입 요청 목록</a>
                    </li>
                </ul>
            </li>

            <li class="nav-item">
                <a href="<c:url value='/qh/warehouse'/>">
                    <span class="icon">
                        <i width="20" height="20" viewBox="0 0 20 20"
                           fill="none" class="lni lni-home"></i>
                    </span>
                    <span class="text">창고관리</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="<c:url value='/qh/franchise'/>">
                    <span class="icon">
                        <i width="20" height="20" viewBox="0 0 20 20"
                           fill="none" class="lni lni-apartment"></i>
                    </span>
                    <span class="text">가맹점관리</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="<c:url value='/qh/inventory'/>">
                    <span class="icon">
                        <i width="20" height="20" viewBox="0 0 20 20"
                           fill="none" class="lni lni-package"></i>
                    </span>
                    <span class="text">재고관리</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="<c:url value='/qh/product'/>">
                    <span class="icon">
                        <i width="20" height="20" viewBox="0 0 20 20"
                           fill="none" class="lni lni-chef-hat"></i>
                    </span>
                    <span class="text">제품관리</span>
                </a>
            </li>

            <li class="nav-item nav-item-has-children">
                <a href="#0" class="collapsed" data-bs-toggle="collapse"
                   data-bs-target="#ddmenu_55" aria-controls="ddmenu_55"
                   aria-expanded="false" aria-label="Toggle navigation">
                    <span class="icon">
                        <i width="20" height="20" viewBox="0 0 20 20"
                           fill="none" class="lni lni-cart"></i>
                    </span>
                    <span class="text">입고관리</span>
                </a>
                <ul id="ddmenu_55" class="collapse dropdown-nav">
                    <li>
                        <a href="<c:url value='/qh/inbound/request'/>" class="hover-text-grow">입고 요청 목록</a>
                    </li>
                    <li>
                        <a href="<c:url value='/qh/inbound/status'/>" class="hover-text-grow">입고현황</a>
                    </li>
                </ul>
            </li>

            <li class="nav-item">
                <a href="<c:url value='/qh/outbound'/>">
                    <span class="icon">
                        <i width="20" height="20" viewBox="0 0 20 20"
                           fill="none" class="lni lni-delivery"></i>
                    </span>
                    <span class="text">출고관리</span>
                </a>
            </li>
        </ul>
    </nav>
</aside>

<div class="overlay"></div>
