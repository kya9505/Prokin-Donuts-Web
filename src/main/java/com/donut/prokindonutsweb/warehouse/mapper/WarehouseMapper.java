package com.donut.prokindonutsweb.warehouse.mapper;

import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import com.donut.prokindonutsweb.warehouse.dto.WarehouseDTO;
import com.donut.prokindonutsweb.warehouse.vo.WarehouseVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface WarehouseMapper {
  List<WarehouseDTO> selectWarehouseList();
  void insertWarehouse(WarehouseVO warehouse);
  void updateWarehouse(WarehouseVO warehouse);
  void deleteWarehouse(WarehouseVO warehouse);
  List<MemberAccountVO> selectUnAccountWMList();
  int checkWarehouseDuplicate(WarehouseVO warehouse);
  List<String> selectWarehouseCodesByPrefix(String prefix);
  String selectWarehouseStatus(String warehouseCode);
}
