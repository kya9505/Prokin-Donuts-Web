package com.donut.prokindonutsweb.common;

import com.donut.prokindonutsweb.common.dto.DeliveryPrepareDTO;
import com.donut.prokindonutsweb.common.dto.DeliveryShippingDTO;
import com.donut.prokindonutsweb.common.mapper.DeliveryEmailMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.util.ResourceUtils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.File;
import java.io.FileNotFoundException;

@Component
@RequiredArgsConstructor
@Log4j2
public class EmailUtil {
  
  private final DeliveryEmailMapper deliveryEmailMapper;
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
  
  /**
   * 발주/출고 상태에 따라 한 번에 메일 전송
   *
   * @param code   배송준비 → memberCode, 배송중/배송완료 → outboundCode
   * @param status "배송준비", "배송중", "배송완료"
   */
  public void sendDeliveryStatusEmail(JavaMailSender mailSender, String code, String status) {
    String to;
    String subject;
    String body;
    
    // 1) 배송준비 이메일 발송시
    if ("배송준비".equals(status)) {
      // 준비중: code = memberCode
      DeliveryPrepareDTO dto = deliveryEmailMapper.getPrepareEmailData(code);
      to      = dto.getMemberEmail();
      subject = "[발주] 접수완료 안내";
      body    =
          "안녕하세요, <strong>" + dto.getMemberName() + " 가맹점주님</strong>.<br><br>" +
              "요청하신 발주가"+
              "<strong style=\"color:#28A745;\">정상접수</strong> 되었습니다.<br><br>" +
              "제품은 건별로 배송될 예정입니다.<br><br>" +
              "<hr/>" +
              "<strong style=\"color:#FFA500;\">배송 준비</strong> &nbsp;&nbsp; " +
              "<strong>배송중</strong> &nbsp;&nbsp; <strong>배송완료</strong>";
    
    // 2) 배송중 이메일 발송시
    } else if ("배송중".equals(status)) {
      // 배송중: code = outboundCode
      DeliveryShippingDTO dto = deliveryEmailMapper.getShippingEmailData(code);
      to      = dto.getMemberEmail();
      subject = "[출고] 배송 시작 안내";
      body    =
          "안녕하세요, <strong>" + dto.getMemberName() + " 가맹점주님</strong>.<br><br>" +
              "요청하신 <strong>" + dto.getProductName() + "</strong> 제품이 " +
              "<strong style=\"color:#28A745;\">배송시작</strong> 되었습니다.<br><br>" +
              "<hr/>" +
              "<strong>배송 준비</strong> &nbsp;&nbsp; " +
              "<strong style=\"color:#007BFF;\">배송중</strong> &nbsp;&nbsp; " +
              "<strong>배송완료</strong>";
      
    // 3) 배송완료 이메일 발송시
    } else if ("배송완료".equals(status)) {
      // 배송완료: code = outboundCode
      DeliveryShippingDTO dto = deliveryEmailMapper.getShippingEmailData(code);
      to      = dto.getMemberEmail();
      subject = "[출고] 배송 완료 안내";
      body    =
          "안녕하세요, <strong>" + dto.getMemberName() + " 가맹점주님</strong>.<br><br>" +
              "요청하신 <strong>" + dto.getProductName() + "</strong> 제품의 배송이 " +
              "<strong style=\"color:#28A745;\">배송완료</strong> 되었습니다.<br><br>" +
              "<hr/>" +
              "<strong>배송 준비중</strong> &nbsp;&nbsp; " +
              "<strong>배송중</strong> &nbsp;&nbsp; " +
              "<strong style=\"color:#28A745;\">배송완료</strong>";
      
    } else {
      log.warn("알 수 없는 배송 상태: {}", status);
      return;
    }
    
    // HTML 메일 발송
    sendHtmlMail(mailSender, to, subject, body);
    log.info("Delivery status email sent to {} [status={}]", to, status);
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