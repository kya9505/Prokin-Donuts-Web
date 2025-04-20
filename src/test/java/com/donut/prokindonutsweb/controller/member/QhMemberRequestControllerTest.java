package com.donut.prokindonutsweb.controller.member;

import com.donut.prokindonutsweb.dto.member.MemberRequestDTO;
import com.donut.prokindonutsweb.dto.member.RequestCodeListForm;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@Log4j2
@ExtendWith(SpringExtension.class)
@RequiredArgsConstructor
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
class QhMemberRequestControllerTest {
    @Autowired
    private QhMemberRequestController requestController;

    @Test
    @DisplayName("qh 회원요청 목록 Model 바인딩 테스트")
    void qhGetMemberRequestList() {
        Model model = new ExtendedModelMap();
        requestController.qhGetMemberRequestList(model);
        List<MemberRequestDTO> memberRequestDTOList
                = (List<MemberRequestDTO>)model.getAttribute("requestList");
        assertNotNull(memberRequestDTOList);
        memberRequestDTOList.forEach(log::info);

    }

    @Test
    @DisplayName("회원가입 요청 승인 controller 반영 테스트")
    void qhApprovalMemberRequests() {
        RequestCodeListForm requestCodeListForm = new RequestCodeListForm();
        requestCodeListForm.setRequestList(List.of("RQ06","RQ07","RQ08"));
        requestController.qhApprovalMemberRequests(requestCodeListForm);
    }
}