package com.donut.prokindonutsweb.order.dto;

import com.donut.prokindonutsweb.inbound.dto.InboundDetailDTO;
import lombok.Data;

import java.util.List;


@Data
public class OrderForm {
    private List<OrderDetailDTO> productList;
}
