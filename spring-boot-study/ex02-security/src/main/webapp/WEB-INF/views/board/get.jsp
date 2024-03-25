<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../includes/header.jsp" %>
    <div class="col-lg-7">
        <div class="p-5">
            <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">게시판 상세조회</h1>
            </div>
            <form action="/board/remove" method="post" id="form1" onSubmit="return false">
                <div class="form-group">
                    <label>Bno</label>
                    <input type="text" class="form-control" id="bno" name="bno" value='<c:out value="${board.bno}" />' readonly />
                </div>
                <div class="form-group">
                    <label>제목</label>
                    <input type="text" class="form-control" id="title" name="title" value='<c:out value="${board.title}" />' />
                </div>
                <div class="form-group">
                    <label>내용</label>
                    <textarea rows="5" class="form-control" id="content"  name="content" /><c:out value="${board.content}" /></textarea>
                </div>
                <div class="form-group">
                    <label>작성자</label>
                    <input type="text" class="form-control" id="writer"  name="writer" value='<c:out value="${board.writer}" />' readonly />
                </div>
                <!--
                <button class="btn btn-primary" type="button" onClick='location.href="/board/modify?bno=<c:out value="${board.bno}" />"'>
                -->
                <button class="btn btn-primary" type="button" onClick='javascript: boardModify();'>
                    수정하기
                </button>
                <button class="btn btn-info" type="button" onClick='location.href="/board/list"'>
                    목록
                </button>
                <button class="btn btn-danger" type="button" onClick='javascript: boardDelete();'>
                    삭제하기
                </button>
            </form>
            <!-- reply -->
            <hr>
            <div>댓글 </div>
            <hr>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-comments fa-fw"></i> Reply
                    <input type="text" name="reply" id="reply" style="width:60%;" />
                    <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
                </div>
                <div class="panel-footer"></div>
            </div>
            <hr>
            <div class="">
                <ul class="chat">

                </ul>
            </div>
        </div>
    </div>
</div>

<script src="/resources/js/reply.js"></script>
<script>
    console.log("================");
    console.log("JS TEST");

    const bnoValue = '<c:out value="${board.bno}" />';

    var replyUL = $(".chat");
    function showReplyList(pageNum) {          // 댓글 목록 가져와서 화면에 뿌려주는 함수 선언
        // 1. 댓글 목록 rest ajax로 가져오기
        replyService.getList(
            { bno: bnoValue, page: pageNum || 1 },
            function(list) {                      // ajax 함수 콜 성공시 처리
                var str = "";
                if(list == null || list.length == 0){       // 댓글 개수가 없을 경우
                    replyUL.html("");
                    return;
                }
                // 댓글 개수가 있을 경우
                for(var i = 0, len = list.length || 0; i < len; i++) {
                    str += "<li id='reply-row-" + list[i].rno + "' data-rno='" + list[i].rno + "' >";
                    str += "    <div>";
                    str += "        <div class=''>";
                    str += "            <strong class=''>" + list[i].replyer + "</strong>";
                    str += "            <small class=''>" + replyService.displayTime(list[i].replyDate) + "</small>";
                    str += "        </div>";
                    str += "        <p id='reply-content-" + list[i].rno + "'>" + list[i].reply + "</p>" ;
                    str += "        <p id='reply-content-backup-" + list[i].rno + "' style='display: none;'>" + list[i].reply + "</p>" ;
                    str += "        <div>" ;
                    str += "            <button class='reply-update btn btn-primary' type='button' id='reply-update-" + list[i].rno + "' data-rno='" + list[i].rno + "'>수정</button>" ;
                    str += "            <button class='reply-delete btn btn-danger' type='button' id='reply-delete-" + list[i].rno + "' data-rno='" + list[i].rno + "' onClick='replyDelete(" + list[i].rno + ")'>삭제</button>" ;
                    str += "            <button class='reply-cancel btn btn-danger' type='button' id='reply-cancel-" + list[i].rno + "' data-rno='" + list[i].rno + "' onClick='replyCancel(" + list[i].rno + ")' style='display: none;'>취소</button>" ;
                    str += "        </div>";
                    str += "    </div>";
                    str += "</li>";
                }
                replyUL.html(str);  // html 렌더링

                // 댓글 수정 버튼 처리
                $('.reply-update').on('click', function(e) {
                    var rno = $(this).attr('data-rno');         // 댓글 번호 가져오기

                    if ($(this).hasClass('btn-primary')) {          // 수정버튼이 파란색이라면
                        $(this).removeClass("btn-primary");     // 수정버튼 파란색 제거
                        $(this).addClass("btn-danger");         // 수정버튼 빨간색 변경

                        $('#reply-delete-' + rno).hide();                       // 삭제버튼 hide
                        $('#reply-cancel-' + rno).removeClass("btn-danger");    // 취소버튼 빨간색 제거
                        $('#reply-cancel-' + rno).addClass("btn-primary");      // 취소버튼 파란색 추가
                        $('#reply-cancel-' + rno).show();                       // 취소버튼 show

                        const replyContent = $('#reply-content-' + rno).text(); // 실제 댓글 내용 가져오기
                        $('#reply-content-' + rno).replaceWith( "<input type='text' id='reply-content-" + rno + "' value='" + (replyContent || $('#reply-content-' + rno).val()) + "' />");
                    } else {                                        // 수정버튼이 빨간색이라면
                        // 실제 마지막 수정 텍스트 값 저장
                        $('#reply-content-backup-' + rno).text($('#reply-content-' + rno).val());

                        replyUpdate(rno);                            // 실제 수정 처리
                    }
                });
            }
        );
    }
    showReplyList(1);                        // 댓글 목록 가져와서 화면에 뿌려주는 함수 실행

    //console.log('aaaaa', replyService);
    // for replyService add test(댓글 등록 테스트)
    /*
    replyService.add(
        { reply: "JS Test", replyer:"tester", bno: bnoValue },
        function(result) {
            alert("등록 Result: " + result);
        }
    );
    */

    // for replyService remove test(댓글 삭제 테스트)
    /*
    replyService.remove(
        21,
        function(count) {
            console.log('count:', count);
            if (count === "success") {
                alert("REMOVED");
            }
        },
        function(err) {
            alert('삭제 ERROR...');
        }
    );
    */

    // 처음 웹페이지 로딩될 때 실행
    $(document).ready(function() {
        console.log('replyService: ', replyService);

        /*
        // id가 openForm객체 태그 가져오기
        var operForm = $("#operForm");
        // 수정 버튼 클릭에 대한 리스너 설정
        $("button[data-oper='modify']").on("click", function(e){
            operForm.attr("action","/board/modify").submit();
        });
        */

        // 댓글 등록 버튼 이벤트 처리
        $('#addReplyBtn').on("click", function(e) {
            // 댓글 상자의 내용 값 가져오기
            const replyContent = $('#reply').val();
            // 댓글 작성자 하드코딩
            const replyerWriter = 'tester';
            // 댓글 작성시간
            const newReplyDate = new Date();

            // 댓글 등록 ajax호출
            replyService.add(
                { reply: replyContent, replyer: replyerWriter, bno: bnoValue },       // request data
                function(result) {                                              // callback after response
                    var str = "";
                    str += "<li id='reply-row-' data-rno='' >";
                    str += "    <div>";
                    str += "        <div class=''>";
                    str += "            <strong class=''>" + replyerWriter + "</strong>";
                    str += "            <small class=''>" + replyService.displayTime(newReplyDate.getTime()) + "</small>";
                    str += "        </div>";
                    str += "        <p id='reply-content-'>" + replyContent + "</p>" ;
                    str += "        <p id='reply-content-backup-' style='display: none;'>" + replyContent + "</p>" ;
                    str += "    </div>";
                    str += "    <div>";
                    str += "        <button class='reply-update btn btn-primary' type='button' id='reply-update-' data-rno='' onClick=''>수정</button>";
                    str += "        <button class='reply-delete btn btn-danger' type='button' id='reply-delete-' data-rno='' onClick=''>삭제</button>" ;
                    str += "        <button class='reply-cancel btn btn-danger' type='button' id='reply-cancel-' data-rno='' onClick='replyCancel()' style='display: none;'>취소</button>";
                    str += "    </div>";
                    str += "</li>";

                    replyUL.append(str);        // 댓글 화면 출력
                    $('#reply').val('');        // 댓글 등록 상자 내용 초기화
                }
            );
        });
    });

    function boardModify() {
        const form1 = document.getElementById('form1');
        form1.action = "/board/modify";

        form1.submit();
    }

    function boardDelete() {
        const form1 = document.getElementById('form1');
        form1.action = "/board/remove";

        form1.submit();
    }

    // 댓글 취소 버튼 처리
    function replyCancel(replyNum) {
        $('#reply-update-' + replyNum).removeClass("btn-danger");       // 빨간색 제거
        $('#reply-update-' + replyNum).addClass("btn-primary");         // 파란색 추가

        $('#reply-delete-' + replyNum).show();
        $('#reply-cancel-' + replyNum).hide();

        var replyContent = '';
        if($('#reply-update-' + replyNum).hasClass("btn-primary")) {            // 수정 버튼이 파란색일 경우
            replyContent = $('#reply-content-backup-' + replyNum).text();       // 원래 값으로 세팅
        } else {                                                                // 수정 버튼이 빨간색일 경우
            replyContent = $('#reply-content-' + replyNum).val();               // 바뀐 값으로 세팅
        }

        $('#reply-content-' + replyNum).replaceWith("<p id='reply-content-" + replyNum + "'>" + replyContent + "</p>");
    }

    // 댓글 삭제 버튼 처리
    function replyDelete(replyNum) {
        replyService.remove(                        // 백엔드에 ajax로 실제 db로 삭제
            replyNum,
            function(count) {
                console.log('count:', count);
                if (count === "success") {
                    //alert("REMOVED");
                }
            },
            function(err) {
                alert('삭제 ERROR...');
            }
        );

        $('#reply-row-' + replyNum).remove();       // 화면에 삭제처리
    }

    // 댓글 수정 버튼 실제 처리
    function replyUpdate(replyNum) {
        replyService.update(                        // 백엔드에 ajax로 실제 db로 수정
            { rno: replyNum, bno: bnoValue, reply: $('#reply-content-' + replyNum).val() },
            function(result) {
                $('#reply-content-backup-' + replyNum).text($('#reply-content-' + replyNum).val());

                replyCancel(replyNum);                      // 수정 성공 후 화면 처리는 취소 처리 버튼과 같음
            },
            function(err) {
                alert('수정 ERROR...');
            }
        );
    }

    // 현재 스크롤 위치 저장
    var lastScroll = 0;
    var replyPage = 2;
    const replyTotalCount = <c:out value="${replyTotalCount}" />;
    const replyMaxPageNum = Math.floor(replyTotalCount / 3) + 1;

    $(document).scroll(function(e) {        // 스크롤 이벤트 리스너
        //console.log('test1', test1++);

        var currentScroll = $(this).scrollTop();        // 현재 높이 저장
        //console.log('currentScroll', currentScroll);
        var documentHeight = $(document).height();      // 전체 문서의 높이
        //console.log('documentHeight', documentHeight);

        // 현재 스크롤된 높이값
        var nowHeight = $(this).scrollTop() + $(window).height();
        //console.log('nowHeight', nowHeight);

        // 스크롤이 아래로 내려갔을때 만 해당 이벤트 진행
        if(currentScroll > lastScroll) {
            // nowHeight값이 현 화면의 끝이 어디까지 내려왔는지 파악 가능 -> 전체 문서의 높이에 일정량 근접했을 댓글 리스트 더 가져오기
            if((documentHeight < (nowHeight + (documentHeight * 0.1))) && replyPage <= replyMaxPageNum) {
                //console.log("내려왔나? currentScroll", currentScroll);

                // ajax로 댓글 개수 더 가져오기
                replyService.getList(
                    { bno: bnoValue, page: replyPage++ || 1 },
                    function(list) {                      // ajax 함수 콜 성공시 처리
                        //console.log('list', list);

                        var str = "";
                        for(var i = 0, len = list.length || 0; i < len; i++) {
                            str += "<li id='reply-row-" + list[i].rno + "' data-rno='" + list[i].rno + "' >";
                            str += "    <div>";
                            str += "        <div class=''>";
                            str += "            <strong class=''>" + list[i].replyer + "</strong>";
                            str += "            <small class=''>" + replyService.displayTime(list[i].replyDate) + "</small>";
                            str += "        </div>";
                            str += "        <p id='reply-content-" + list[i].rno + "'>" + list[i].reply + "</p>" ;
                            str += "        <p id='reply-content-backup-" + list[i].rno + "' style='display: none;'>" + list[i].reply + "</p>" ;
                            str += "        <div>" ;
                            str += "            <button class='reply-update btn btn-primary' type='button' id='reply-update-" + list[i].rno + "' data-rno='" + list[i].rno + "' onClick=''>수정</button>" ;
                            str += "            <button class='reply-delete btn btn-danger' type='button' id='reply-delete-" + list[i].rno + "' data-rno='" + list[i].rno + "' onClick='replyDelete(" + list[i].rno + ")'>삭제</button>" ;
                            str += "            <button class='reply-cancel btn btn-danger' type='button' id='reply-cancel-" + list[i].rno + "' data-rno='" + list[i].rno + "' onClick='replyCancel(" + list[i].rno + ")' style='display: none;'>취소</button>" ;
                            str += "        </div>";
                            str += "    </div>";
                            str += "</li>";
                        }
                        replyUL.append(str);        // 댓글 화면 출력

                        // 댓글 수정 버튼 처리
                        $('.reply-update').on('click', function(e) {
                            var rno = $(this).attr('data-rno');

                            $(this).removeClass("btn-primary");     // 수정버튼 파란색 제거
                            $(this).addClass("btn-danger");         // 수정버튼 빨간색 변경

                            $('#reply-delete-' + rno).hide();                       // 삭제버튼 hide
                            $('#reply-cancel-' + rno).removeClass("btn-danger");    // 취소버튼 빨간색 제거
                            $('#reply-cancel-' + rno).addClass("btn-primary");      // 취소버튼 파란색 추가
                            $('#reply-cancel-' + rno).show();                       // 취소버튼 show

                            const replyContent = $('#reply-content-' + rno).text();
                            $('#reply-content-' + rno).replaceWith( "<input type='text' id='reply-content-" + rno + "' value='" + (replyContent || $('#reply-content-' + rno).val()) + "' />");
                        });
                    }
                );
            }
        }

        lastScroll = currentScroll;
    });
</script>
<%@ include file="../includes/footer.jsp" %>