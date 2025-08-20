package com.donut.prokindonutsweb.scheduler.mapper;

import com.donut.prokindonutsweb.scheduler.dto.ManagerWarehouseInfoDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface WarehouseManagerMapper {
  
  /**
   * 유효한 창고가 하나 이상 있는 관리자 이메일·이름·창고명 전체 조회
   */
  @Select("""
        SELECT DISTINCT
          m.email AS email,
          m.name AS managerName,
          w.warehouseName AS warehouseName
        FROM Warehouse w
        JOIN MemberAccount m
          ON w.memberCode = m.memberCode
        WHERE w.warehouseCode IS NOT NULL
    """)
  List<ManagerWarehouseInfoDTO> findManagerInfoWithWarehouses();
}