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
<body>
<%@include file="../header.jsp" %>
<div class="container">
    <div class="row mb-4">
        <div class="col-2"></div>
        <div class="col-lg-10 px-4">
            <div class="d-flex flex-column align-items-center justify-content-center bg-primary bg-opacity-50"
                 style="min-height: 200px">
                <h1 class="pt-3 text-dark">상품 상세보기</h1>
                <div class="d-inline-flex">
                    <p>${product.category}</p>
                    <p class="px-2">-</p>
                    <p>${product.name}</p>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col-lg-7 col-md-6">
                    <img class="img-fluid" src="${product.imgPath}">
                </div>
                <div class="col-lg-5 col-md-6 d-flex flex-column justify-content-center">
                    <h4 class="mt-3">${product.name}</h4>
                    <p class="my-2">${product.category}</p>
                    <h5 class="my-2">${product.price}&#8361</h5>
                    <input type="hidden" id="memberId" value="${logIn.id}"/>
                    <input type="hidden" id="productId" value="${product.id}"/>

                    <c:choose>
                        <c:when test="${product.registeredMemberId eq logIn.id}">
                            <button class="btn btn-outline-primary" data-bs-target="#cartModal"
                                    onclick="countUp(${logIn.id},${product.id})" disabled="disabled">
                                <i class="fas fa-shopping-cart me-2"></i>카트에 담기
                            </button>
                            <button class="btn btn-outline-primary" disabled="disabled"><i class="fas fa-heart me-2"></i>위시리스트</button>
                        </c:when>
                        <c:otherwise>
                            <button class="btn btn-outline-primary" data-bs-target="#cartModal"
                                    onclick="countUp(${logIn.id},${product.id})">
                                <i class="fas fa-shopping-cart me-2"></i>카트에 담기
                            </button>
                            <button class="btn btn-outline-primary"><i class="fas fa-heart me-2"></i>위시리스트</button>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${product.registeredMemberId eq logIn.id}">
                        <div class="d-inline-flex justify-content-end">
                            <button class="btn btn-outline-info w-25 mt-3 me-1" type="button" onclick="location.href='/product/update?id=${product.id}'">수정</button>
                            <button class="btn btn-outline-danger w-25 mt-3" type="button" onclick="location.href='/product/delete?id=${product.id}'">삭제</button>
                        </div>
                    </c:if>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-10 col-12 my-5">
                    <p style="font-size: 20px">${product.description}</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="cartModalLabel">✔️장바구니 추가완료</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-5">
                        <img class="img-fluid" src="${product.imgPath}">
                    </div>
                    <div class="col-7 d-flex flex-column justify-content-center">
                        <h5 class="mt-3">${product.name}</h5>
                        <p>${product.category}</p>
                        <h5>${product.price}&#8361</h5>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id="cart" type="button" class="btn btn-secondary"
                        onclick="location.href='/cart/show?id=${logIn.id}'"></button>
                <button type="button" class="btn btn-primary" onclick="location.href='/order/show?id=${logIn.id}'">구매하기</button>
            </div>
        </div>
    </div>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>

<script>
    function countUp(memberId, productId){
        let data = {
            "memberId": memberId,
            "productId": productId
        };

        console.log(data)

        $.ajax({
            url: "/cart/countUp",
            type: "post",
            data: data,
            success: function (message) {
                let result = JSON.parse(JSON.stringify(message));
                console.log(result.count)

                if (result.result == "success") {
                    $("#cartModal").modal('show');
                    $("#cart").text("카트 ( " + result.count + " )");
                } else {
                    $("#cartModal").modal('hide');
                    Swal.fire({
                        title: "카트 초과!!",
                        text: "카트에 담을 수 있는 수량을 초과했습니다. 카트를 비워주세요.",
                        icon: "error"
                    });
                }
            }
        });
    }
</script>