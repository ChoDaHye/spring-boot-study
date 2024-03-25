package org.zerock.service;


import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;
import org.zerock.utils.DateTimeUtil;

import java.util.Date;
import java.util.List;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
    @Autowired
    private ReplyMapper mapper;

    @Override
    public int register(ReplyVO vo) {
        log.info("register......" + vo);
        return mapper.insert(vo);
     }

    @Override
    public ReplyVO get(Long rno) {
        log.info("get......" + rno);
        return mapper.read(rno);
    }

    @Override
    public int modify(ReplyVO vo) {
        log.info("modify......" + vo);
        return mapper.update(vo);

    }

    @Override
    public int remove(Long rno) {
        log.info("remove...." + rno);
        return mapper.delete(rno);
    }

    @Override
    public List<ReplyVO> getList(Criteria cri, Long bno) {
        log.info("get Reply List of a Board " + bno);

        List<ReplyVO> listWithPaging = mapper.getListWithPaging(cri, bno);
        listWithPaging.stream().forEach(replyVO -> {
            Date replyDate = replyVO.getReplyDate();

//            replyVO.setReplyDate();
            replyVO.setReplyDateStr(DateTimeUtil.formatDateTime(replyDate.toString()));
        });

        return listWithPaging;
    }

    @Override
    public int getTotalCount(Long bno) {
        return mapper.getCountByBno(bno);
    }

    @Override
    public int getCurrVal() {
        return mapper.readCurrval();
    }
}
