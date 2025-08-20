package com.donut.prokindonutsweb.scheduler;

import com.donut.prokindonutsweb.scheduler.dto.ManagerWarehouseInfoDTO;
import com.donut.prokindonutsweb.scheduler.mapper.WarehouseManagerMapper;
import com.donut.prokindonutsweb.common.EmailUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
@Log4j2
public class EmailScheduler {
  
  private final JavaMailSender mailSender;
  private final WarehouseManagerMapper managerMapper;
  
  // 매월 1일 00시에 함수 실행
  @Scheduled(cron = "0 0 0 1 * *")
  public void sendMonthlyExpiredInventoryAlert() {
    
    // 1) 메일 받을 관리자 이메일 목록 조회 (창고가 있는 창고관리자만)
    List<ManagerWarehouseInfoDTO> infos = managerMapper.findManagerInfoWithWarehouses();
    log.info("메일 수신자 : {}명", infos.size());
    if (infos.isEmpty()) {
      log.info("발송 대상자가 없습니다.");
      return;
    }
    
    // 2) 메일 본문 조립 및 순회 발송
    for (ManagerWarehouseInfoDTO info : infos) {
      String to = info.getEmail();
      String name = info.getManagerName();
      String warehouse = info.getWarehouseName();
      
      String bodyHtml = String.format("""
                <div style="font-family:Segoe UI, sans-serif; color:#333;">
                  <p>안녕하세요, %s 관리자님.</p>
                  <p>귀하가 담당하시는 <strong>%s</strong> 창고의 적정재고량을 검토 및 재설정할 시점입니다.</p>
                  <hr style="border:none; border-top:1px solid #eee; margin:20px 0;"/>
                  <p>감사합니다.</p>
                </div>
                """, name, warehouse, warehouse);
      
      try {
        EmailUtil.sendMail(
            mailSender,
            to,
            "[ProkinDonuts] 매월 적정재고량 검토 요청",
            bodyHtml
        );
        log.info("발송 완료: {} ({})", to, warehouse);
      } catch (Exception e) {
        log.error("발송 실패: {} ({})", to, warehouse, e);
      }
    }
    
  }
}