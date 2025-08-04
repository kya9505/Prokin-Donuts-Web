package com.donut.prokindonutsweb.common;

import lombok.extern.log4j.Log4j2;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.util.ResourceUtils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.File;
import java.io.FileNotFoundException;

@Log4j2
public class EmailUtil {
  
  private static final String FROM = "prokindonuts@gmail.com";
  
  // 제목 + 내용만 넘기면 알아서 HTML로 보내주는 함수
  public static void sendMail(JavaMailSender mailSender, String to, String subject, String bodyText) {
    String html = buildHtml(subject, bodyText);
    sendHtmlMail(mailSender, to, subject, html);
  }
  
  // HTML을 직접 넘길 수 있는 메서드
  public static void sendHtmlMail(JavaMailSender mailSender, String to, String subject, String htmlBody) {
    try {
      MimeMessage message = mailSender.createMimeMessage();
      MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
      
      helper.setFrom(FROM);
      helper.setTo(to);
      helper.setSubject(subject);
      helper.setText(htmlBody, true);
      
      File file = ResourceUtils.getFile("classpath:images/DONUT2.png");
      FileSystemResource res = new FileSystemResource(file);
      helper.addInline("donutLogo", res);
      
      mailSender.send(message);
      log.info("메일 발송 완료: {}", to);
      
    } catch (MessagingException | FileNotFoundException e) {
      log.error("메일 발송 실패: {}", to, e);
    }
  }
  
  // 자동 HTML 템플릿 생성 함수
  public static String buildHtml(String title, String messageBody) {
    return "<!DOCTYPE html>" +
        "<html lang='ko'><head><meta charset='UTF-8'><title>메일 안내</title></head>" +
        "<body style='font-family:Segoe UI, sans-serif; background-color:#f9f9f9; padding:40px;'>" +
        "<div style='background-color:#fff; border-radius:10px; padding:30px; max-width:600px; margin:auto; box-shadow:0 2px 10px rgba(0,0,0,0.1); text-align:center;'>" +
        "<img src='cid:donutLogo' alt='Prokin Donuts' style='width:250px; margin-bottom:20px;' />" +
        "<h2 style='color:#333;'>" + title + "</h2>" +
        "<div style='font-size:16px; color:#555; margin:20px 0;'>" + messageBody + "</div>" +
        "<div style='font-size:12px; color:#999; margin-top:30px;'>※ 본 메일은 발신전용입니다.</div>" +
        "</div></body></html>";
  }
}