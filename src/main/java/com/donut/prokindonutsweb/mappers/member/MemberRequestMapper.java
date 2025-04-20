package com.donut.prokindonutsweb.mappers.member;


import com.donut.prokindonutsweb.vo.member.MemberRequestVO;
import java.util.List;

public interface MemberRequestMapper {
    List<MemberRequestVO> selectRequestMember();
    void approvalMember(String requestCode);
    void deleteRequestMember(String requestCode);
    String requestCode();
}
