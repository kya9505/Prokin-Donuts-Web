package com.donut.prokindonutsweb.order.service;

import com.donut.prokindonutsweb.order.dto.OrderDTO;
import com.donut.prokindonutsweb.order.dto.OrderDetailDTO;
import com.donut.prokindonutsweb.order.mapper.OrderMapper;
import com.donut.prokindonutsweb.order.vo.OrderDetailVO;
import com.donut.prokindonutsweb.order.vo.OrderVO;
import com.donut.prokindonutsweb.outbound.mapper.OutboundMapper;
import com.donut.prokindonutsweb.outbound.vo.OutboundVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
    private final OrderMapper orderMapper;
    private final OutboundMapper outboundMapper;

    //인접지역 맵
    private static final Map<String, List<String>> NEARBY_REGION_MAP = Map.ofEntries(
            Map.entry("SL", List.of("GG", "IC")),         // 서울 → 경기, 인천
            Map.entry("GG", List.of("SL", "IC", "CB", "CN")), // 경기 → 서울, 인천, 충북, 충남
            Map.entry("IC", List.of("SL", "GG")),         // 인천 → 서울, 경기
            Map.entry("GW", List.of("GG", "CB")),         // 강원 → 경기, 충북
            Map.entry("CB", List.of("DJ","GG", "CN", "GW")),   // 충북 → 대전, 경기, 충남, 강원
            Map.entry("CN", List.of("DJ","GG", "CB", "JB")), // 충남 → 대전,경기, 충북, 전북
            Map.entry("JB", List.of("CN", "JN", "GJ")),   // 전북 → 충남, 전남, 광주
            Map.entry("JN", List.of("JB", "GN", "GJ")),   // 전남 → 전북, 경남, 광주
            Map.entry("GB", List.of("DG", "GN")),   // 경북 → 대구, 경남
            Map.entry("GN", List.of("GB", "JN", "BS", "US")), // 경남 → 경북, 전남, 부산, 울산
            Map.entry("JJ", List.of("BS","JN","GN")),         // 제주 → 전남,부산,경남
            Map.entry("DJ", List.of("CN")),         // 대전 → 충남
            Map.entry("DG", List.of("GB", "GN","BS")),    // 대구 → 경북, 경남,부산
            Map.entry("GJ", List.of("JN","JB")),          // 광주 → 전남,전북
            Map.entry("BS", List.of("GN", "US")),         // 부산 → 경남, 울산
            Map.entry("US", List.of("GN", "BS")),         // 울산 → 경남, 부산
            Map.entry("SJ", List.of( "CB", "DJ","CN"))    // 세종 →  충북, 대전, 충남
    );

    @Transactional
    @Override
    public void addOrder(OrderDTO orderDTO, List<OrderDetailDTO> orderDetailList, String franchiseCode) {
        OrderVO orderVO = OrderVO.builder()
                .orderCode(orderDTO.getOrderCode())
                .orderDate(orderDTO.getOrderDate())
                .franchiseCode(franchiseCode)
                .build();
        orderMapper.insertOrder(orderVO);
        log.info(orderDTO.getOrderCode());
        List<OrderDetailVO> orderDetailVOList = getOrderDetailList(orderDTO, orderDetailList);
        orderMapper.insertOrderDetailList(orderDetailVOList);
    }

    private static List<OrderDetailVO> getOrderDetailList(OrderDTO orderDTO, List<OrderDetailDTO> orderDetailList) {
        AtomicInteger i = new AtomicInteger(1);
        String orderCode = orderDTO.getOrderCode();

        return orderDetailList.stream()
                .map(dto -> OrderDetailVO.builder()
                        .orderDetailCode(orderCode + "-" + i.getAndIncrement())
                        .quantity(dto.getQuantity())
                        .orderCode(orderCode)
                        .productCode(dto.getProductCode())
                        .orderStatus(dto.getOrderStatus())
                        .build()
                ).toList();
    }

    //발주 코드 생성
    @Override
    public String findNextOrderCode() {
        String orderCode = orderMapper.selectOrderCode();
        int number = Integer.parseInt(orderCode.replaceAll("\\D", ""));
        return "ORD" + (number + 1);
    }

    @Override
    public String findFranchiseCode(String memberCode) {
        return orderMapper.selectFranchiseCode(memberCode);
    }

    @Override
    public  List<OrderDTO> findOrderList(String FranchiseCode){
        return orderMapper.findOrderList(FranchiseCode);
    }

    @Override
    public List<OrderDetailDTO>findOrderDetailList(String orderCode){
        return orderMapper.findOrderDetailList(orderCode);
    }

    /**
     * 가맹점 인근 창고 조회 BFS(너비 우선 탐색)
     * 1. 현재 지역에서 창고를 조회
     * 2. 없으면 인접 지역을 순차적으로 탐색
     * 3. 이미 방문한 지역은 재조회하지 않음(중복 방지)
     */
    public String findWarehouseCodeToFranchise(String franchiseCode) {
        //가맹점 코드를 통해 지역조회
        String regionPrefix = franchiseCode.substring(0, 2);

        //큐와 방문 기록
        Queue<String> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();

        //큐(선입선출)와 방문기록(set:중복저장방지)에 현재 지역 저장
        queue.add(regionPrefix);
        visited.add(regionPrefix);
        //큐가 빌때까지 반복(모든 요소 poll할 때까지)
        while (!queue.isEmpty()){
            //큐에 저장된 최상위 요소(헤드) 검색 후 제거
            String currentRegion = queue.poll();
            //가맹점 위치와 일치하는 창고 존재여부 확인
            String warehouseCode = orderMapper.findWarehouseCodeOne(currentRegion);
            if (warehouseCode != null){
                return warehouseCode; // 존재하면 반환
            }
            //인접지역 조회
            List<String> nearbyRegions = NEARBY_REGION_MAP.get(currentRegion);
            //인접지역이 존재하고
            if (nearbyRegions != null) {
                for (String nearbyRegion : nearbyRegions)
                    //방문지역에 포함되어있지 않으면
                    if (!visited.contains(nearbyRegion)) {
                        //큐와 방문지역에 저장
                        queue.add(nearbyRegion);
                        visited.add(nearbyRegion);
                    }
            }
        }
        return null;
    }


    //출고 코드 생성
    @Override
    public String findNextOutboundCode() {
        String outboundCode = outboundMapper.selectOutboundCode();
        int number = Integer.parseInt(outboundCode.replaceAll("OB", ""));
        return "OB" + (number + 1);
    }


    //출고 삽입
    public void addOutbound(String warehouseCode, OrderDTO orderDTO, List<OrderDetailDTO> orderDetailList) {
        for (OrderDetailDTO orderDetailDTO : orderDetailList) {
            OutboundVO outboundVO = OutboundVO.builder()
                    .orderDetailCode(orderDetailDTO.getOrderDetailCode())
                    .outboundCode(findNextOutboundCode())
                    .outboundDate(orderDTO.getOrderDate().minusDays(1))
                    .outboundStatus("출고대기")
                    .quantity(orderDetailDTO.getQuantity())
                    .inventoryCode(orderMapper.findInventoryCode(
                            warehouseCode,
                            orderDetailDTO.getProductCode(),
                            orderDetailDTO.getQuantity()
                    ))
                    .vehicleCode(null) // 추후 배정
                    .build();

            outboundMapper.insertOutbound(outboundVO);
        }
    }
}
