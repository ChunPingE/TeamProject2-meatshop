<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<title>커스터머 상품목록</title>
</head>
<body>
	<my:navBar />

	<my:alert />

	<div class="container-lg">
		<div class="d-flex">
			<div class="me-auto">
				<h1>커스터머 상품목록</h1>
			</div>

			<div>
				<form id="form1" action="/admin/product/list" class="d-flex" role="search">
					<div class="input-group">
						<select class="form-select flex-grow-0" style="width: 120px;" name="type">
							<option value="all">전체</option>
							<option value="productName" ${param.type eq 'productName' ? 'selected' : ''}>상품명</option>
							<option value="countryOfOrigin" ${param.type eq 'countryOfOrigin' ? 'selected' : ''}>원산지</option>
							<option value="categoryName" ${param.type eq 'categoryName' ? 'selected' : ''}>카테고리</option>
						</select>
						<input name="search" class="form-control" type="search" placeholder="Search" aria-label="Search" value="${param.search }">
						<c:if test="${not empty param.stockQuantity}">
							<input type="hidden" name="stockQuantity" value="100">
						</c:if>
						<button class="btn btn-outline-success" type="submit">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
				</form>
			</div>
			<div class="ms-5">
				<a class="btn btn-primary" href="/admin/product/reg">상품등록</a>
			</div>
			<div class="ms-3">
				<form id="form2" action="/admin/product/list" method="get">
					<c:if test="${not empty param.type}">
						<input type="hidden" id="productName" name="search" value="${param.search}">
					</c:if>
					<c:if test="${not empty param.search}">
						<input type="hidden" id="productName" name="type" value="${param.type}">
					</c:if>
					<input type="hidden" name="stockQuantity" value="100">
					<button class="btn btn-primary" type="submit">100개 이하의 상품 보기</button>
				</form>
			</div>
		</div>

		<table class="table">
			<thead>
				<tr>
					<th>상품ID</th>
					<th>사진</th>
					<th>상품명</th>
					<th>원산지</th>
					<th>재고</th>
					<th>카테고리</th>
					<th>가격</th>
					<th>상세페이지</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${productList}" var="product">
					<tr>
						<td>${product.productId }</td>
						<td>
							<img alt="사진준비중" src="${bucketUrl}/product/1.png" width="100" height="100">
							<!-- <img alt="사진준비중" src="${bucketUrl}/product/${product.productId}/main.png" width="100" height="100"> -->
						</td>
						<td>${product.productName}</td>
						<td>${product.countryOfOrigin}</td>
						<td>${product.stockQuantity}</td>
						<td>${product.categoryName}</td>
						<td>${product.price}</td>
						<td>
							<a class="btn btn-secondary" href="/customer/product/detail/${product.productId}">상세보기</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="container-lg">
		<div class="row">
			<div class="d-flex justify-content-end">
				<input id="pubBtn" type="button" class="btn btn-primary" name="cmd" value="일괄공개">
			</div>
		</div>
	</div>

	<div class="container-lg">
		<div class="row">
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">

					<c:if test="${pageInfo.currentPageNumber ne 1}">
						<li class="page-item">
							<c:url value="/admin/product/list" var="pageLink">
								<c:param name="page" value="1" />
								<c:if test="${not empty param.type}">
									<c:param name="type" value="${param.type}" />
								</c:if>
								<c:if test="${not empty param.search}">
									<c:param name="search" value="${param.search}" />
								</c:if>
								<c:if test="${not empty param.stockQuantity}">
									<c:param name="stockQuantity" value="${param.stockQuantity}" />
								</c:if>
							</c:url>
							<a class="page-link" href="${pageLink}">첫페이지로</a>
						</li>
					</c:if>


					<c:if test="${pageInfo.leftPageNumber gt 1}">
						<li class="page-item">
							<c:url value="/admin/product/list" var="pageLink">
								<c:param name="page" value="${pageInfo.prevPageNumber}" />
								<c:if test="${not empty param.type}">
									<c:param name="type" value="${param.type}" />
								</c:if>
								<c:if test="${not empty param.search}">
									<c:param name="search" value="${param.search}" />
								</c:if>
								<c:if test="${not empty param.stockQuantity}">
									<c:param name="stockQuantity" value="${param.stockQuantity}" />
								</c:if>
							</c:url>
							<a class="page-link" href="${pageLink}">이전</a>
						</li>
					</c:if>

					<c:forEach begin="${pageInfo.leftPageNumber}" end="${pageInfo.rightPageNumber }" var="pageNum">
						<li class="page-item">
							<c:url value="/admin/product/list" var="pageLink">
								<c:param name="page" value="${pageNum}" />
								<c:if test="${not empty param.type}">
									<c:param name="type" value="${param.type}" />
								</c:if>
								<c:if test="${not empty param.search}">
									<c:param name="search" value="${param.search}" />
								</c:if>
								<c:if test="${not empty param.stockQuantity}">
									<c:param name="stockQuantity" value="${param.stockQuantity}" />
								</c:if>
							</c:url>
							<a class="page-link ${pageNum eq pageInfo.currentPageNumber ? 'active' : '' }" href="${pageLink}">${pageNum}</a>
						</li>
					</c:forEach>

					<c:if test="${pageInfo.rightPageNumber lt pageInfo.lastPageNumber}">
						<li class="page-item">
							<c:url value="/admin/product/list" var="pageLink">
								<c:param name="page" value="${pageInfo.nextPageNumber}" />
								<c:if test="${not empty param.type}">
									<c:param name="type" value="${param.type}" />
								</c:if>
								<c:if test="${not empty param.search}">
									<c:param name="search" value="${param.search}" />
								</c:if>
								<c:if test="${not empty param.stockQuantity}">
									<c:param name="stockQuantity" value="${param.stockQuantity}" />
								</c:if>
							</c:url>
							<a class="page-link" href="${pageLink}">다음</a>
						</li>
					</c:if>

					<c:if test="${pageInfo.currentPageNumber ne pageInfo.lastPageNumber}">
						<li class="page-item">
							<c:url value="/admin/product/list" var="pageLink">
								<c:param name="page" value="${pageInfo.lastPageNumber}" />
								<c:if test="${not empty param.type}">
									<c:param name="type" value="${param.type}" />
								</c:if>
								<c:if test="${not empty param.search}">
									<c:param name="search" value="${param.search}" />
								</c:if>
								<c:if test="${not empty param.stockQuantity}">
									<c:param name="stockQuantity" value="${param.stockQuantity}" />
								</c:if>
							</c:url>
							<a class="page-link" href="${pageLink}">마지막페이지</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="/js/admin/product/pub.js"></script>
</body>
</html>