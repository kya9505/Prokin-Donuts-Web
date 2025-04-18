package com.donut.prokindonutsweb.mappers.inbound;

import com.donut.prokindonutsweb.dto.inbound.InboundDetailVO;
import com.donut.prokindonutsweb.dto.inbound.InboundVO;
import com.donut.prokindonutsweb.dto.inbound.ProductDTO;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface InboundMapper {
    List<ProductDTO> selectAllProductList();
    void insertInbound(InboundVO inboundVO);
    // 입고 상세 정보
    void insertInboundDetailList(@Param("list") List<InboundDetailVO> list);
}
