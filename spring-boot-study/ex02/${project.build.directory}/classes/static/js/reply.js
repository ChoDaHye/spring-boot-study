console.log('Reply Module...');

var replyService = (function() {
//    return { name: "AAAA" };

    // 댓글 등록 ajax 호출함수
    function replyAdd(reply, callback, error) {
        console.log("add reply...............");

        $.ajax({
            // request처리
            type : 'post',                                      // form의 method속성 값
            url : '/replies/new',                               // form의 action값
            data : JSON.stringify(reply),                       // json으로 string처리하면서 파라미터 전달
            contentType : "application/json; charset=utf-8",    // content-type지정
            // response처리
            success : function(result, status, xhr) {           // call 성공시 오는 처리되는 함수
                if (callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {                 // call 실패시 오는 처리되는 함수
                if (error) {
                    error(er);
                }
            }
        });
    }

    // 댓글 목록 함수
    function getList(param, callback, error) {
        var bno = param.bno;
        var page = param.page || 1;

        $.getJSON("/replies/board/" + bno + "/page/" + page + "/pagesize/3",       // get 전용 ajax함수
            function(data) {                                            // 호출 성공시 처리되는 함수
                if (callback) {
                    callback(data);
                }
        }).fail(
            function(xhr, status, err) {                                // 호출 실패시 처리되는 함수
                if (error) {
                    error();
                }
        });
    }

    // 댓글 삭제
    function remove(rno, callback, error) {
        $.ajax({
            type : 'delete',
            url : '/replies/' + rno,
            success : function(deleteResult, status, xhr) {
                if (callback) {
                    callback(deleteResult);
                }
            },
            error : function(xhr, status, er) {
                if (error) {
                    error(er);
                }
            }
        });
    }

    // 댓글 수정
    function update(reply, callback, error) {
        console.log("RNO: " + reply.rno);

        $.ajax({
            type : 'put',
            url : '/replies/' + reply.rno,
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            success : function(result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if (error) {
                    error(er);
                }
            }
        });
    }

    // 댓글 상세조회
    function get(rno, callback, error) {
		$.get("/replies/" + rno, function(result) {
			if (callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}

    function displayTime(timeValue) {
        var today = new Date();
        var replyDate =  new Date(timeValue);
        var replyDateTime = replyDate.getTime();        // 단위는 밀리세컨드

        var gap = today.getTime() - replyDateTime;
		var dateObj = new Date(replyDateTime);
		var str = "";
		if (gap < (1000 * 60 * 60 * 24)) {          // 24시간이 지나지 않은 날짜는 시분초로 표시
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');
		} else {                                    // 24시간이 지난 날짜는 년월일로 표시
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();

			return [ yy, '-', (mm > 9 ? '' : '0') + mm, '-',
					(dd > 9 ? '' : '0') + dd ].join('');
		}
    }

    return {
        add: replyAdd,
        getList: getList,
        remove: remove,
        update: update,
        get: get,
        displayTime: displayTime
    };       // replyAdd function의 내용이 나옴
})();