package com.donut.prokindonutsweb.service.member;

import com.donut.prokindonutsweb.dto.member.MemberAccountDTO;
import com.donut.prokindonutsweb.mappers.member.MemberMapper;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@Log4j2
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
    private final ModelMapper modelMapper;
    private final MemberMapper memberMapper;

    /*
    * memberaccount table의 member를 조회하는 메서드
    * List<vo>->List<dto>->optional<List<dto>>
    * */
    @Override
    public Optional<List<MemberAccountDTO>> findMember() {
        List<MemberAccountVO> memberVOList = memberMapper.selectMember();
        List<MemberAccountDTO> memberDTOList = memberVOList.stream()
                .map(member -> modelMapper.map(member, MemberAccountDTO.class)).toList();
        return Optional.ofNullable(memberDTOList.isEmpty() ? null : memberDTOList);
    }

    @Override
    public void saveMember(MemberAccountDTO memberAccountDTO) {
        MemberAccountVO memberAccountVO =  modelMapper.map(memberAccountDTO,MemberAccountVO.class);
        memberMapper.insertMember(memberAccountVO);
    }

    @Override
    public void updateMember(List<MemberAccountDTO> memberList) {
        List<MemberAccountVO> memberVOList = memberList.stream()
                .map(member -> modelMapper.map(member,MemberAccountVO.class)).toList();
        for (MemberAccountVO member : memberVOList) {
            memberMapper.updateMember(member);
        }
    }

    @Override
    public void deleteMember(List<String> memberList) {
        memberMapper.deleteMember(memberList);
    }
}
