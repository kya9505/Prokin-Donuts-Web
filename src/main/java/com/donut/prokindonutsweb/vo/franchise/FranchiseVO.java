package com.donut.prokindonutsweb.vo.franchise;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class FranchiseVO {
  private String franchiseCode;
  private String franchiseLocation;
  private String franchiseName;
  private String memberCode;
  private int donutMinOrder;
}
