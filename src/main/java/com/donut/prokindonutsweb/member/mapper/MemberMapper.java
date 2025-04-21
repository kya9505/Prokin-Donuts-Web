package com.donut.prokindonutsweb.member.mapper;


import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberMapper{
    List<MemberAccountVO> selectMember();
    void insertMember(MemberAccountVO memberVO);
    void updateMember(MemberAccountVO memberVO);
    void deleteMember(@Param("list") List<String> memberList);
    String memberCode();
    int memberIdCheck(String id);

}
