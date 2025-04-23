package com.donut.prokindonutsweb.home.service;

import com.donut.prokindonutsweb.member.dto.MemberRequestDTO;

public interface SignupService {
    void saveMemberRequset(MemberRequestDTO memberRequestDTO);
     String memberRequestCode() ;

    }
