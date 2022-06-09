<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>BookHub :: 독서활동 기록</title>
    <link rel="stylesheet" href="/static/css/rlog/book.css">
</head>

<body>
    <!-- ReadingLog -->
    <div id="readinglog-wrapper">
        <!-- ReadingLog Head -->
        <div id="readinglog-head-wrapper">
            <div id="readinglog-head">
                <img id="book-thumbnail" src="${bookInfo.get('cover')}">
                <div id="book-title">
                    <a href="/bookdetail?isbn=${param.isbn}">${bookInfo.get('title')}</a>
                </div>
                <div id="book-progress">
                    <div id="book-progresslabel">
                        <fmt:formatNumber value="${readingLogSum/bookInfo.get('subInfo').get('itemPage')}"
                            type="percent" var="percentReadPage" />
                        <div id="progress-readpercent">${percentReadPage}</div>
                        <div id="progress-readlabel">독서 진행도</div>
                        <div id="progress-readpage">
                            <c:if test="${empty readingLogSum}">0</c:if>
                            <c:if test="${!emptyreadingLogSum}">${readingLogSum}</c:if>
                            /${bookInfo.get('subInfo').get('itemPage')}
                        </div>
                    </div>
                    <progress id="book-progressbar" value="${readingLogSum}"
                        max="${bookInfo.get('subInfo').get('itemPage')}"></progress>
                </div>
            </div>
        </div>
        <!-- ReadingLog Button -->
        <div id="readinglog-buttons">
            <a href="/rlog/library"><input id="book-librarybtn" class="book-menubtn" type="button"
                    value="📚 내 서재"></a>
            <input id="book-writebtn" class="book-menubtn" type="button" value="📝 새 독서기록 작성">
            <input id="book-alldeletebtn" class="book-menubtn" type="button"
                onclick="deleteAllReadingLog('${param.isbn}')" value="모든 독서기록 삭제">
        </div>

        <!-- ReadingLog Book -->
        <div id="readinglog-body">
            <div id="book-content">
                <c:if test="${empty readingLog}">
                    <div class="book-item">
                        <span class="no-book-item">아직 독서활동을 기록하지 않았습니다.</span>
                    </div>
                </c:if>
                <c:if test="${!empty readingLog}">
                    <c:set var="pageCount" value="${readingLogSum}" />
                    <c:forEach items="${readingLog}" var="log">
                        <div class="book-item">
                            <input class="book-optionbtn book-deletebtn" type="button"
                                onclick="deleteReadingLog('${log.bookISBN}', '${log.num}')" value="✖️ 삭제">
                            <input class="book-optionbtn book-editbtn" type="button" value="✏️ 수정">
                            <fmt:parseDate value="${log.readDate}" pattern="yyyy-MM-dd'T'HH:mm"
                                var="parsedReadDate" />
                            <span class="book-readdate">
                                <fmt:formatDate pattern="yyyy년 M월 d일" value="${parsedReadDate}" />
                            </span>
                            <span class="book-readpage">
                                ${pageCount - log.readPage + 1} ~ ${pageCount} 페이지
                                (<fmt:formatNumber type="number" value="${log.readPage}"
                                    maxFractionDigits="3" />
                                페이지)
                                <c:set var="pageCount" value="${pageCount - log.readPage}" />
                            </span>
                            <c:if test="${!empty log.summary}">
                                <span class="book-summary">${log.summary}</span>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>

    <script src="/static/js/rlog/book.js"></script>
</body>

</html>