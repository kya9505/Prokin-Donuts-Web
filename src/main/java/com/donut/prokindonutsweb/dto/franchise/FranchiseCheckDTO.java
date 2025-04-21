package com.donut.prokindonutsweb.dto.franchise;

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
