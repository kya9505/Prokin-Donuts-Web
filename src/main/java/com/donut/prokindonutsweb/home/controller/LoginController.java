package com.donut.prokindonutsweb.home.controller;

import com.donut.prokindonutsweb.home.dto.LoginRequestDTO;
import com.donut.prokindonutsweb.home.dto.LoginResponseDTO;
import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;
import com.donut.prokindonutsweb.security.dto.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Collection;

@Controller
@Log4j2
@RequiredArgsConstructor
public class LoginController {


    @GetMapping("/home/login")
    public void login(){
    }

    @PostMapping("/home/logout")
    public String logout(@AuthenticationPrincipal CustomUserDetails user,HttpSession session){
        //세션무효화
        session.invalidate();
        // 인증정보 제거
        SecurityContextHolder.clearContext();

        return "/home/login";
    }
    /*
    * 비동기방식으로 처리 시 직접 코드를 짜야한다.
    * 하지만 form방식 이용 시 security가 알아서 post맵핑하여 작동
    * */
//
//    @PostMapping("/login")
//    public ResponseEntity<LoginResponseDTO> login(@RequestBody LoginRequestDTO loginDTO, HttpServletRequest request){
//        try {
//            //token에 Json 형식으로 로그인 요청한 아이디/비밀번호 저장
//            UsernamePasswordAuthenticationToken  token
//                    = new UsernamePasswordAuthenticationToken(loginDTO.getUsername(),loginDTO.getPassword());
//            //유효회원 인지 인증요청(비동기 방식에만 구현, 유효한 회원일 경우 authentication객체로 반환)
//            Authentication authentication = authenticationManager.authenticate(token);
//            //인증 성공한 사용자 정보를 SecurityContext에 저장
//            SecurityContextHolder.getContext().setAuthentication(authentication);
//            //세션에 저장
//            HttpSession session =request.getSession(true);
//            session.setAttribute(
//                    HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,
//                    SecurityContextHolder.getContext()
//            );
//            String redirectUrl = "/";  // 기본
//            Collection<? extends GrantedAuthority> auths = authentication.getAuthorities();
//            if (auths.stream().anyMatch(a -> a.getAuthority().equals("QH"))) {
//                redirectUrl = "/qh/Dashboard";
//            } else if (auths.stream().anyMatch(a -> a.getAuthority().equals("WM"))) {
//                redirectUrl = "/wm/Dashboard";
//            } else if (auths.stream().anyMatch(a -> a.getAuthority().equals("FM"))) {
//                redirectUrl = "/fm/order";
//            }
//            //로그인 성공 시 응답 반환(로그인 성공여부/안내문구/다음경로 - 권
//            return ResponseEntity.ok(new LoginResponseDTO(true,"로그인성공","redirectUrl"));
//        } catch (AuthenticationException e) {
//            return ResponseEntity
//                    .status(HttpStatus.UNAUTHORIZED)
//                    .body(new LoginResponseDTO(false, "아이디 또는 비밀번호 오류", null));
//        }
//    }


}
