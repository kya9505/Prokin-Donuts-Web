package com.donut.prokindonutsweb.franchise.vo;

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
