package org.zerock.config.auth;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.zerock.domain.MemberVO;

import java.util.ArrayList;
import java.util.Collection;

public class SpringSecPrincipalDetails implements UserDetails {
    private MemberVO memberVO;

    public SpringSecPrincipalDetails(MemberVO memberVO) {
        this.memberVO = memberVO;
    }

    public MemberVO getMemberVO() {
        return memberVO;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collect = new ArrayList<>();
        collect.add(() -> {
            return memberVO.getRole();      // ROLE_ADMIN 문자열을 가져온다
        });

        return collect;
    }

    @Override
    public String getPassword() {
        return memberVO.getPassword();
    }

    @Override
    public String getUsername() {
        return memberVO.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
