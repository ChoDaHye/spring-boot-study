package org.zerock.config.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

@Service
public class SpringSecPrincipalDetailsService implements UserDetailsService {
    @Autowired
    private MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("loadUserByUsername 메소드 호출");

        // DB에서 user정보를 가져옴.
        MemberVO memberVO = memberMapper.selectByUserName(username);
        if (memberVO == null) return null;

        return new SpringSecPrincipalDetails(memberVO);
    }
}
