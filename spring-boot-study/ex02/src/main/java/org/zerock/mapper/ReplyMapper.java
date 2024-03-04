package org.zerock.mapper;

import org.zerock.domain.ReplyVO;

import java.util.List;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.apache.ibatis.annotations.Param;

public interface ReplyMapper {
    public int insert(ReplyVO vo);
    public ReplyVO read(Long bno);
    public int readCurrval();
    public int delete(Long bno);
    public int update(ReplyVO reply);

    public List<ReplyVO> getListWithPaging(
            @Param("cri") Criteria cri,
            @Param("bno") Long bno);
}
