package com.donut.prokindonutsweb.inbound.dto;

import lombok.Data;
import lombok.ToString;

import java.util.List;


@Data
@ToString
public class InboundForm {
    private List<InboundDetailDTO> productList;
}
