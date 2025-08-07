package com.donut.prokindonutsweb.common.dto;

import lombok.Data;

/**
 * 배송 준비중 이메일 발송용 DTO
 */
@Data
public class DeliveryPrepareDTO {
  /** 가맹점주 이메일 */
  private String memberEmail;
  /** 가맹점주 이름 */
  private String memberName;
}