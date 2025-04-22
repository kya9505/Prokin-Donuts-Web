package com.donut.prokindonutsweb.inbound.service;

import com.donut.prokindonutsweb.inbound.dto.*;
import com.donut.prokindonutsweb.inbound.mapper.InboundMapper;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;

@Service
@RequiredArgsConstructor
public class InboundServiceImpl implements InboundService {
    private final ModelMapper modelMapper;

    private final InboundMapper inboundMapper;

    @Override
    public Optional<List<ProductDTO>> findAllProductList() {
        // VO -> DTO 변환작업
        List<ProductDTO> list = inboundMapper.selectAllProductList()
                .stream()
                .map(vo -> modelMapper.map(vo, ProductDTO.class))
                .toList();// 또는 collect(Collectors.toList());
        return list.isEmpty() ? Optional.empty() : Optional.of(list);
    }

    /**
     * 입고 요청 등록
     * 입고 정보 + 입고 상세 정보
     * 트랜잭션 처리
     *
     * @param '입고정보'
     * @param '입고    상세 정보'
     */
    @Override
    @Transactional
    public void addInbound(InboundDTO inboundDTO, List<InboundDetailDTO> inboundDetailList) {
        InboundVO inboundVO = modelMapper.map(inboundDTO, InboundVO.class);
        inboundMapper.insertInbound(inboundVO);

        String inboundCode = inboundDTO.getInboundCode();
        List<InboundDetailVO> inboundDetailVOList = getInboundDetailList(inboundDetailList, inboundCode);

        inboundMapper.insertInboundDetailList(inboundDetailVOList);
    }

    private List<InboundDetailVO> getInboundDetailList(List<InboundDetailDTO> inboundDetailList, String inboundCode) {
        AtomicInteger i = new AtomicInteger(1);
        return inboundDetailList.stream().map(
                dto -> InboundDetailVO.builder()
                        .inboundDetailCode(inboundCode + "-" + i.getAndIncrement())
                        .quantity(dto.getQuantity())
                        .inboundCode(inboundCode)
                        .productCode(dto.getProductCode())
                        .sectionCode(getSection(dto.getStoredType()))
                        .build()
        ).toList();
    }

    private String getSection(String storedType) {
        return StoredType.fromSectionCode(storedType).getLabel();
    }


    @Override
    public String findNextInboundCode() {
        String inboundCode = inboundMapper.selectInboundCode();
        int number = Integer.parseInt(inboundCode.replaceAll("\\D", ""));
        return "IN" + (number + 1);
    }

    //    입고관리 페이지에는 (입고요청, 승인대기) 상태 입고목록만 보여진다.
    @Override
    public Optional<List<InboundDTO>> findAllInboundList() {
        List<InboundDTO> list = inboundMapper.selectAllInboundList().stream()
                .filter(vo -> InboundStatus.REQUEST.getStatus().equals(vo.getInboundStatus()) || InboundStatus.APPROVE.getStatus().equals(vo.getInboundStatus()))
                .map(vo -> modelMapper.map(vo, InboundDTO.class)).
                toList();
        return list.isEmpty() ? Optional.empty() : Optional.of(list);
    }

    // 입고상세 목록 변환 작업
    @Override
    public Optional<List<InboundDetailDTO>> findAllInboundDetailList() {
        List<InboundDetailDTO> list = inboundMapper.selectAllInboundDetailList()
                .stream()
                .map(vo -> {
                            InboundDetailDTO dto = InboundDetailDTO.builder()
                                    .inboundCode(vo.getInboundCode())
                                    .productCode(vo.getProductCode())
                                    .productName(inboundMapper.selectProductName(vo.getProductCode()))
                                    .productPrice(inboundMapper.selectProductPrice(vo.getProductCode()))
                                    .storedType(getStoredType(vo.getSectionCode()))
                                    .quantity(vo.getQuantity())
                                    .build();
                            return dto;
                        }
                ).toList();
        return list.isEmpty() ? Optional.empty() : Optional.of(list);
    }

    private String getStoredType(String sectionCode) {
        char type = sectionCode.charAt(sectionCode.length() - 1);
        if (type == 'R') return "냉장";
        else if (type == 'F') return "냉동";
        else return "상온";
    }

    @Override
    public void approveInbound(String inboundCode) {
        inboundMapper.approveInbound(inboundCode);
    }

    @Override
    public Optional<List<InventoryDTO>> findInboundDetailList(String inboundCode) {
        return Optional.of(new ArrayList<>(inboundMapper.selectInboundDetailList(inboundCode)));
    }

    @Override
    public void updateInventory(InventoryVO inventoryVO) {
        inboundMapper.updateInventory(inventoryVO);
    }

    @Transactional
    @Override
    public void updateInbound(List<InboundUpdateDTO> list, LocalDate inboundDate) {
        String inboundCode = list.get(0).getInboundCode();
        inboundMapper.updateInboundDate(inboundDate, inboundCode);

        list.stream().forEach(
                inboundMapper::updateInbound
        );
    }


    @Override
    public void deleteInbound(String inboundCode) {
        inboundMapper.deleteInbound(inboundCode);
    }

    @Override
    public Optional<List<InboundStatusDTO>> findAllInboundStatusList() {
        List<InboundStatusDTO> list = inboundMapper.selectAllInboundStatusList()
                .stream()
                .map(vo -> {
                    InboundStatusDTO dto = InboundStatusDTO.builder()
                            .inboundCode(vo.getInboundCode())
                            .productCode(vo.getProductCode())
                            .productName(vo.getProductName())
                            .productPrice(vo.getProductPrice())
                            .inboundDate(vo.getInboundDate())
                            .inboundStatus(vo.getInboundStatus())
                            .sectionCode(vo.getSectionCode())
                            .quantity(vo.getQuantity())
                            .build();
                    return dto;
                }).toList();
        return list.isEmpty() ? Optional.empty() : Optional.of(list);
    }

    @Override
    public void qhUpdateInboundStatus(String inboundCode) {
        inboundMapper.updateQhInboundStatus(inboundCode);
    }


    //    본사관리자 페이지에는 (입고요청) 상태 입고목록만 보여진다.
    @Override
    public Optional<List<InboundDTO>> findAllQhInboundList() {
        List<InboundDTO> list = inboundMapper.selectAllInboundList().stream()
                .filter(vo -> "입고요청".equals(vo.getInboundStatus()))
                .map(vo -> {
                            InboundDTO dto = InboundDTO.builder()
                                    .inboundCode(vo.getInboundCode())
                                    .inboundDate(vo.getInboundDate())
                                    .inboundStatus(vo.getInboundStatus())
                                    .warehouseCode(vo.getWarehouseCode())
                                    .build();
                            return dto;
                        }
                ).toList();
        return list.isEmpty() ? Optional.empty() : Optional.of(list);
    }

}
