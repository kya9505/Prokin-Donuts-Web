package com.donut.prokindonutsweb.mappers.member;


import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

public interface MemberMapper{
    List<MemberAccountVO> selectMember();
    void insertMember(MemberAccountVO memberVO);
    void updateMember(@Param("list") List<MemberAccountVO> memberVOList);
    void deleteMember(String memberCode);
}
