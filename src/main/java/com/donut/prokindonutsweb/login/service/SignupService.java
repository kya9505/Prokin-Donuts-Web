package com.donut.prokindonutsweb.login.service;

import com.donut.prokindonutsweb.member.dto.MemberRequestDTO;
import com.donut.prokindonutsweb.member.vo.MemberRequestVO;
import org.springframework.stereotype.Service;

public interface SignupService {
    void saveMemberRequset(MemberRequestDTO memberRequestDTO);
     String memberRequestCode() ;

    }
