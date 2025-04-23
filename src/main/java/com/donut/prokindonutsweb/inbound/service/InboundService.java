package com.donut.prokindonutsweb.inbound.service;

import com.donut.prokindonutsweb.inbound.dto.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface InboundService {
    Optional<List<ProductDTO>> findProductList();

    void addInbound(InboundDTO inboundDTO, List<InboundDetailDTO> inboundDetailDTO);


    String findNextInboundCode();

    List<InboundDTO> findInboundList();

    List<InboundDetailDTO> findInboundDetailList();

    void approveInbound(String inboundCode);

    Optional<List<InventoryDTO>> findInboundDetailList(String inboundCode);

    void updateInventory(InventoryVO inventoryVO);

    void updateInbound(List<InboundUpdateDTO> list, LocalDate inboundDate);

    void deleteInbound(String inboundCode);

    Optional<List<InboundStatusDTO>> findInboundStatusList();

    void updateInboundStatus(String inboundCode);

    Optional<List<InboundDTO>> findQhInboundList();
}
