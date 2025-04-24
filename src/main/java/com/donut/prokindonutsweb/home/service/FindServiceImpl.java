package com.donut.prokindonutsweb.home.service;

import com.donut.prokindonutsweb.home.dto.VerificationCodeDTO;
import com.donut.prokindonutsweb.home.mapper.FindIdMapper;
import com.donut.prokindonutsweb.member.dto.MemberAccountDTO;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileNotFoundException;
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
    public Optional<MemberAccountDTO> findEmail(String email) {
        MemberAccountVO memberAccountVO = findIdMapper.searchEmail(email);
        MemberAccountDTO memberAccountDTO = modelMapper.map(memberAccountVO,MemberAccountDTO.class);
        return Optional.ofNullable(memberAccountDTO);
    }


    //아이디로 객체 찾기
    @Override
    public Optional<MemberAccountDTO> findId(String id){
        MemberAccountVO memberAccountVO = findIdMapper.searchId(id);
        MemberAccountDTO memberAccountDTO = modelMapper.map(memberAccountVO,MemberAccountDTO.class);
        return Optional.ofNullable(memberAccountDTO);
    }

    //이메일발송
    @Override
    public void sendEmail(String email, VerificationCodeDTO code) throws MessagingException, FileNotFoundException {
        MimeMessage message = mailSender.createMimeMessage();

        // multipart=true → 이미지 첨부 허용됨
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        helper.setTo(email);
        helper.setSubject("ProkinDonuts 인증번호입니다.");
        helper.setFrom("prokindonuts@gmail.com");
        helper.setText(buildHtml(code.getCode()), true);

        // 이미지 인라인 첨부
        File file = ResourceUtils.getFile("classpath:images/DONUT2.png");
        FileSystemResource res = new FileSystemResource(file);
        helper.addInline("donutLogo", res); // cid:donutLogo 와 일치해야 함

        mailSender.send(message);

        log.info("전송 완료 (받는사람: {})", email);
    }

    //메일발송 html
    private String buildHtml(String authCode) {
        return """
        <!DOCTYPE html>
        <html lang="ko">
        <head>
            <meta charset="UTF-8">
            <title>인증번호 안내</title>
        </head>
        <body style="font-family:'Segoe UI', sans-serif; background-color:#f9f9f9; padding:40px;">
            <div style="background-color:#fff; border-radius:10px; padding:30px; max-width:600px; margin:auto; box-shadow:0 2px 10px rgba(0,0,0,0.1); text-align:center;">
                <img src="cid:donutLogo" alt="Prokin Donuts" style="width:300px; margin-bottom:10px;" />
                <p>안녕하세요, Prokin Donuts입니다.<br><br>요청하신 인증번호는 아래와 같습니다<br><br></p>
                <p style="font-size:28px; color:#ff5722; font-weight:bold;">
        """ + authCode + """
                </p>
                <p><br>인증번호는 10분간 유효합니다.<br><br>시간이 지나면 다시 요청해 주세요.</p>
                <div style="font-size:12px; color:#999; margin-top:30px;">본 메일은 발신전용입니다.<br>본 인증번호를 요청하지 않으셨다면 고객센터를 이용해 주세요.</div>
            </div>
        </body>
        </html>
        """;
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
    public void saveCodeToSession(MemberAccountDTO member,String email ,HttpSession session) throws MessagingException, FileNotFoundException {
        VerificationCodeDTO code = randomCode();
        sendEmail(email,code);
        session.setAttribute("authCode", code);
        session.setAttribute("authEmail", email);
        session.setAttribute("member",member);
    }

}
