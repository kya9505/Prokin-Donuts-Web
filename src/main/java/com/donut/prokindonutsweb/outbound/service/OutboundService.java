package com.donut.prokindonutsweb.outbound.service;

import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.dto.OutboundDetailDTO;

import java.util.List;

public interface OutboundService {

    List<OutboundDTO> findOutboundList(String warehouseCode);

    List<OutboundDetailDTO> findOutboundDetailList();

    boolean checkInventory(String outboundCode);

    void approveOutbound(String outboundCode);

    void updateInventory(String outboundCode);
}
