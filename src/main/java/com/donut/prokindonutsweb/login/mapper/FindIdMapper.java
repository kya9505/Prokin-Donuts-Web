package com.donut.prokindonutsweb.login.mapper;

import com.donut.prokindonutsweb.member.vo.MemberAccountVO;

public interface FindIdMapper {
    MemberAccountVO searchId(String id);
    MemberAccountVO searchEmail(String email);
}
