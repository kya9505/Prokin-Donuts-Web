package com.donut.prokindonutsweb.common.dto;

import lombok.Data;

/**
 * 배송중/완료 이메일 발송용 DTO
 */
@Data
public class DeliveryShippingDTO {
  /** 가맹점주 이메일 */
  private String memberEmail;
  /** 가맹점주 이름 */
  private String memberName;
  /** 제품명 */
  private String productName;
}
