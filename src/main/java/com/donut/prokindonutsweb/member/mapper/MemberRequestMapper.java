package com.donut.prokindonutsweb.member.mapper;


import com.donut.prokindonutsweb.member.vo.MemberRequestVO;
import java.util.List;

public interface MemberRequestMapper {
    List<MemberRequestVO> selectRequestMember();
    void approvalMember(String requestCode);
    void deleteRequestMember(String requestCode);
    String requestCode();
    MemberRequestVO selectByMemberRequest(String requestCode);
}
