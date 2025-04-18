package com.donut.prokindonutsweb.mappers.member;


import com.donut.prokindonutsweb.vo.member.MemberAccountVO;

import java.util.List;
import java.util.Optional;

public interface MemberMapper{
    List<MemberAccountVO> selectMember();
}
