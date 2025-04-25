package com.donut.prokindonutsweb.member.mapper;


import com.donut.prokindonutsweb.member.vo.MemberRequestVO;
import java.util.List;

public interface MemberRequestMapper {
    List<MemberRequestVO> selectRequestMember();
    void insertRequestMember(MemberRequestVO memberRequestVO);
    void deleteRequestMember(String requestCode);
    void approvalMember(String requestCode);
    String requestCode();
    MemberRequestVO selectByMemberRequest(String requestCode);
    int requestIdCheck(String id);
    int requestEmailCheck(String email);
}
