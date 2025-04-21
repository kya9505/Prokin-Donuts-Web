package com.donut.prokindonutsweb.franchise.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FranchiseCheckDTO {
  private String franchiseCode;
  private String franchiseName;
}
