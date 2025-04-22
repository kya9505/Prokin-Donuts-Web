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

    @GetMapping("findPassword")
    public void findPassword(){}

    //요청이메일로 회원 확인 후 메일 발송
    @GetMapping(value ="/sendCode", produces = "text/plain")
    @ResponseBody
    public String sendCode(@RequestParam("email") String email, HttpSession session) {
        Optional<MemberAccountDTO> optionalMember = findService.findEmail(email);

        if (optionalMember.isEmpty()) {
            return "notFound"; // 이메일 없음
        }
        try {
            MemberAccountDTO member = optionalMember.get();
            findService.saveCodeToSession(member, email, session);
            return "success"; // 메일 정상 발송됨
        } catch (Exception e) {
            log.error("메일 전송 실패", e);
            return "fail"; // 메일 발송 자체 실패
        }
    }



    /*아이디 찾기
    인증번호,메일 확인 후 아이디 반환*/
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

    /*비밀번호 찾기
    인증번호,메일,아이디 확인 후 비밀번호 반환*/
    @GetMapping(value = "/resultPassword", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String findPassword(@RequestParam String email, @RequestParam String inputCode, @RequestParam String id, HttpSession session) {

        boolean checkCode = false;
        //세션에 저장된 코드,이메일,멤버객체 조회
        VerificationCodeDTO saveCode = (VerificationCodeDTO) session.getAttribute("authCode");
        String saveEmail = (String) session.getAttribute("authEmail");
        MemberAccountDTO saveMember = (MemberAccountDTO) session.getAttribute("member");

        //세션에 정보가 존재하는 지 확인
        if (saveCode == null || saveEmail == null || saveMember == null) {
            return String.valueOf(checkCode);
        }
        //아이디 일치 여부 확인
        if(!(saveMember.getId()).equals(id)){
             return "IdCheck";
        }
        //인증번호 유효검증/일지여부 확인/이메일 일치여부 확인
        if (!saveCode.isExpired() && saveCode.matches(inputCode) && saveEmail.equals(email)) {
            checkCode = true;
            return saveMember.getPassword(); // 찾은 아이디 반환
        }

        return String.valueOf(checkCode);// 인증실패
    }
}
