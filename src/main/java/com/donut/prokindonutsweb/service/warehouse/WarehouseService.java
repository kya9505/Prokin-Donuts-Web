package com.donut.prokindonutsweb.service.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseCheckDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDeleteDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseUpdateDTO;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;

import java.util.List;
import java.util.Optional;

public interface WarehouseService {
  List<WarehouseDTO> findWarehouseList();
  void addWarehouse(WarehouseDTO warehouseDTO);
  void updateWarehouse(WarehouseUpdateDTO warehouseUpdateDTO);
  void deleteWarehouse(WarehouseDeleteDTO warehouseDeleteDTO);
  List<MemberAccountVO> getUnassignedWarehouseManagers();
  boolean checkWarehouseDuplicate(WarehouseCheckDTO warehouseCheckDTO);
}
