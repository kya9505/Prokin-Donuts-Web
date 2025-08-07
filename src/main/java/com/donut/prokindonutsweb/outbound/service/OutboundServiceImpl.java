package com.donut.prokindonutsweb.outbound.service;

import com.donut.prokindonutsweb.common.EmailUtil;
import com.donut.prokindonutsweb.order.mapper.OrderMapper;
import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.mapper.OutboundMapper;
import com.donut.prokindonutsweb.outbound.vo.OutboundVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class OutboundServiceImpl implements OutboundService{

    private final EmailUtil emailUtil;
    private final JavaMailSender javaMailSender;
    private final OutboundMapper outboundMapper;
    private final OrderMapper orderMapper;


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
    public void completionOutbound(String outboundCode) {
        outboundMapper.completionOutbound(outboundCode);
    }
    // 발주상태 변경 (배송준비 -> 배송중) 후 메일발송
    @Override
    public void completionOrder(String outboundCode) {
        log.info("발주상태 변경");
        outboundMapper.completionOrder(outboundCode);
        emailUtil.sendDeliveryStatusEmail(javaMailSender,outboundCode,"배송중" );
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


    //섹션반영
    @Override
    public void SectionUpdate(String sectionCode, int quantity){
        outboundMapper.updateSection(sectionCode,quantity);
    }



    // 재고 반영
    @Override
    public void updateInventory(String outboundCode , String warehouseCode) {
        //  VO와 DTO 조회
        OutboundVO outboundVO = outboundMapper.selectOutboundVoOne(outboundCode);
        OutboundDTO outboundDTO = outboundMapper.selectOutboundDtoOne(outboundCode);

        //  재고 코드 존재 여부에 따라 처리
        if (outboundVO.getInventoryCode() != null) {
            // 기존 재고 차감 처리
            outboundMapper.updateInventory(outboundCode);
        } else {
            // 재고 코드가 없으면 재고 코드 검색 후 VO에 세팅
            String inventoryCode = orderMapper.findInventoryCode(
                    warehouseCode,
                    outboundDTO.getProductCode(),
                    Integer.parseInt(outboundDTO.getQuantity())
            );

            // 재고 코드 세팅 및 DB에 반영
            outboundVO.setInventoryCode(inventoryCode);
            outboundMapper.updateInventoryCode(outboundVO);

            // 이후 차감 처리
            outboundMapper.updateInventory(outboundCode);
        }
    }

    //창고코드 조회
    @Override
    public String getWarehouseCode(String memberCode) {
        return outboundMapper.getWarehouseCode(memberCode);
    }


}