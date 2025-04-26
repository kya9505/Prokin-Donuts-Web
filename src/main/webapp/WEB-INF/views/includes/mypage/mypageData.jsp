$('#btnUpdate').on('click', async function (e) {
e.preventDefault();

const data = {
id: $('#id').val().trim(),
password: $('#password').val().trim(),
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
