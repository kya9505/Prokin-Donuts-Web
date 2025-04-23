package com.donut.prokindonutsweb.security.service;

import com.donut.prokindonutsweb.home.mapper.FindIdMapper;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final FindIdMapper memberMapper;

    //입력 받은 아이디로 회원을 찾아 CustomUser객체로 저장
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        MemberAccountVO user = memberMapper.searchId(username);
        if(user != null) return new CustomUserDetails(user);
        throw  new UsernameNotFoundException("존재하지 않는 아이디");
    }
}
