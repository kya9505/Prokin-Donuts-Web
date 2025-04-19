package com.donut.prokindonutsweb.mappers.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseCheckDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDeleteDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseUpdateDTO;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import com.donut.prokindonutsweb.vo.warehouse.WarehouseVO;
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
}
