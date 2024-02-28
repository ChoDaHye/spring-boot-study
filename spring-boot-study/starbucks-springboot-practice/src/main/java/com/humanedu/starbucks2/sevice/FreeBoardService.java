package com.humanedu.starbucks2.sevice;

import com.humanedu.starbucks2.domain.FreeBoardVO;

import java.util.List;

public interface FreeBoardService  {
    List<FreeBoardVO> getTestList(String search);   // 검색
    int putTestInsert(String korName,               // 등록
                      String subject,
                      String content,
                      List<String> fileNameList);

    FreeBoardVO selectFreeBoardOne(int num);         // 상세조회

    int updateFreeBoard(int num,                     // 수정
                        String korName,
                        String subject,
                        String content,
                        String file1Path,
                        String file2Path);

    int delTestBoard(int num);                      // 삭제
}
