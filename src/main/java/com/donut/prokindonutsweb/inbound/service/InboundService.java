package com.donut.prokindonutsweb.inbound.service;

import com.donut.prokindonutsweb.inbound.dto.*;
import com.donut.prokindonutsweb.inbound.vo.InventoryVO;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface InboundService {
    Optional<List<ProductDTO>> findProductList();

    void addInbound(InboundDTO inboundDTO, List<InboundDetailDTO> inboundDetailDTO);


    String getWarehouseCode(String memberCode);

    String findNextInboundCode();

    List<InboundDTO> findInboundList(String warehouseCode);

    List<InboundDetailDTO> findInboundDetailList();

    void approveInbound(String inboundCode);

    Optional<List<InventoryDTO>> findInboundDetailList(String inboundCode);

    void updateInventory(List<InventoryDTO> inventoryList);

    void updateInbound(List<InboundUpdateDTO> list, LocalDate inboundDate);

    void deleteInbound(String inboundCode);

    Optional<List<InboundStatusDTO>> findWMInboundStatusList(String warehouseCode);

    Optional<List<InboundStatusDTO>> findInboundStatusList();

    void updateInboundStatus(String inboundCode);

    Optional<List<InboundDTO>> findQhInboundList();
}
