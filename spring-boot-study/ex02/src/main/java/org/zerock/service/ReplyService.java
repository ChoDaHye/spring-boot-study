package org.zerock.service;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import java.util.List;

public interface ReplyService {
    int register(ReplyVO vo);
    ReplyVO get(Long rno);
    int modify(ReplyVO vo);
    int remove(Long rno);
    List<ReplyVO> getList(Criteria cri, Long bno);
}
