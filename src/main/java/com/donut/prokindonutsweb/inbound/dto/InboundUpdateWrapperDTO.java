package com.donut.prokindonutsweb.inbound.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;
@Data
public class InboundUpdateWrapperDTO {
    private List<InboundUpdateDTO> items;

}
