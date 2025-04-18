package com.donut.prokindonutsweb.service.inbound;

import com.donut.prokindonutsweb.dto.inbound.ProductDTO;

import java.util.List;
import java.util.Optional;

public interface InboundService {
    Optional<List<ProductDTO>> findAllProductList();
}
