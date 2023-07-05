<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>주문완료</title>
    <%--아이콘--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <%--부트스트랩--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <%--부트스트랩 css스킨 및 css--%>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/resources/css/index.css" type="text/css">
    <link href="/resources/css/myFont.css" rel="stylesheet">
    <%--ajax, sweetalert--%>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <%--도로명주소--%>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="container">
    <div class="row mb-4">
        <div class="col-2"></div>
        <div class="col-lg-10 px-4">
            <div class="d-flex flex-column align-items-center justify-content-center bg-primary bg-opacity-50"
                 style="min-height: 200px">
                <h1 class="pt-3 text-dark">주문완료</h1>
            </div>
            <div class="row mt-3 align-content-center justify-content-center">
                <div class="col-8">
                    <div class="text-center">
                        <h2>${logIn.nickname} (${logIn.realName}) 님의 주문이 완료되었습니다!</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../footer.jsp" %>
</body>
</html>
