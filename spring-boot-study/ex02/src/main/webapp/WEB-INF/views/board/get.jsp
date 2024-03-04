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
            <form id="replyForm" onSubmit="return false">
                  <div class="panel panel-default">
                      <div class="panel-heading">
                          <i class="fa fa-comments fa-fw"></i> Reply
                          <input type="text" name="reply" id="reply" style="width:60%;" />
                          <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
                      </div>
                      <div class="panel-footer"></div>
            	</div>
            </form>
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
                    //str += "            <small class=''>" + list[i].replyDateStr + "</small>";
                    //str += "            <small class=''>" + list[i].replyDate + "</small>";
                    str += "            <small class=''>" + replyService.displayTime(list[i].replyDate) + "</small>";
                    str += "        </div>";
                    str += "        <p id='reply-content-" + list[i].rno + "'>" + list[i].reply + "</p>" ;
                    /*
                    str += "        <div>" ;
                    //str += "            <button class='btn btn-primary' type='button' onClick='javascript: replyModify();'>수정</button>" ;
                    str += "            <button class='reply-update btn btn-primary' type='button' id='reply-update-" + list[i].rno + "' data-rno='" + list[i].rno + "'>수정</button>" ;
                    //str += "            <button class='btn btn-danger' type='button' onClick='javascript: replyDelete();'>삭제</button>" ;
                    str += "            <button class='reply-delete btn btn-danger' type='button' id='reply-delete-" + list[i].rno + "' data-rno='" + list[i].rno + "'>삭제</button>" ;
                    str += "        </div>";
                    */
                    str += "    </div>";
                    str += "</li>";
                }
                replyUL.html(str);

                $('.reply-update').on('click', function(e) {
                    $(this).removeClass("btn-primary");
                    $(this).addClass("btn-danger");

                    var rno = $(this).attr('data-rno');
                    $('#reply-delete-' + rno).remove();

                    const replyContent = $('#reply-content-' + rno).text();
                    $('#reply-content-' + rno).replaceWith( "<input type='text' id='reply-content-" + rno + "' value='" + replyContent + "'/ >");
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

        // 댓글 등록 처리
        $('#addReplyBtn').on("click", function(e) {
            replyService.add(
                { reply: $('#reply').val(), replyer:"tester", bno: bnoValue },
                function(result) {
                    console.log("등록 Result: " + result);

                    var str = '';
                    str += "<li id='reply-row-" + result + "' data-rno='" + result + "' >";
                    str += "    <div>";
                    str += "        <div class=''>";
                    str += "            <strong class=''>tester</strong>";
                    str += "            <small class=''>" + replyService.displayTime(new Date().getTime())+ "</small>";
                    str += "        </div>";
                    str += "        <p id='reply-content-" + result + "'>" + $('#reply').val() + "</p>" ;
                    str += "    </div>";
                    str += "</li>";

                    replyUL.append(str);
                    $('#reply').val('');
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
</script>
<%@ include file="../includes/footer.jsp" %>