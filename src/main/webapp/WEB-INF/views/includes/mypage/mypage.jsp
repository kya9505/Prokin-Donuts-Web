<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 마이페이지 모달 -->
<div class="modal fade" id="mypageModal" tabindex="-1" aria-labelledby="mypageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="mypageModalLabel">내 회원 정보</h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="modifyForm">
                    <input type="hidden" id="mypageId">

                    <div class="mb-3">
                        <label class="form-label">아이디</label>
                        <input type="id" class="form-control" id="id">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">비밀번호</label>
                        <input type="text" class="form-control" id="password">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">이름</label>
                        <input type="text" class="form-control" id="name">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">이메일</label>
                        <input type="email" class="form-control" id="email">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">전화번호</label>
                        <input type="text" class="form-control" id="PhoneNumber">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">주소</label>
                        <input type="text" class="form-control" id="address">
                    </div>
                </form>
            </div>
            <div class="text-center w-100 mt-1 mb-3">
                <button type="submit" class="main-btn primary-btn btn-hover text-center" >수정</button>
            </div>
            <div class="text-center mb-3">
                <a href=#0 id = "bntMypageSecession">탈퇴</a>
            </div>
        </div>
    </div>
</div>

