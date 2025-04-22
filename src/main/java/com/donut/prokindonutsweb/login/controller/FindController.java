package com.donut.prokindonutsweb.login.controller;

import com.donut.prokindonutsweb.login.dto.VerificationCodeDTO;
import com.donut.prokindonutsweb.login.service.FindService;
import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.NoSuchElementException;
import java.util.Optional;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/home")
public class FindController {
    private final FindService findService;


    @GetMapping("/findId")
    public void findId(){}

    //요청이메일로 회원 확인 후 메일 발송
    @GetMapping(value ="/sendCode", produces = "text/plain")
    @ResponseBody
    public String sendCode(@RequestParam("email") String email , HttpSession session){
        log.info("[sendCode] 요청 email: {}", email);
        boolean sendCheck = false;

        Optional<MemberAccountDTO> optionalMember = findService.findId(email);

        if (optionalMember.isPresent()) {
            MemberAccountDTO member = optionalMember.get();
            findService.saveCodeToSession(member, member.getEmail(), session);
            sendCheck = true;
        }

        return String.valueOf(sendCheck);
    }
    //인증번호,메일 확인 후 아이디 반환
    @GetMapping(value = "/resultId", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String findId(@RequestParam String email, @RequestParam String inputCode, HttpSession session) {

        boolean checkCode = false;
        //세션에 저장된 코드,이메일,멤버객체 조회
        VerificationCodeDTO saveCode = (VerificationCodeDTO) session.getAttribute("authCode");
        String saveEmail = (String) session.getAttribute("authEmail");
        MemberAccountDTO saveMember = (MemberAccountDTO) session.getAttribute("member");

        //세션에 정보가 존재하는 지 확인
        if (saveCode == null || saveEmail == null || saveMember == null) {
            return String.valueOf(checkCode);
        }
        //인증번호 유효검증/일지여부 확인/이메일 일치여부 확인
        if (!saveCode.isExpired() && saveCode.matches(inputCode) && saveEmail.equals(email)) {
            checkCode = true;
            return saveMember.getId(); // 찾은 아이디 반환
        }

        return String.valueOf(checkCode);// 인증실패
    }
}
