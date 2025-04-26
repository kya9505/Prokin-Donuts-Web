package com.donut.prokindonutsweb.member.service;

import com.donut.prokindonutsweb.home.mapper.FindIdMapper;
import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;
import com.donut.prokindonutsweb.member.mapper.MemberMapper;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
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
    private final FindIdMapper findMapper;

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
        memberAccountVO.setMemberCode(memberCode(memberAccountVO.getAuthorityCode()));
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

    @Override
    public String memberCode(String authorityCode) {
        String memberCode = memberMapper.memberCode();
        int number = Integer.parseInt(memberCode.replaceAll("\\D", ""));
        return authorityCode + (number+1);
    }

    @Override
    public int memberIdCheck(String id) {
        return memberMapper.memberIdCheck(id);
    }

    @Override
    public int memberEmailCheck(String email){
        return memberMapper.memberEmailCheck(email);
    }

    @Override
    public void updateByMember(String userid ,MemberAccountDTO dto){
        MemberAccountVO updateMember = modelMapper.map(dto,MemberAccountVO.class);
        MemberAccountVO uservo = findMapper.searchId(userid);
        updateMember.setMemberCode(uservo.getMemberCode());
        updateMember.setAuthorityCode(uservo.getAuthorityCode());
        memberMapper.updateMember(updateMember);
    }

    @Override
    public void deleteByMember(String id){
        List<String> memberList = List.of(id);
        memberMapper.deleteMember(memberList);
    }

}
