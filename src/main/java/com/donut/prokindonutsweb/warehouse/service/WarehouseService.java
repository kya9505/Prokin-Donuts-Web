package com.donut.prokindonutsweb.warehouse.service;

import com.donut.prokindonutsweb.warehouse.dto.WarehouseCheckDTO;
import com.donut.prokindonutsweb.warehouse.dto.WarehouseDTO;
import com.donut.prokindonutsweb.warehouse.dto.WarehouseDeleteDTO;
import com.donut.prokindonutsweb.warehouse.dto.WarehouseUpdateDTO;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;

import java.util.List;

public interface WarehouseService {
  List<WarehouseDTO> findWarehouseList();
  void saveWarehouse(WarehouseDTO warehouseDTO);
  void updateWarehouse(WarehouseUpdateDTO warehouseUpdateDTO);
  void deleteWarehouse(WarehouseDeleteDTO warehouseDeleteDTO);
  List<MemberAccountVO> findUnassignedWarehouseManagers();
  boolean checkWarehouseDuplicate(WarehouseCheckDTO warehouseCheckDTO);
  String findWarehouseStatus(String warehouseCode);
}
