package com.donut.prokindonutsweb.home.mapper;

import com.donut.prokindonutsweb.member.vo.MemberAccountVO;

public interface FindIdMapper {
    MemberAccountVO searchId(String id);
    MemberAccountVO searchEmail(String email);
}
