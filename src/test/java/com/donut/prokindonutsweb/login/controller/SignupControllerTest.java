package com.donut.prokindonutsweb.login.controller;

import com.donut.prokindonutsweb.home.controller.SignupController;
import com.donut.prokindonutsweb.member.dto.MemberRequestDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
class SignupControllerTest {
@Autowired
private SignupController signupController;

    @Test
    @DisplayName("signup Controller 회원가입 요청 DB 반영 테스트")
    void signup() {
        MemberRequestDTO dto = MemberRequestDTO.builder()
                .id("test3")
                .email("test3")
                .name("test3")
                .address("test3")
                .phoneNumber("test3")
                .password("test3")
                .build();
        BindingResult bindingResult = new BeanPropertyBindingResult(dto, "MemberRequestDTO");
        RedirectAttributes redirectAttributes = new RedirectAttributesModelMap();
        signupController.signup(dto,bindingResult,redirectAttributes);

    }
}