package com.donut.prokindonutsweb.mappers.member;


import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

public interface MemberMapper{
    List<MemberAccountVO> selectMember();
    void insertMember(MemberAccountVO memberVO);
    void updateMember(MemberAccountVO memberVO);
    void deleteMember(@Param("list") List<String> memberList);
    String memberCode();

}
