package com.donut.prokindonutsweb.inbound.dto;

import lombok.Data;
import lombok.ToString;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import java.util.List;


@Data
public class InboundForm {
    @NotEmpty(message = "제품을 선택해 주세요")
    private List<@Valid InboundDetailDTO> productList;
}
