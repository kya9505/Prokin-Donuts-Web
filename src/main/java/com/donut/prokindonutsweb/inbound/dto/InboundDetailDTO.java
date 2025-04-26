package com.donut.prokindonutsweb.inbound.dto;

import lombok.*;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class InboundDetailDTO {
    private String inboundCode;
    private String productCode;
    private String productName;
    private Integer productPrice;
    private String storedType;
    @Min(value=100, message ="수량은 최소 100개 이상부터 선택 가능합니다.")
    private Integer quantity;
}
