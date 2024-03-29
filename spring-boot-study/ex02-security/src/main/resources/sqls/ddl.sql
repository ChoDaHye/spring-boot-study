-- 게시판
create sequence seq_board
;

create table tbl_board (
  bno number(10,0),                     -- 게시판 번호
  title varchar2(200) not null,         -- 게시판 제목
  content varchar2(2000) not null,      -- 게시판 내용
  writer varchar2(50) not null,         -- 게시판 작성자
  regdate date default sysdate,         -- 게시판 작성날짜
  updatedate date default sysdate       -- 게시판 수정날짜
)
;

alter table tbl_board add constraint pk_board 
primary key (bno)
;


-- 게시판 댓글
create sequence seq_reply
;

create table tbl_reply (
    rno number(10, 0),                  -- 댓글 번호
    bno number(10, 0) not null,         -- 댓글에 연계된 게시판 번호
    reply varchar2(1000) not null,      -- 댓글 내용
    replyer varchar2(50) not null,      -- 댓글 작성자
    replyDate date default sysdate,     -- 댓글 작성날짜
    updateDate date default sysdate    -- 댓글 수정날짜
)
;

alter table tbl_reply add constraint pk_reply primary key (rno)
;

alter table tbl_reply add constraint fk_reply_board foreign key (bno)
references tbl_board (bno)
;

-- 회원 테이블
create sequence seq_member
;

create table tbl_member (
    mno number(10, 0),                  -- 회원번호
    username varchar2(50) unique not null,     -- 회원 아이디
    password varchar2(500) not null,     -- 회원 비밀번호
    email varchar2(255) unique not null,       -- 회원 이메일
    role varchar2(100) not null,        -- 회원 권한(접근 제어)
    createDate date default sysdate     -- 회원 생성날짜
)
;

alter table tbl_member add constraint pk_member primary key (mno)
;