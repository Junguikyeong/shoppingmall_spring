<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>주문결제</title>
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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body onload="totalAmount()">
<%@include file="../header.jsp" %>
<div class="container">
    <div class="row mb-4">
        <div class="col-2"></div>
        <div class="col-lg-10 px-4">
            <div class="d-flex flex-column align-items-center justify-content-center bg-primary bg-opacity-50"
                 style="min-height: 200px">
                <h1 class="pt-3 text-dark">결제하기</h1>
            </div>

            <div class="row mt-5">
                <div class="col-lg-7">
                    <h4 class="mb-4">배송 옵션</h4>
                    <div class="row">
                        <div class="d-flex flex-column justify-content-center">
                            <form id="orderForm" method="post" action="/order/creditComplete" class="form-group">
                                <input type="hidden" id="memberId" name="memberId" value="${logIn.id}"/>
                                <div class="col-6 form-floating mb-3">
                                    <input type="text" class="form-control" id="realName" name="realName" value="${logIn.realName}"
                                           placeholder="이름(성까지 입력)">
                                    <label for="realName">이름(성까지 입력)</label>
                                </div>

                                <div class="input-group mb-3 w-75">
                                    <div class="col-10 form-floating">
                                        <input type="text" class="form-control" name="postcode" id="postCode"
                                               placeholder="주소 찾기: 도로명,건물명 또는 지번으로 검색 예)테헤란로152, 혹은 역삼동 737">
                                        <label for="postCode">주소 찾기: 도로명, 건물명 또는 지번으로 검색 예) 테헤란로152</label>
                                    </div>
                                    <button class="btn btn-primary" type="button"
                                            onclick="execDaumPostcode()" value="우편번호 찾기"><i class="fas fa-search"></i>
                                    </button>
                                </div>

                                <div class="col-9 form-floating mb-3">
                                    <input class="form-control" type="text" id="address" name="address" value="${logIn.address}"
                                           placeholder="주소">
                                    <label for="address">주소</label>
                                </div>
                                <div class="col-9 form-floating mb-3">
                                    <input class="form-control" type="text" id="detailAddress" name="detailAddress" value="${logIn.detailAddress}"
                                           placeholder="상세주소">
                                    <label for="detailAddress">상세주소</label>
                                </div>

                                <div class="d-inline-flex justify-content-between">
                                    <div class="col-6 form-floating mb-3 me-2 d-flex">
                                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${logIn.phoneNumber}"
                                               placeholder="전화번호">
                                        <label for="phoneNumber">전화번호</label>
                                    </div>
                                    <div class="col-6 form-floating mb-3 ms-2 d-flex">
                                        <input type="email" class="form-control" id="email" name="email" value="${logIn.email}"
                                               placeholder="이메일">
                                        <label for="email">이메일</label>
                                    </div>
                                </div>
                                <button type="button" class="col-lg-10 btn btn-outline-primary my-3"
                                        onclick="confirmOrder()">주문결제
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="col d-flex flex-column justify-content-center">
                        <h4 class="mt-1">장바구니</h4>
                        <div class="row justify-content-between">
                            <h6 class="col my-2">상품금액</h6>
                            <p class="col my-2" id="totalProductAmount"></p>
                        </div>
                        <div class="row justify-content-between">
                            <h6 class="col">배송비</h6>
                            <p class="col">무료</p>
                        </div>
                        <div class="row justify-content-between border-bottom border-top border-2">
                            <h6 class="col my-3">총 결제 금액</h6>
                            <h5 class="col my-3" id="totalAmount"></h5>
                        </div>
                        <div class="col-12">
                            <c:forEach items="${list}" var="cartList">
                                <c:set var="amount" value="${cartList.productPrice * cartList.productCount}"/>
                                <div class="row mt-3 border-bottom">
                                    <div class="col-lg-5 col-md-6">
                                        <img class="img-fluid" src="${cartList.productImgPath}">
                                    </div>
                                    <div class="col-lg-7 col-md-6 d-flex flex-column justify-content-start">
                                        <h6 class="mt-3 mb-1">${cartList.productName}</h6>
                                        <h6 class="text-muted mb-1">${cartList.productCategory}</h6>
                                        <h6 class="mb-1">수량: ${cartList.productCount} / ${cartList.productPrice}원</h6>
                                        <input type="hidden" name="productAmount${cartList.id}" value="${amount}"/>
                                        <h6 id="productAmount${cartList.id}">${amount}원</h6>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../footer.jsp" %>
</body>
</html>
<script>
    function totalAmount() {
        let totalAmount = 0;
        <c:forEach items="${list}" var="cartList">
        let amount${list.indexOf(cartList)} = $("input[name=productAmount" + ${cartList.id} +"]");

        totalAmount += Number(amount${list.indexOf(cartList)}.val());
        </c:forEach>

        $("#totalProductVal").val(totalAmount);
        $("#totalProductAmount").text(totalAmount + "원");

        // 배송비 포함가격 배송비까지 진행할예정
        $("#totalAmountVal").val(totalAmount);
        $("#totalAmount").text(totalAmount + "원");
    }

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

    function confirmOrder() {
        let memberName = $("#realName").val();
        let memberAddress = $("#address").val();
        let memberDetailAddress = $("#detailAddress").val();
        let memberPhoneNumber = $("#phoneNumber").val();
        let memberEmail = $("#email").val();

        if (memberName == "") {
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
            $("#orderForm").submit();
        }
    }
</script>