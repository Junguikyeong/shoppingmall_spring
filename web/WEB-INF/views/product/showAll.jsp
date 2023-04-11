<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
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
</head>
<body>
<%@include file="../header.jsp" %>
<div class="container">
    <div class="row mb-4">
        <div class="col-2"></div>

        <div class="col-lg-10 px-4">
            <div class="d-flex flex-column align-items-center justify-content-center bg-primary bg-opacity-50"
                 style="min-height: 200px">
                <h1 class="pt-3 text-dark" style="font-size: 40px">상품</h1>
                <c:if test="${category ne null}">
                    <div class="d-inline-flex">
                        <p>카테고리</p>
                        <p class="px-2">-</p>
                        <p>${category}</p>
                    </div>
                </c:if>
                <c:if test="${keyword ne null and list.isEmpty() eq false}">
                    <div class="d-inline-flex">
                        <p>검색</p>
                        <p class="px-2">-</p>
                        <p>${keyword}</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-2"></div>
        <div class="col-lg-10 px-4">
            <div class="row">
                <c:if test="${list.isEmpty()}">
                    <div class="col text-center" style="height: 460px">
                        <h2 class="my-5 text-dark">
                            '${keyword}${category}' 과 관련된 상품이 존재하지 않습니다!
                        </h2>
                    </div>
                </c:if>
                <c:forEach items="${list}" var="product">
                    <div class="col-lg-4 col-md-6 col-sm-12 pb-1">
                        <div class="card border-0 mb-4">
                            <div class="card-header border">
                                <a class="btn btn-sm text-dark p-0" href="/product/showOne/${product.id}">
                                    <img class="img-fluid" src="${product.imgPath}">
                                </a>
                            </div>
                            <div class="card-body text-center">
                                <h6 class="mb-2" style="height: 20px;">${product.name}</h6>
                                <h6>${product.price} &#8361</h6>
                            </div>
                            <div class="card-footer d-flex justify-content-between bg-light border">
                                <a class="btn btn-sm text-muted p-0" href="/product/showOne/${product.id}">
                                    <i class="fas fa-eye text-primary me-2"></i>상세보기
                                </a>
                                <a class="btn btn-sm text-muted p-0" href="">
                                    <i class="fas fa-heart text-primary me-2"></i>위시리스트
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${list.isEmpty() eq false}">
                <div class="row">
                    <ul class="pagination justify-content-center my-3">
                        <li class="page-item">
                            <a class="page-link" href="${pagingAddr}/1?keyword=${keyword}">&laquo</a>
                        </li>
                        <c:forEach var="i" begin="${paging.start}" end="${paging.end}">
                            <c:choose>
                                <c:when test="${i eq currentPage}">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="${pagingAddr}/${i}?keyword=${keyword}">${i}</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item">
                                        <a class="page-link" href="${pagingAddr}/${i}?keyword=${keyword}">${i}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <li class="page-item">
                            <a class="page-link" href="${pagingAddr}/${paging.totalPage}?keyword=${keyword}">&raquo</a>
                        </li>
                    </ul>
                </div>
            </c:if>
        </div>
    </div>
</div>


<%@include file="../footer.jsp" %>
</body>
</html>
