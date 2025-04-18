package com.donut.prokindonutsweb.vo.inbound;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InboundVO {
    private String inboundCode;
    private Date inboundDate;
    private String inboundStatus;
    private String warehouseCode;
}
