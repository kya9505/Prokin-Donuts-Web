package com.donut.prokindonutsweb.inbound.dto;

import lombok.Data;
import lombok.ToString;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import java.util.List;


@Data
public class InboundForm {
    private List<InboundDetailDTO> productList;
}
