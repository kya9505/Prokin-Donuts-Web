package com.donut.prokindonutsweb.member.mapper;


import com.donut.prokindonutsweb.member.vo.MemberRequestVO;
import java.util.List;

public interface MemberRequestMapper {
    void insertRequestMember(MemberRequestVO memberRequestVO);
    List<MemberRequestVO> selectRequestMember();
    void approvalMember(String requestCode);
    void deleteRequestMember(String requestCode);
    String requestCode();
    MemberRequestVO selectByMemberRequest(String requestCode);
    int requestEmailCheck(String email);
    int requestIdCheck(String id);
}
