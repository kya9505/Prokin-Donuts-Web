package com.donut.prokindonutsweb.login.service;

import com.donut.prokindonutsweb.login.dto.VerificationCodeDTO;
import com.donut.prokindonutsweb.login.mapper.FindIdMapper;
import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.Optional;

@Service
@Log4j2
@RequiredArgsConstructor
public class FindServiceImpl implements FindService {
    private final ModelMapper modelMapper;
    private final JavaMailSender mailSender;
    private final FindIdMapper findIdMapper;

    /*이메일로 객체 찾기
    */
    @Override
    public Optional<MemberAccountDTO> findId(String email) {
        MemberAccountVO memberAccountVO = findIdMapper.searchEmail(email);
        MemberAccountDTO memberAccountDTO = modelMapper.map(memberAccountVO,MemberAccountDTO.class);
        return Optional.ofNullable(memberAccountDTO);
    }


    //아이디로 객체 찾기
    @Override
    public Optional<MemberAccountDTO> findPassword(String id){
        return null;
    }

    //이메일발송
    @Override
    public void sendEmail(String email,VerificationCodeDTO code) {
        SimpleMailMessage mail = new SimpleMailMessage();
        mail.setTo(email);
        mail.setSubject("ProkinDonuts 아이디/비밀번호 찾기 인증번호 입니다.");
        mail.setText("인증번호 : " + code.getCode() + "\n 해당 인증번호를 아이디/비밀번호찾기 화면에 입력해주세요.");
        mail.setFrom("prokindonuts@gmail.com");
        mailSender.send(mail);
        log.info("전송 완료 (받는사람: {})", email);
    }

    //6자리의 랜덤한 인증번호 생성하여 적용
    @Override
    public VerificationCodeDTO randomCode() {
         String randomCode = String.valueOf((int)(Math.random()*900000) + 100000);
         //10분 후 만료되는 인증번호
         VerificationCodeDTO verificationCode = VerificationCodeDTO.builder()
                 .code(randomCode)
                 .expireTime(LocalDateTime.now().plusMinutes(10))
                 .build();
         return verificationCode;
    }

    //코드와 이메일을 세션에 저장
    public void saveCodeToSession(MemberAccountDTO member,String email ,HttpSession session) {
        VerificationCodeDTO code = randomCode();
        sendEmail(email,code);
        session.setAttribute("authCode", code);
        session.setAttribute("authEmail", email);
        session.setAttribute("member",member);
    }

}
