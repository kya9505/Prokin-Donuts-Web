package com.donut.prokindonutsweb.common.mapper;

import com.donut.prokindonutsweb.common.dto.DeliveryPrepareDTO;
import com.donut.prokindonutsweb.common.dto.DeliveryShippingDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeliveryEmailMapper {
  
  /**
   * 배송 준비중 상태의 이메일 발송 데이터 조회
   * @param memberCode 가맹점주 멤버 코드
   * @return 수신자 이메일, 수신자명
   */
  DeliveryPrepareDTO getPrepareEmailData(@Param("memberCode") String memberCode);
  
  /**
   * 배송중/완료 상태의 이메일 발송 데이터 조회
   * @param outboundCode 출고 코드
   * @return 수신자 이메일, 수신자명, 배송중/배송완료된 제품명
   */
  DeliveryShippingDTO getShippingEmailData(@Param("outboundCode") String outboundCode);
}