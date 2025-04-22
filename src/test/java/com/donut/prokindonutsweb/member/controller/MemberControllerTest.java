package com.donut.prokindonutsweb.member.controller;

import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;
import com.donut.prokindonutsweb.member.dto.MemberCodeListForm;
import com.donut.prokindonutsweb.member.dto.MemberListForm;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
class MemberControllerTest {
    @Autowired
    private WmMemberController wmMemberController;
    @Autowired
   private QhMemberController qhMemberController;

    /*
    * memberController의 wmMemberList 테스트
    * Model객체에 담긴 List 확인
    * */
    @Test
    @DisplayName("wm 회원 목록 Model 바인딩 테스트")
    public void wmGetMemberList(){
        Model model = new ExtendedModelMap(); //model은 interface이므로 객체생성 불가, 구현체 주입
        wmMemberController.wmGetMember(model);
        List<MemberAccountDTO> memberList = (List<MemberAccountDTO>)model.getAttribute("wmMemberList");
        assertNotNull(memberList);
        memberList.forEach(log::info);
    }

    @Test
    @DisplayName("qh 회원 목록 Model 바인딩 테스트")
    public void qhGetMemberList(){
        Model model = new ExtendedModelMap(); //model은 interface이므로 객체생성 불가, 구현체 주입
        qhMemberController.qhGetMemberList(model);
        List<MemberAccountDTO> memberList = (List<MemberAccountDTO>)model.getAttribute("qhMemberList");
        assertNotNull(memberList);
        memberList.forEach(log::info);
    }

    @Test
    @DisplayName("qh add Controller 회원 등록 DB 반영 테스트")
    public void qhAddMemberList(){
        MemberAccountDTO memberDTO = MemberAccountDTO.builder().memberCode("QH100")
                .authorityCode("QH")
                .name("100")
                .phoneNumber("100")
                .email("100")
                .address("100")
                .id("100")
                .password("100").build();
        BindingResult bindingResult = new BeanPropertyBindingResult(memberDTO, "memberAccountDTO");
        RedirectAttributes redirectAttributes = new RedirectAttributesModelMap();
        qhMemberController.qhAddMemberList(memberDTO, bindingResult, redirectAttributes);
    }

    @Test
    @DisplayName("qh update controller 회원 수정 DB 반영 테스트")
    public void qhUpdateMembers(){
        MemberAccountDTO memberDTO = MemberAccountDTO.builder()
                .memberCode("QH100")
                .authorityCode("QH")
                .name("200")
                .phoneNumber("200")
                .email("200")
                .address("200")
                .id("200")
                .password("200").build();

        MemberListForm memberListForm = new MemberListForm();
        memberListForm.setMemberList(List.of(memberDTO));

        // BindingResult와 RedirectAttributes는 목 객체로 대체
        BindingResult bindingResult = new org.springframework.validation.BeanPropertyBindingResult(memberListForm, "memberEditForm");
        RedirectAttributes redirectAttributes = new org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap();

        String result = qhMemberController.qhUpdateMembers(memberListForm, bindingResult, redirectAttributes);
        assertEquals("redirect:list", result);

    }

    @Test
    @DisplayName("qh delete controller 회원 삭제 DB 반영 테스트")
    public void qhDeleteMembers(){
        MemberCodeListForm memberCodeForm = new MemberCodeListForm();
        memberCodeForm.setMemberCodeList(List.of("QH100"));

        String result = qhMemberController.qhDeleteMembers(memberCodeForm);
        assertEquals("redirect:list", result);
    }

    @Test
    @DisplayName("qh 회원등록 시 id 중복확인 테스트")
    public void IdCheck(){
        String idCheck = qhMemberController.checkId("100");
        log.info(idCheck);
    }
}