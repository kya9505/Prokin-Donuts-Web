package com.donut.prokindonutsweb.service.inbound;

import com.donut.prokindonutsweb.dto.inbound.*;
import com.donut.prokindonutsweb.mappers.inbound.InboundMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class InboundServiceImpl implements InboundService {

    private final InboundMapper inboundMapper;
    @Override
    public Optional<List<ProductDTO>> findAllProductList() {

        // VO -> DTO 변환작업
        List<ProductDTO> list = inboundMapper.selectAllProductList()
                .stream()
                .map(vo -> ProductDTO.builder()
                        .productCode(vo.getProductCode())
                        .productName(vo.getProductName())
                        .productPrice(vo.getProductPrice())
                        .storedType(vo.getStoredType())
                        .build())
                .toList();// 또는 collect(Collectors.toList());
        return list.isEmpty() ? Optional.empty() : Optional.of(list);
    }

    @Override
    public void saveInbound(InboundDTO inboundDTO) {
        InboundVO vo = InboundVO.builder()
                .inboundCode(inboundDTO.getInboundCode())
                .inboundDate(inboundDTO.getInboundDate())
                .inboundStatus(inboundDTO.getInboundStatus())
                .warehouseCode(inboundDTO.getWarehouseCode())
                        .build();
        inboundMapper.insertInbound(vo);
    }

    @Override
    public void saveInboundDetail(List<InboundDetailDTO> list) {
        String inboundCode = inboundMapper.selectInboundCode();

        AtomicInteger i= new AtomicInteger(1);

        List<InboundDetailVO> inboundDetailVOList = list.stream().map(
                dto -> {
                    InboundDetailVO vo = InboundDetailVO.builder()
                            .inboundDetailCode(inboundCode + "-" + i.getAndIncrement())
                            .quantity(dto.getQuantity())
                            .inboundCode(inboundCode)
                            .productCode(dto.getProductCode())
                            .sectionCode(getSection(dto.getStoredType()))
                            .build();
                    return vo;
                }
        ).toList();

        inboundMapper.insertInboundDetailList(inboundDetailVOList);

    }

    private String getSection(String storedType) {
        // 창코코드 알게 되면 변경 예정
        if(storedType.equals("냉장")) return "R";
        else if(storedType.equals("냉동")) return "F";
        else return "A";
    }



    @Override
    public String findNextInboundCode() {
        String inboundCode = inboundMapper.selectInboundCode();
        int number = Integer.parseInt(inboundCode.replaceAll("\\D", ""));
        return "IN" + (number+1);
    }


}
