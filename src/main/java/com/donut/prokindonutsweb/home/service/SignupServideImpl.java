package com.donut.prokindonutsweb.home.service;

import com.donut.prokindonutsweb.member.dto.MemberRequestDTO;
import com.donut.prokindonutsweb.member.mapper.MemberRequestMapper;
import com.donut.prokindonutsweb.member.vo.MemberRequestVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

@Service
@Log4j2
@RequiredArgsConstructor
public class SignupServideImpl implements SignupService{
    private final ModelMapper modelMapper;
    private final MemberRequestMapper requestMapper;

    //회원가입 요청 객체
    @Override
    public void saveMemberRequset(MemberRequestDTO memberRequestDTO) {
        MemberRequestVO memberRequestVO = modelMapper.map(memberRequestDTO,MemberRequestVO.class);
        memberRequestVO.setRequestCode(memberRequestCode());
        requestMapper.insertRequestMember(memberRequestVO);
    }

    //회원가입시 요청코드 발급 메서드
    @Override
    public String memberRequestCode() {
        String memberRequestCode = requestMapper.requestCode();
        int number = Integer.parseInt(memberRequestCode.replaceAll("\\D", ""));
        return "RQ"+(number+1);
    }
}
