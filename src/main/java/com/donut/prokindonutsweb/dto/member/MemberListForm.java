package com.donut.prokindonutsweb.dto.member;

import lombok.Data;
import lombok.ToString;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@Data
@ToString
public class MemberListForm {
    @Valid
    private List<MemberAccountDTO> memberList = new ArrayList<>();

}


