$('#togglePassword').on('click', function() {
const $passwordInput = $('#mypagePassword');
const $icon = $('#passwordIcon');
const type = $passwordInput.attr('type') === 'password' ? 'text' : 'password';
$passwordInput.attr('type', type);

if (type === 'text') {
$icon.replaceWith(`
<svg id="passwordIcon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-slash-fill" viewBox="0 0 16 16">
    <path d="m10.79 12.912-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7 7 0 0 0 2.79-.588M5.21 3.088A7 7 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474z"/>
    <path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829zm4.95.708-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829zm3.171 6-12-12 .708-.708 12 12z"/>
</svg>
`);
} else {
$icon.replaceWith(`
<svg id="passwordIcon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
    <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
    <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
</svg>
`);
}
});



$('#btnUpdate').on('click', async function (e) {
e.preventDefault();

const data = {
id: $('#id').val().trim(),
password: $('#mypagePassword').val().trim(),
name: $('#name').val().trim(),
email: $('#email').val().trim(),
phoneNumber: $('#phoneNumber').val().trim(),
address: $('#address').val().trim()
};

if (!/^[A-Za-z가-힣]{1,10}$/.test(data.name)) {
alert("이름은 한글/영어 조합, 최대 10글자입니다.");
return;
}
if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(data.email)) {
alert("올바른 이메일 형식을 입력해주세요.");
return;
}
if (data.phoneNumber && !/^[0-9]{10,11}$/.test(data.phoneNumber)) {
alert("전화번호는 10~11자리 숫자입니다.");
return;
}

if (!confirm("입력하신 정보로 수정하시겠습니까?")) return;

try {
const res = await fetch('/mypage/update', {
method: 'POST',
headers: {
'Content-Type': 'application/x-www-form-urlencoded'
},
body: new URLSearchParams(data)  // ✅ form처럼 보내짐
});

if (res.ok) {
alert("수정 완료되었습니다.");
// 모달 유지됨
} else {
alert("수정 중 오류 발생");
}
} catch (err) {
console.error("요청 실패", err);
alert("서버와 연결 실패");
}
});
// 탈퇴 버튼
$('#bntMypageSecession').on('click', function(e){
e.preventDefault();
if (confirm('⚠️ 계정을 삭제하시겠습니까?\n삭제된 계정은 복구되지 않습니다.')) {
$('#mypageModal').modal('hide');
$('#secessionForm').submit();
}
});