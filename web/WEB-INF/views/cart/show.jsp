<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
</head>
<body onload="totalAmount()">
<%@include file="../header.jsp" %>
<div class="container">
    <div class="row mb-4">
        <div class="col-2"></div>
        <div class="col-lg-10 px-4">
            <div class="d-flex flex-column align-items-center justify-content-center bg-primary bg-opacity-50"
                 style="min-height: 200px">
                <h1 class="pt-3 text-dark">카트에 담은 상품</h1>
            </div>

            <div class="row mt-5">
                <h4>카트</h4>
                <div class="col-lg-8 col-md-7">
                    <c:if test="${list.isEmpty()}">
                        <h2 class="my-3">현재 카트에 담긴 상품이 없습니다!</h2>
                    </c:if>
                    <c:forEach items="${list}" var="cartList">
                        <c:set var="amount" value="${cartList.productPrice * cartList.productCount}"/>
                        <div class="row mt-3 border-bottom">
                            <div class="col-lg-5 col-md-6">
                                <img class="img-fluid" src="${cartList.productImgPath}">
                            </div>
                            <div class="col-lg-7 col-md-6 d-flex flex-column justify-content-start">
                                <h4 class="mt-3">${cartList.productName}</h4>
                                <h6 class="text-muted">${cartList.productCategory}</h6>
                                <label for="productSelect${cartList.id}"></label>
                                <select class="form-select w-50 my-2" id="productSelect${cartList.id}"
                                        onchange="changeCount(${cartList.id},${cartList.productPrice},${logIn.id},${cartList.productId})">
                                    <option selected id="selected${cartList.id}" value="${cartList.productCount}">
                                            ${cartList.productCount}개
                                    </option>
                                    <option value="1">1개</option>
                                    <option value="2">2개</option>
                                    <option value="3">3개</option>
                                    <option value="4">4개</option>
                                    <option value="5">5개</option>
                                    <option value="6">6개</option>
                                    <option value="7">7개</option>
                                    <option value="8">8개</option>
                                    <option value="9">9개</option>
                                    <option value="10">10개</option>
                                </select>
                                <input type="hidden" name="productAmount${cartList.id}" value="${amount}"/>
                                <h5 id="productAmount${cartList.id}">${amount}원</h5>
                                <div class="d-inline-flex my-3">
                                    <a href="/">
                                        <h4 class="text-muted"><i class="fas fa-heart"></i></h4>
                                    </a>
                                    <a href="/cart/show?id=${cartList.memberId}"
                                       onclick="deleteProduct(${cartList.id},${cartList.memberId},${cartList.productId})">
                                        <h4 class="text-muted"><i class="fas fa-trash-alt ps-4"></i></h4>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="col-lg-4 col-md-5">
                    <div class="col pt-5 d-flex flex-column justify-content-center">
                        <h4 class="mt-1">주문 내역</h4>
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
                        <input id="totalProductVal" type="hidden" name="totalProductAmount" value=""/>
                        <input id="totalAmountVal" type="hidden" name="totalAmount" value=""/>

                        <form class="text-center" method="post" action="/cart/credit?memberId=${logIn.id}">
                            <c:forEach items="${list}" var="cartList">
                                <input type="hidden" name="creditProductId" value="${cartList.id}"/>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${list.isEmpty()}">
                                    <button class="btn btn-outline-primary w-75 mt-4" type="submit" disabled="disabled">구매하기</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-outline-primary w-75 mt-4" type="submit">구매하기</button>
                                </c:otherwise>
                            </c:choose>
                        </form>

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
    function deleteProduct(cartId, memberId, productId) {
        let data = {
            "cartId": cartId,
            "memberId": memberId,
            "productId": productId
        };

        $.ajax({
            url: "/cart/delete",
            type: "get",
            data: data
        })
    }

    function totalAmount() {
        let totalAmount = 0;
        <c:forEach items="${list}" var="cartList">
        let amount${list.indexOf(cartList)} = $("input[name=productAmount" + ${cartList.id} +"]");
        <%--console.log(amount${list.indexOf(cartList)}.val())--%>
        totalAmount += Number(amount${list.indexOf(cartList)}.val());
        </c:forEach>

        $("#totalProductVal").val(totalAmount);
        $("#totalProductAmount").text(totalAmount + "원");

        // 배송비 포함가격 배송비까지 진행할예정
        $("#totalAmountVal").val(totalAmount);
        $("#totalAmount").text(totalAmount + "원");
    }

    function changeCount(cartId, productPrice, memberId, productId) {
        let productSelect = $("#productSelect" + cartId + " option:selected");
        let selected = $("#selected" + cartId);
        let productAmount = $("#productAmount" + cartId);
        let productAmountInput = $("input[name=productAmount" + cartId + "]")

        let data = {
            "memberId": memberId,
            "productId": productId,
            "value": productSelect.val()
        };

        $.ajax({
            url: "/cart/countUpByValue",
            type: "post",
            data: data,
            success: function (message) {
                let result = JSON.parse(JSON.stringify(message));

                if (result.result == "success") {
                    // console.log(message);

                    selected.val(productSelect.val());
                    selected.text(productSelect.val() + "개");

                    productAmountInput.val(productPrice * productSelect.val());
                    productAmount.text(productPrice * productSelect.val() + " 원");
                    totalAmount()

                } else {
                    Swal.fire({
                        title: "카트 초과!!",
                        text: "카트에 담을 수 있는 수량을 초과했습니다. 카트를 확인하고 비워주세요."
                    });
                }
            }
        });
    }
</script>
