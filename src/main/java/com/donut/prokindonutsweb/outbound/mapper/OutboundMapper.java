package com.donut.prokindonutsweb.outbound.mapper;

import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.vo.OutboundVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OutboundMapper {

    List<OutboundDTO> selectAllOutboundList(String warehouseCode);
    List<OutboundDTO> selectApprovalOutboundList(String warehouseCode);
    List<OutboundDTO> selectCompletionOutboundList(String warehouseCode);
    String selectStoredType(String outboundCode);
    int selectQuantity(String outboundCode);
    boolean checkInventory(@Param("outboundCode") String outboundCode);
    boolean checkSection(String sectionCode);

    void approveOutbound(String outboundCode);
    void completionOutbound(String outboundCode);
    void completionOrder(String outboundCode);

    void updateInventory(String outboundCode);

    String getWarehouseCode(String memberCode);

    void updateSection(@Param("sectionCode") String sectionCode, @Param("quantity") int quantity);
    void insertOutbound(OutboundVO outboundVO);
    String selectOutboundCode();

}