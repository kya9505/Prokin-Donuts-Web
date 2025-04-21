package com.donut.prokindonutsweb.member.service;

import com.donut.prokindonutsweb.member.dto.MemberRequestDTO;

import java.util.List;
import java.util.Optional;

public interface MemberRequestService {

    Optional<List<MemberRequestDTO>> findRequestMember();
    String memberRequestCode();
    void approvalMember(List<String> requestCodeList);
}
