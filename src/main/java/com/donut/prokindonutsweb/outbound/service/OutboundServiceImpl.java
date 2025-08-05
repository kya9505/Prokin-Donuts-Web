package com.donut.prokindonutsweb.outbound.service;

import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.mapper.OutboundMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class OutboundServiceImpl implements OutboundService{

    private final OutboundMapper outboundMapper;

    //출고목록 조회
    @Override
    public List<OutboundDTO> findOutboundList(String warehouseCode) {
        return outboundMapper.selectAllOutboundList(warehouseCode);

    }

    //출고 요청 목록 조회
    @Override
    public List<OutboundDTO> findApprovalOutboundList(String warehouseCode){
        return outboundMapper.selectApprovalOutboundList(warehouseCode);
    }
    //출고 준비 목록 조회
    @Override
    public List<OutboundDTO> findCompletionOutboundList(String warehouseCode){
        return outboundMapper.selectCompletionOutboundList(warehouseCode);
    }


    // 재고 존재 여부 확인
    @Override
    public boolean checkInventory(String outboundCode) {
        return outboundMapper.checkInventory(outboundCode);
    }

    //출고요청 승인
    @Override
    public void approveOutbound(String outboundCode) {
        outboundMapper.approveOutbound(outboundCode);
    }

    //출고상태 변경 (출고완료)
    @Override
    public void completionOutbound(String warehouseCode,String outboundCode) {
        outboundMapper.completionOutbound(outboundCode);
    }

    //보관타입 조회
    public String findStoredType(String outboundCode){
        String storedType = outboundMapper.selectStoredType(outboundCode);
        if (storedType.equals("냉동")) {
            return "F";
        } else if (storedType.equals("냉장")) {
            return "R";
        } else {
            return "A";
        }
    }

    //섹션 번호 생성
    public String getSectionCode(String warehouseCode, String outboundCode){
        String storedType = findStoredType(outboundCode);
        return warehouseCode+"-"+storedType;
    }

    //생성된 섹션번호 실제 존재하는 지 조회
    public boolean checkSectionCode(String sectionCode){;
        return outboundMapper.checkSection(sectionCode);
    }

    //수량 조회
    public int getQuantity(String outboundCode){
        return outboundMapper.selectQuantity(outboundCode);
    }

    //
    //섹션반영
    @Override
    public void SectionUpdate(String sectionCode, int quantity){
        outboundMapper.updateSection(sectionCode,quantity);
    }



    // 재고 반영
    @Override
    public void updateInventory(String outboundCode) {
        outboundMapper.updateInventory(outboundCode);
    }

    //창고코드 조회
    @Override
    public String getWarehouseCode(String memberCode) {
        return outboundMapper.getWarehouseCode(memberCode);
    }


}