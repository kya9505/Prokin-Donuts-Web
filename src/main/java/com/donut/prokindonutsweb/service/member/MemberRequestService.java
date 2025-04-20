package com.donut.prokindonutsweb.service.member;

import com.donut.prokindonutsweb.dto.member.MemberRequestDTO;

import java.util.List;
import java.util.Optional;

public interface MemberRequestService {

    Optional<List<MemberRequestDTO>> findRequestMember();
    String memberRequestCode();
    void approvalMember(List<String> requestCodeList);
}
