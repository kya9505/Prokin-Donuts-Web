package com.donut.prokindonutsweb.member.controller;

import com.donut.prokindonutsweb.home.mapper.FindIdMapper;
import com.donut.prokindonutsweb.home.service.FindService;
import com.donut.prokindonutsweb.home.service.FindServiceImpl;
import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;
import com.donut.prokindonutsweb.member.service.MemberService;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
@Log4j2
public class MyPageController {
    private final MemberService memberService;
    private final FindService findService;

    //마이페이지
    @GetMapping("/")
    public String myPage(@AuthenticationPrincipal CustomUserDetails user, Model model) {
        model.addAttribute("user", user);
        return "/";
    }

    // 수정
    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<String> update(
            @AuthenticationPrincipal CustomUserDetails user,
            @ModelAttribute MemberAccountDTO formData
    ) {
        try {
            memberService.updateByMember(user.getId(), formData);
            return ResponseEntity.ok("수정 완료");
        } catch (Exception e) {
            log.error("❌ 수정 중 에러 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류 발생");
        }
    }


    // 탈퇴
    @PostMapping("/delete")
    public String secession( @AuthenticationPrincipal CustomUserDetails user, HttpSession session) {
        memberService.deleteByMember(user.getId());
        //세션 무효화
        session.invalidate();
        // 인증정보 제거
        SecurityContextHolder.clearContext();
        return "redirect:/home/login";  // 탈퇴 후 이동할 페이지
    }
}

