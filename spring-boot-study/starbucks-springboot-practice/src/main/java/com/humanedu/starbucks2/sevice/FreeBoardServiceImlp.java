package com.humanedu.starbucks2.sevice;

import com.humanedu.starbucks2.domain.FreeBoardVO;
import com.humanedu.starbucks2.mapper.BoardMapper;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class FreeBoardServiceImlp implements FreeBoardService {
    @Autowired
    private BoardMapper boardMapper;

    //검색
    @Override
    public List<FreeBoardVO> getTestList(String search){
       List<FreeBoardVO> freeBoardVOList = null;

       //
       if(search == null){
           freeBoardVOList = boardMapper.getFreeBoardList(search);
       } else{ //
           if(!search.equals("")){
               freeBoardVOList = boardMapper.getFreeBoardList(search);
           }
       }
       return freeBoardVOList;
    }

    // 등록
    @Override
    public int putTestInsert(String korName,
                             String subject,
                             String content,
                             List<String> fileNameList) {
       FreeBoardVO freeBoardVO = new FreeBoardVO();
       freeBoardVO.setName(korName);
       freeBoardVO.setSubject(subject);
       freeBoardVO.setContent(content);

        if (fileNameList != null) {
            //리스트의 크기(즉, 리스트에 저장된 요소의 수)를 계산하고, 그 값을 fileNameSize 변수에 저장
            int fileNameSize = fileNameList.size();
            if(fileNameSize >= 1) {
                freeBoardVO.setFile1Path(fileNameList.get(0));
            }
            if(fileNameSize >= 2) {
                freeBoardVO.setFile2Path(fileNameList.get(1));
            }
        }

        int rtn = boardMapper.putInsert(freeBoardVO);       // BoardMapper에서 가져오기
        return rtn;
    }

    // 수정
    @Override
    public FreeBoardVO selectFreeBoardOne(int num) {
        return boardMapper.getFreeBoardOne(num);
    }
    @Override
    public int updateFreeBoard(
            int num,
            String korName,
            String subject,
            String content,
            String file1Path,
            String file2Path
    ) {
        FreeBoardVO freeBoardVO = new FreeBoardVO();
        freeBoardVO.setNum(num);
        freeBoardVO.setName(korName);
        freeBoardVO.setSubject(subject);
        freeBoardVO.setContent(content);
        if (file1Path != "")
            freeBoardVO.setFile1Path(file1Path);
        if (file2Path != "")
            freeBoardVO.setFile2Path(file2Path);

        return boardMapper.updateFreeBoard(freeBoardVO);
    }

    // 삭제
    @Override
    public int delTestBoard(int num) {
        return boardMapper.delFreeBoard(num);
    }
}
