package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {
    // 회원가입
    int insertMember(MemberVO memberVO);

    MemberVO selectByUserName(String username);
}
