package com.donut.prokindonutsweb.security.dto;

import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import lombok.Data;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

@Data
public class CustomUserDetails implements UserDetails {

    private final MemberAccountVO member;

    public MemberAccountVO getUser() {
        return member;
    }
    public MemberAccountVO getMember() {
        return member;
    }
    //입력받은 아이디와 일치하는 객체

    //찾은 객체의 권한을 리스트로 반환
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(member.getAuthorityCode()));
    }

    @Override
    public String getPassword() {
        return member.getPassword();
    }

    @Override
    public String getUsername() {
        return member.getId();
    }
    public String getId() {
        return member.getId();
    }

    public String getMemberCode(){
        return member.getMemberCode();
    }
    public String getName(){
        return member.getName();
    }
    public String getPhoneNumber(){
        return member.getPhoneNumber();
    }
    public String getEmail(){
        return member.getEmail();
    }
    public String getAddress(){
        return member.getAddress();
    }







    //계정 활성 설정
    //(계정만료(로그인불가)
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
    //잠금(로그인불가)/
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
    //비밀번호만료(비밀번호 재설정)
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
    //계정활성(비활성-탈퇴))
    @Override
    public boolean isEnabled() {
        return true;
    }
}
