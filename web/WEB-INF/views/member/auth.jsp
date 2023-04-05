<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>인덱스</title>
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
</head>
<body onload="showMsg()">
<%@include file="../header.jsp" %>
${loginFailMsg}
<div class="container">
    <div class="row">
        <div class="col-2"></div>
        <div class="col-lg-10 px-4">
            <div class="d-flex flex-column align-items-center justify-content-center bg-primary bg-opacity-50"
                 style="min-height: 200px">
                <h1 class="pt-3 text-dark">로그인</h1>
            </div>
            <div class="row my-5 align-content-center justify-content-center">
                <div class="col-md-4 col-6">
                    <form method="post" action="/member/auth">
                        <label for="input-username">아이디</label>
                        <input type="text" id="input-username" name="username" class="form-control mb-2">
                        <label for="input-password">비밀번호</label>
                        <input type="password" id="input-password" name="password" class="form-control mb-2">
                        <input class="text-muted" type="checkbox" name="remember-me">  로그인 상태유지
                        <div class="text-end">
                            <a class="btn btn-light" href="/member/register">
                                <span style="font-size: 12px">회원가입하기</span>
                            </a>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-outline-primary">로그인</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    let showMsg = () => {
        let msg = ${loginFailMsg}+"";

        if(msg){
            Swal.fire({title: "로그인 실패", text: "계정 정보를 다시 확인해주세요."});
        }

        console.log(msg == "");
    };
</script>

<%@include file="../footer.jsp" %>
</body>
</html>