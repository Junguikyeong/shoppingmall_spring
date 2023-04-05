<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원가입</title>
    <%--아이콘--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <%--Jquery--%>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
    <%--sweetalert--%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
    <%--도로명주소--%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<%@include file="../header.jsp" %>

<div class="container">
    <div class="row">
        <div class="col-2"></div>
        <div class="col-lg-10 px-4">
            <div class="d-flex flex-column align-items-center justify-content-center bg-primary bg-opacity-50"
                 style="min-height: 200px">
                <h1 class="pt-3 text-dark">회원가입</h1>
            </div>
            <div class="row my-5 align-content-center justify-content-center">
                <div class="col-md-6 col-8">
                    <form id="registerForm" method="post" action="/member/register">
                        <label for="username">아이디</label>
                        <input type="text" id="username" name="username" class="form-control mb-2">
                        <label for="password">비밀번호</label>
                        <input type="password" id="password" name="password" class="form-control mb-2">
                        <label for="nickname">닉네임</label>
                        <input type="text" id="nickname" name="nickname" class="form-control mb-2">
                        <label for="realName">이름(성 까지)</label>
                        <input type="text" id="realName" name="realName" class="form-control mb-2">
                        <div class="input-group mb-2">
                            <div class="col-10 form-floating">
                                <input type="text" class="form-control" name="postcode" id="postCode"
                                       placeholder="주소 찾기: 도로명,건물명 또는 지번으로 검색 예)테헤란로152, 혹은 역삼동 737">
                                <label for="postCode">주소 찾기: 도로명, 건물명 또는 지번으로 검색 예) 테헤란로152</label>
                            </div>
                            <button class="btn btn-primary" type="button"
                                    onclick="execDaumPostcode()" value="우편번호 찾기"><i class="fas fa-search"></i>
                            </button>
                        </div>
                        <label for="address">주소</label>
                        <input type="text" id="address" name="address" class="form-control mb-2">
                        <label for="detailAddress">상세주소</label>
                        <input type="text" id="detailAddress" name="detailAddress" class="form-control mb-2">
                        <label for="phoneNumber">전화번호</label>
                        <input type="text" id="phoneNumber" name="phoneNumber" class="form-control mb-2">
                        <label for="email">이메일</label>
                        <input type="email" id="email" name="email" class="form-control mb-2">
                        <div class="col text-center">
                            <button type="button" onclick="confirmRegister()" class="btn btn-outline-primary">회원가입하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../footer.jsp" %>
</body>
</html>

<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("postCode").valueeeeeeee = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }

    function confirmRegister() {
        let memberUserName = $("#username").val();
        let memberPassword = $("#password").val();
        let memberNickname = $("#nickname").val();
        let memberName = $("#realName").val();
        let memberAddress = $("#address").val();
        let memberDetailAddress = $("#detailAddress").val();
        let memberPhoneNumber = $("#phoneNumber").val();
        let memberEmail = $("#email").val();

        if (memberUserName == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "아이디를 입력해주세요",
            }).then(() => {
                $("#username").focus();
            })
        } else if (memberPassword == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "비밀번호를 입력해주세요",
            }).then(() => {
                $("#password").focus();
            })
        } else if (memberNickname == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "닉네임을 입력해주세요",
            }).then(() => {
                $("#nickname").focus();
            })
        } else if (memberName == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "이름을 입력해주세요",
            }).then(() => {
                $("#realName").focus();
            })
        } else if (memberAddress == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "주소를 입력해주세요",
            }).then(() => {
                $("#address").focus();
            })
        } else if (memberDetailAddress == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "상세주소를 입력해주세요"
            }).then(() => {
                $("#detailAddress").focus();
            })
        } else if (memberPhoneNumber == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "전화번호를 입력해주세요"
            }).then(() => {
                $("#phoneNumber").focus();
            })
        } else if (memberEmail == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "이메일을 선택해주세요"
            }).then(() => {
                $("#email").focus();
            })
        } else {
            $("#registerForm").submit();
        }
    }
</script>