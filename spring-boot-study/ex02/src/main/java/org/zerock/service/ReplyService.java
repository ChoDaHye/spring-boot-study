package org.zerock.service;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import java.util.List;

public interface ReplyService {
    int register(ReplyVO vo);
    int getCurrVal();
    ReplyVO get(Long rno);
    int modify(ReplyVO vo);
    int remove(Long rno);
    int getTotalCount(Long bno);
    List<ReplyVO> getList(Criteria cri, Long bno);
}
