<%@ page import="com.bit.spring.model.MemberDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
    pageContext.setAttribute("logIn",logIn);
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary bg-opacity-50">
    <div class="container">
        <div class="navbar-collapse">
            <div class="col-lg-6 d-none d-lg-block">
                <div class="d-inline-flex align-items-center text-dark">
                    <i class="fas fa-envelope me-2"></i>junggunto4@gmail.com
                    <span class="px-2">|</span>🚀10만원 이상은 무료배송🚀
                </div>
            </div>
            <div class="col-lg-6 text-center text-lg-end">
                <c:choose>
                    <c:when test="${logIn eq null}">
                        <div class="d-inline-flex align-items-center">
                            <a class="nav-link text-dark me-2" href="/member/auth">
                                <i class="fas fa-user-alt me-2"></i>로그인
                            </a>
                            <a class="nav-link text-dark" href="/member/register">회원가입</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="d-inline-flex align-items-center">
                            <a class="nav-link text-dark me-2" href="/member/logOut">
                                <i class="fas fa-user-alt me-2"></i>로그아웃
                            </a>
                            <a class="nav-link text-dark" href="/">회원정보</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <nav class="navbar navbar-expand-lg navbar-light bg-white justify-content-center">
        <div class="col-3 d-none d-lg-block">
            <a class="navbar-brand" href="/">JUK SHOP</a>
        </div>
        <div class="col-6">
            <form id="search-form" class="input-group mb-0" action="/product/search/1" method="get">
                <input class="form-control" type="search" placeholder="Search" name="keyword">
                <button class="btn btn-secondary input-group-append" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>
        <div class="col-lg-3 col-6 text-end">
            <a class="btn btn-outline-light text-dark" href="/member/wishList">
                <i class="fas fa-heart"></i>
            </a>
            <a class="btn btn-outline-light text-dark" href="/cart/show?id=${logIn.id}">
                <i class="fas fa-shopping-cart"></i>
            </a>
        </div>
    </nav>
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-2 d-none d-lg-block">
            <div class="dropdown">
                <button class="btn bg-primary btn-outline-primary bg-opacity-50 text-dark dropdown-toggle"
                        type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-bars"></i>
                    <span>모든 상품</span>
                </button>
                <ul class="dropdown-menu show" aria-labelledby="dropdownMenuButton"
                    style="inset: 0 auto auto 0; margin: 0; transform: translate(0px, 41px);">
                    <li><a class="dropdown-item" href="/product/searchCategory/1?category=신발">신발</a></li>
                    <li><a class="dropdown-item" href="/product/searchCategory/1?category=옷">옷</a></li>
                    <li><a class="dropdown-item" href="/product/searchCategory/1?category=음식">음식</a></li>
                    <li><a class="dropdown-item" href="/product/searchCategory/1?category=주방">주방</a></li>
                    <li><a class="dropdown-item" href="/product/searchCategory/1?category=디지털">디지털</a></li>
                    <li><a class="dropdown-item" href="/product/searchCategory/1?category=가구">가구</a></li>
                </ul>
            </div>
        </div>
        <div class="col-lg-10 px-4">
            <nav class="navbar navbar-expand-lg navbar-light bg-white">
                <div class="container-fluid">
                    <a class="navbar-brand" href="/">Home</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="true"
                            aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="navbar-collapse collapse show" id="navbarCollapse">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="/product/showAll/1">상품</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">이벤트</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">특가</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">베스트</a>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="/product/register">상품등록</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">선물하기</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">고객센터</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>
</div>