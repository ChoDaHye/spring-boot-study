package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public int putMember(MemberVO memberVO) {
        memberVO.setRole("ROLE_USER");

        String rawPwd = memberVO.getPassword();
        String encryptPwd = bCryptPasswordEncoder.encode(rawPwd);   // 평문을 암호화
        memberVO.setPassword(encryptPwd);

        return memberMapper.insertMember(memberVO);
    }
}
