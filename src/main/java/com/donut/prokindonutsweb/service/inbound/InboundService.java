package com.donut.prokindonutsweb.service.inbound;

import com.donut.prokindonutsweb.dto.inbound.*;

import java.util.List;
import java.util.Optional;

public interface InboundService {
    Optional<List<ProductDTO>> findAllProductList();

    void saveInbound(InboundDTO inboundDTO);

    void saveInboundDetail(List<InboundDetailDTO> inboundDetailDTO);

    String findNextInboundCode();
}
