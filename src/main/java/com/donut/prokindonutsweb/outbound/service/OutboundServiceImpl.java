package com.donut.prokindonutsweb.outbound.service;

import com.donut.prokindonutsweb.common.EmailUtil;
import com.donut.prokindonutsweb.order.mapper.OrderMapper;
import com.donut.prokindonutsweb.outbound.dto.OutboundCompletionResult;
import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.dto.VehicleDTO;
import com.donut.prokindonutsweb.outbound.dto.VehicleScheduleDTO;
import com.donut.prokindonutsweb.outbound.mapper.OutboundMapper;
import com.donut.prokindonutsweb.outbound.vo.OutboundVO;
import com.donut.prokindonutsweb.outbound.vo.VehicleScheduleVO;
import com.donut.prokindonutsweb.outbound.vo.VehicleVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

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



    //섹션반영
    @Override
    public void SectionUpdate(String sectionCode, int quantity){
        outboundMapper.updateSection(sectionCode,quantity);
    }



    // 재고 반영
    @Override
    public boolean updateInventory(String outboundCode , String warehouseCode) {
        //  VO와 DTO 조회
        OutboundVO outboundVO = outboundMapper.selectOutboundVoOne(outboundCode);
        OutboundDTO outboundDTO = outboundMapper.selectOutboundDtoOne(outboundCode);

        //  재고 코드 존재 여부에 따라 처리
        if (outboundVO.getInventoryCode() != null) {
            // 기존 재고 차감 처리
            outboundMapper.updateInventory(outboundCode);
            return true;
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
            return false;
        }
    }

    //창고코드 조회
    @Override
    public String getWarehouseCode(String memberCode) {
        return outboundMapper.getWarehouseCode(memberCode);
    }

    //배치 차량 조회
    @Override
    public VehicleScheduleDTO getVehicle(VehicleDTO vehicleDTO){
        return outboundMapper.selectVehicle(vehicleDTO);
    }

    //출고에 차량 배치
    @Override
    public boolean outboundVehicle(String outboundCode){
        OutboundVO outboundVO = outboundMapper.selectOutboundVoOne(outboundCode);
        log.info("출고정보:{}",outboundVO);
        //차량조회 객체 생성
        VehicleDTO vehicleDTO = outboundMapper.getVehicleDTO(outboundCode);
        //해당 날짜의 모든 차량이 배차대기중인지(스케쥴표에 등록되어 있는 지) 확인
        boolean checkSchedule = getVehicleSchedule(vehicleDTO);
        //등록되어있지 않으면 등록
        if(!checkSchedule) insertVehicleSchedule(vehicleDTO);
        //배치 가능한 차량 조회
        VehicleScheduleDTO vehicleScheduleDTO = getVehicle(vehicleDTO);
        log.info("배치차량:{}",vehicleScheduleDTO);
        //출고에 차량 배치
        if(vehicleScheduleDTO.getVehicleCode() != null && vehicleScheduleDTO.getDispatchDate() !=null ) {
            outboundVO.setVehicleCode(vehicleScheduleDTO.getVehicleCode());
            log.info("차량배치 완료 출고정보:{}",outboundVO);
            //차량 배치 스케쥴 등록
            addVehicleshcedule(vehicleScheduleDTO);
            //출고날짜와 차량 배치날짜가 일치하지 않으면 출고날짜를 차량배치 날짜로 변경
            if(outboundVO.getOutboundDate() != vehicleScheduleDTO.getDispatchDate())outboundMapper.updateOutboundDate(vehicleScheduleDTO.getDispatchDate(),outboundCode);
            return true;
        } else return false; //배치 가능한 차량 없을 경우 false
    }

    //차량배치 후 스케쥴에 반영
    @Override
    public void addVehicleshcedule(VehicleScheduleDTO vehicleScheduleDTO){
        outboundMapper.updateVehicleSchedule(vehicleScheduleDTO);
    }

    // 출고요청일 2일 이전까지 창고의 모든 차량이 차량스케쥴표에 등록되어있는 지 조회
    @Override
    public boolean getVehicleSchedule(VehicleDTO vehicleDTO){
        int scheduledCount = outboundMapper.countRegisteredVehicleSchedule(vehicleDTO);
        int totalVehicleCount = outboundMapper.countAllVehiclesInWarehouse(vehicleDTO);

        // 3일치 모두 등록돼야 하므로 비교 시 3배
        return scheduledCount == (totalVehicleCount * 3);
    }

    //해당날짜의 창고의 모든 차량을 스케쥴표에 등록 (중복제외)
    @Override
    public void insertVehicleSchedule(VehicleDTO vehicleDTO) {
        List<VehicleVO> vehicleVOS = outboundMapper.getVehicleVO(vehicleDTO.getWarehouseCode());

        // 가장 마지막 코드 번호 가져오기
        String lastCode = outboundMapper.selectVehicleScheduleCode();
        int currentCodeNum = 0;
        if (lastCode != null && !lastCode.isEmpty()) currentCodeNum = Integer.parseInt(lastCode.replaceAll("\\D", ""));

        AtomicInteger codeCounter = new AtomicInteger(currentCodeNum);
        //차량 스케쥴 등록
        vehicleVOS.forEach(vehicleVO -> {
            String newCode = String.format("VS%03d", codeCounter.incrementAndGet());
            outboundMapper.insertVehicleSchedule(VehicleScheduleVO.builder()
                    .vehicleScheduleCode(newCode)
                    .dispatchDate(vehicleDTO.getOutboundDate())
                    .remainingCapacity(vehicleVO.getCapacity())
                    .vehicleCode(vehicleVO.getVehicleCode())
                    .build());
        });
    }

    //출고 승인 처리
    @Transactional
    @Override
    public boolean processOutbound(String outboundCode, String warehouseCode) {
        // 1. 출고 VO 조회 + 비관적락(FOR UPDATE)
        OutboundVO outboundVO = outboundMapper.selectOutboundVoOneForUpdate(outboundCode);

        // 2. 이미 처리된 출고면 실패 처리
        if (!"출고대기".equals(outboundVO.getOutboundStatus())) {
            return false;
        }

        // 3. 재고 존재 여부 확인
        if (!outboundMapper.checkInventory(outboundCode)) {
            return false;
        }

        // 4. 출고 상태 변경(출고 준비)
        outboundMapper.approveOutbound(outboundCode);

        // 5. 재고 반영 (재고 코드가 없으면 세팅까지 포함)
        updateInventory(outboundCode, warehouseCode);

        // 6. 차량 배치
        boolean vehicleAssigned = outboundVehicle(outboundCode);

        return vehicleAssigned;
    }

    //출고 완료처리 - 비관적락 적용
    @Override
    @Transactional
    public OutboundCompletionResult  processCompletion(List<String> outboundCodeList, String warehouseCode) {
        int successCount = 0;
        int failCount = 0;

        for (String outboundCode : outboundCodeList) {
            // 1. 출고 VO 조회 + FOR UPDATE (비관적 락)
            OutboundVO outboundVO = outboundMapper.selectOutboundVoOneForUpdate(outboundCode);

            // 2. 이미 완료된 출고면 실패 처리
            if (!"출고대기".equals(outboundVO.getOutboundStatus())) {
                log.info("이미 처리된 출고: {}", outboundCode);
                failCount++;
                continue;
            }

            // 3. 섹션 코드 생성 및 존재 여부 확인
            String sectionCode = getSectionCode(warehouseCode, outboundCode);
            if (!outboundMapper.checkSection(sectionCode)) {
                log.warn("섹션 없음: {}", outboundCode);
                failCount++;
                continue;
            }

            // 4. 출고 완료 처리
            outboundMapper.completionOutbound(outboundCode);

            // 5. 섹션 용량 반영
            SectionUpdate(sectionCode, outboundVO.getQuantity());

            // 6. 발주 상태 변경 + 메일 발송
            completionOrder(outboundCode);

            successCount++;
        }

        log.info("출고 처리 결과: 성공={}건, 실패={}건", successCount, failCount);

        return new OutboundCompletionResult(successCount, failCount);
    }


}