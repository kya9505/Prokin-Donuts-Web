---
name: Custom issue template
about: Describe this issue template's purpose here.
title: ''
labels: ''
assignees: ''

---

## ✨ What happened?  
문제가 발생한 상황 또는 개선하고 싶은 지점을 작성해주세요.

<details>
<summary>예시 보기</summary>

Gradle로 빌드 시 `stream().toList()` 구문에서 컴파일 에러 발생  
</details>

---

## 🧠 Why did it happen?  
원인이나 배경을 설명해주세요.

<details>
<summary>예시 보기</summary>

JDK 17을 사용 중이었지만, `build.gradle` 내 sourceCompatibility가 1.8로 설정되어 있었음  
</details>

---

## 🔧 How was it fixed?  
해결 방법 또는 개선 방안을 정리해주세요.

<details>
<summary>예시 보기</summary>

Gradle 설정을 `sourceCompatibility = '17'`로 수정하여 문제 해결  
</details>

---

## 📎 Notes  
관련 자료, 재현 방법, 에러 로그, 참고 링크 등 필요한 내용을 자유롭게 작성해주세요.

<details>
<summary>예시 보기</summary>

- `build.gradle` 수정 전/후 비교  
- IntelliJ 실행 환경: JDK 17, Gradle 7.6  
- 관련 문서 링크: https://docs.oracle.com/en/java/javase/17/  
</details>
