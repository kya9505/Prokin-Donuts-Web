package com.donut.prokindonutsweb.inbound.service;

import com.donut.prokindonutsweb.inbound.dto.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface InboundService {
    Optional<List<ProductDTO>> findAllProductList();

    void saveInbound(InboundDTO inboundDTO);

    void saveInboundDetail(List<InboundDetailDTO> inboundDetailDTO);

    String findNextInboundCode();

    Optional<List<InboundDTO>> findAllInboundList();

    Optional<List<InboundDetailDTO>> findAllInboundDetailList();

    void approveInbound(String inboundCode);

    Optional<List<InventoryDTO>> findInboundDetailList(String inboundCode);

    void updateInventory(InventoryVO inventoryVO);

    void updateInbound(List<InboundUpdateDTO> list, LocalDate inboundDate);

    void deleteInbound(String inboundCode);

    Optional<List<InboundStatusDTO>> findAllInboundStatusList();

    void qhUpdateInboundStatus(String inboundCode);

    Optional<List<InboundDTO>> findAllQhInboundList();
}
