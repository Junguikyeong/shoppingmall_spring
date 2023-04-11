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
                <h1 class="pt-3 text-dark" style="font-size: 40px">상품 등록 및 수정</h1>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-2"></div>
        <div class="col-lg-10 px-4">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10 col-sm-12 pb-1">

                    <form id="upsertForm" action="/product/upload" method="post" enctype="multipart/form-data">
                        <c:choose>
                            <c:when test="${productDTO.id ne null}">
                                <input type="hidden" name="id" value="${productDTO.id}">
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="id" value="-1">
                            </c:otherwise>
                        </c:choose>
                        <input type="hidden" name="registeredMemberId" value="${logIn.id}">
                        <label for="name" class="text-dark">상품명</label>
                        <input id="name" name="name" type="text" class="form-control mb-2 w-50"
                               value="${productDTO.name}">
                        <label for="name" class="text-dark">카테고리</label>
                        <input id="category" name="category" type="text" class="form-control mb-2 w-75"
                               value="${productDTO.category}">
                        <label for="name" class="text-dark">가격</label>
                        <input id="price" name="price" type="number" class="form-control mb-2 w-75" min="0"
                               value="${productDTO.price}">
                        <label for="stock" class="text-dark">재고</label>
                        <input id="stock" name="stock" type="number" class="form-control mb-2 w-75" min="0"
                               value="${productDTO.stock}">
                        <label for="description" class="text-dark">상품 설명</label>
                        <textarea type="text" id="description" name="description" class="form-control mb-2"
                                  rows="8">${productDTO.description}</textarea>
                        <c:if test="${productDTO.imgPath.length() ne null}">
                            <img id="preview" class="img-fluid mb-2 w-75" src="${productDTO.imgPath}">
                        </c:if>
                        <img id="preview" class="img-fluid mb-2 w-75">
                        <input id="photo" name="uploadFile" type="file" class="form-control mb-2 w-75"
                               onchange="readURL(this)"
                               multiple/>

                        <div class="text-end">
                            <button id="upsertButton" class="btn btn-outline-primary mb-2" type="button"
                                    onclick="confirmUpsert()">등록 및 수정
                            </button>
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
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('preview').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            document.getElementById('preview').src = "";
        }
    }

    function confirmUpsert() {
        let productName = $("#name").val();
        let productCategory = $("#category").val();
        let productPrice = $("#price").val();
        let productStock = $("#stock").val();
        let productDescription = $("#description").val();
        let productPhoto = $("#photo").val();

        if (productName == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "상품명을 입력해주세요",
            }).then(()=>{
                $("#name").focus();
            })
        } else if (productCategory == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "상품 카테고리를 입력해주세요"
            }).then(() => {
                $("#category").focus();
            })
        } else if (productPrice == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "상품 가격을 입력해주세요",
            }).then((setTimeout) => {
                $("#price").focus();
            })
        } else if (productStock == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "상품 재고를 입력해주세요"
            }).then(() => {
                $("#stock").focus();
            })
        } else if (productDescription == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "상품 설명을 입력해주세요"
            }).then(() => {
                $("#description").focus();
            })
        } else if (productPhoto == "") {
            Swal.fire({
                position: "top",
                icon: "warning",
                text: "상품 사진을 선택해주세요"
            }).then(() => {
                $("#photo").focus();
            })
        } else {
            $("#upsertForm").submit();
        }
    }
</script>