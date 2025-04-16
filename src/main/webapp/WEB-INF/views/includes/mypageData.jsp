<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!--마이페이지 데이터 -->
$('#btnmypageEmail, #btnmypageMenu').on('click', function () {
const userInfo = {
id: 'kim_admin',
password: 'dummyPassword',
name: '김관리자',
email: 'email@example.com',
phone: '010-1234-5678',
address: '서울시 강남구'
};

$('#id').val(userInfo.id);
$('#password').val(userInfo.password);
$('#name').val(userInfo.name);
$('#email').val(userInfo.email);
$('#PhoneNumber').val(userInfo.phone);
$('#address').val(userInfo.address);

$('#mypageModal').modal('show');
});


//mypage 탈퇴
$('#bntMypageSecession').on('click', function (e) {

const result = confirm('⚠️ 계정을 삭제하시겠습니까?\n삭제된 계정은 복구되지 않습니다.');

if (result) {
// 확인 눌렀을 때 실행
console.log('삭제 진행!');
} else {
// 취소 눌렀을 때 실행
console.log('삭제 취소됨!');
}

$('#mypageModal').modal('show');
});