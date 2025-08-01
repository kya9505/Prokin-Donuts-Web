<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>403 - 접근이 거부되었습니다</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            text-align: center;
            padding: 50px;
        }
        h1 {
            font-size: 80px;
            margin-bottom: 10px;
        }
        p {
            font-size: 20px;
            margin-bottom: 30px;
        }
        a {
            display: inline-block;
            padding: 12px 24px;
            background-color: #f58636;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 18px;
        }
        a:hover {
            background-color: #f58636;
        }
    </style>
</head>
<body>
<h1>403</h1>
<p>${message}</p>
<a href="/">🏠 홈으로 돌아가기</a>
</body>
</html>
