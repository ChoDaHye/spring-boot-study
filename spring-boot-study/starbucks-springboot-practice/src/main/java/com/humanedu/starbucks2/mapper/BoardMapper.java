package com.humanedu.starbucks2.mapper;

import com.humanedu.starbucks2.domain.FreeBoardVO;

import java.util.List;

public interface BoardMapper {
    List<FreeBoardVO> getFreeBoardList(String search);  // 검색
    int putInsert(FreeBoardVO freeBoardVO);             // 등록
    FreeBoardVO getFreeBoardOne(int num);               // 상세조회
    int updateFreeBoard(FreeBoardVO freeBoardVO);       // 수정
    int delFreeBoard(int num);                          // 삭제
}
