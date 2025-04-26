package com.donut.prokindonutsweb.order.mapper;

import com.donut.prokindonutsweb.order.vo.OrderDetailVO;
import com.donut.prokindonutsweb.order.vo.OrderVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderMapper {

    // 발주 요청 저장
    void insertOrder(OrderVO orderVO);

    // 발주 상세 정보 저장
    void insertOrderDetailList(@Param("list") List<OrderDetailVO> list);

    String selectOrderCode();

    String selectFranchiseCode(String memberCode);
}
