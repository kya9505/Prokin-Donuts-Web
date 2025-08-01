package com.donut.prokindonutsweb.outbound.service;

import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.mapper.OutboundMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OutboundServiceImpl implements OutboundService{

    private final OutboundMapper outboundMapper;

    @Override
    public List<OutboundDTO> findOutboundList(String warehouseCode) {
        return outboundMapper.selectAllOutboundList(warehouseCode);

    }


    // 재고 존재 여부 확인
    @Override
    public boolean checkInventory(String outboundCode) {
        return outboundMapper.checkInventory(outboundCode);
    }

    @Override
    public void approveOutbound(String outboundCode) {
        outboundMapper.approveOutbound(outboundCode);
    }

    // 재고 반영
    @Override
    public void updateInventory(String outboundCode) {
        outboundMapper.updateInventory(outboundCode);
    }

    @Override
    public String getWarehouseCode(String memberCode) {
        return outboundMapper.getWarehouseCode(memberCode);
    }


}
