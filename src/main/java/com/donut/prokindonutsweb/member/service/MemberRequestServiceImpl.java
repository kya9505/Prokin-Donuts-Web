package com.donut.prokindonutsweb.member.service;

import com.donut.prokindonutsweb.member.dto.MemberRequestDTO;
import com.donut.prokindonutsweb.member.mapper.MemberMapper;
import com.donut.prokindonutsweb.member.mapper.MemberRequestMapper;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import com.donut.prokindonutsweb.member.vo.MemberRequestVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
@Service
@Log4j2
@RequiredArgsConstructor
public class MemberRequestServiceImpl implements MemberRequestService {
    private final ModelMapper modelMapper;
    private final MemberRequestMapper requestMapper;
    private final MemberMapper memberMapper;
    private final MemberService memberService;

    //회원가입 요청 테이블 전체 조회
    @Override
    public Optional<List<MemberRequestDTO>> findRequestMember() {
        List<MemberRequestVO> memberRequestVOS = requestMapper.selectRequestMember();
        List<MemberRequestDTO> memberRequestDTOS = memberRequestVOS.stream()
                .map(memberRequestVO->modelMapper.map(memberRequestVO,MemberRequestDTO.class)).toList();
        return Optional.ofNullable(memberRequestDTOS.isEmpty()? null : memberRequestDTOS);
    }

    //회원가입 신청 시 사용 예정
    @Override
    public String memberRequestCode() {
        String memberRequestCode = requestMapper.requestCode();
        int number = Integer.parseInt(memberRequestCode.replaceAll("\\D", ""));
        return "RQ"+(number+1);
    }


    /*
    *회원가입요청 승인
    *트랜잭션(하나라도 실패시 롤백)
    *   요청상태를 승인으로 변경
    *           -> 승인처리된 요청객체를 회원객체로 맵핑
    *           -> 회원테이들에 삽입
    *           -> 요청테이블에서 삭제
    * */
    @Override
    @Transactional
    public void approvalMember(List<String> requestCodeList) {
        // 1. 승인 리스트에서 개별 요청 코드 조회
        requestCodeList.stream().forEach(requestCode -> {
            // 2. 요청 코드에 해당하는 객체 조회
            MemberRequestVO memberRequestVO = requestMapper.selectByMemberRequest(requestCode);
            // 3. 요청 코드에 해당하는 객체의 요청 상태를 "승인"으로 변경
            requestMapper.approvalMember(memberRequestVO.getRequest());
            //4. 조회한 요청객체를 회원객체로 mapping
            MemberAccountVO memberAccountVO = MemberAccountVO.builder()
                    .memberCode(memberService.memberCode("FM"))
                    .authorityCode("FM")
                    .name(memberRequestVO.getName())
                    .phoneNumber(memberRequestVO.getPhoneNumber())
                    .address(memberRequestVO.getAddress())
                    .email(memberRequestVO.getEmail())
                    .id(memberRequestVO.getId())
                    .password(memberRequestVO.getPassword()).build();
           //5. 회원 테이블에 해당 객체 삽입
            memberMapper.insertMember(memberAccountVO);
            //6. 요청 테이블에서 해당 객체 삭제
            requestMapper.deleteRequestMember(requestCode);
        });
    }
}
