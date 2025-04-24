package com.donut.prokindonutsweb.security.service;

import com.donut.prokindonutsweb.home.mapper.FindIdMapper;
import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Log4j2
public class UserDetailsServiceImpl implements UserDetailsService {
    private final ModelMapper mapper;
    private final FindIdMapper memberMapper;

    //입력 받은 아이디로 회원을 찾아 CustomUser객체로 저장
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        MemberAccountVO user = memberMapper.searchId(username);
        log.info("🌀 loadUserByUsername() 호출됨", new Throwable("loadUserByUsername trace"));
        if (user == null) {
            log.warn("❌ 존재하지 않는 아이디: {}", username);
            throw new UsernameNotFoundException("존재하지 않는 아이디");
        }

        log.info("✅ 로그인 유저 정보: {}", user);
        return new CustomUserDetails(user);
    }
}
