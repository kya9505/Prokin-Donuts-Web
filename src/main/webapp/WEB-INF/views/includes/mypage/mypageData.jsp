
    $(function(){

        // 수정 버튼 클릭 (async 중요!)
        $('#btnUpdate').on('click', async function(e){
            e.preventDefault();

            // 1) 필드값 가져오기 & 기본 검증…
            const password      = $('#password').val().trim();
            const name          = $('#name').val().trim();
            const email         = $('#email').val().trim();
            const phoneNumber   = $('#phoneNumber').val().trim();


            if (!/^[A-Za-z가-힣]{1,10}$/.test(name)) {
                alert("이름은 한글/영어 조합, 최대 10글자입니다.");
                return;
            }
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                alert("올바른 이메일 형식을 입력해주세요.");
                return;
            }

            // 3) 전화번호 검증 (선택)
            if (phoneNumber && !/^[0-9]{10,11}$/.test(phoneNumber)) {
                alert("전화번호는 10~11자리 숫자입니다.");
                return;
            }
const result = confirm('입력하신 정보로 수정 하시겠습니까?');
if (!result) {
console.log('수정 취소');
return;
}
            // 4) 모두 통과하면 실제 폼 전송
            $('#mypageForm').submit();
        });

        // 탈퇴 버튼
        $('#bntMypageSecession').on('click', function(e){
            e.preventDefault();
            if (confirm('⚠️ 계정을 삭제하시겠습니까?\n삭제된 계정은 복구되지 않습니다.')) {
                $('#mypageModal').modal('hide');
                $('#secessionForm').submit();
            }
        });

    });
