package com.donut.prokindonutsweb.franchise.dto;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class FranchiseDTO {
  private String franchiseCode;
  private String franchiseLocation;
  private String franchiseName;
  private String memberCode;
  private int donutMinOrder;
  private String memberName;
  private String memberEmail;
  private String status;
}
