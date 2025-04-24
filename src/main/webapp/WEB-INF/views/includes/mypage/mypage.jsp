
<!-- 마이페이지 모달 -->
<div class="modal fade" id="mypageModal" tabindex="-1" aria-labelledby="mypageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="mypageModalLabel">내 회원 정보</h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 마이페이지 수정 폼 -->
                <form id="mypageForm" action="<c:url value='/mypage/update'/>" method="post">
                    <!-- 로그인한 유저 아이디(숨겨서 전송) -->
                    <input type="hidden" name="id"  value="${member.id}" />

                    <div class="mb-3">
                        <label class="form-label">아이디</label>
                        <input type="text" class="form-control" name="id" id="id" value="${member.id}" readonly/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">비밀번호</label>
                        <input type="password" class="form-control" name="password" id="password" value="${member.password}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">이름</label>
                        <input type="text" class="form-control" name="name" id="name" value="${member.name}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">이메일</label>
                        <input type="email" class="form-control" name="email" id="email" value="${member.email}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">전화번호</label>
                        <input type="text" class="form-control" name="phoneNumber" id="phoneNumber" value="${member.phoneNumber}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">주소</label>
                        <input type="text" class="form-control" name="address" id="address" value="${member.address}"/>
                    </div>

                    <div class="text-center w-100 mt-1 mb-3">
                        <button type="button" class="main-btn primary-btn btn-hover" id="btnUpdate">수정</button>
                    </div>
                </form>

                <!-- 탈퇴 폼 -->
                <form id="secessionForm" action="<c:url value='/mypage/delete'/>" method="post">
                    <button type="submit" class="text-link"    id="bntMypageSecession">탈퇴</button>
                </form>
            </div>
    </div>
</div>
</div>
