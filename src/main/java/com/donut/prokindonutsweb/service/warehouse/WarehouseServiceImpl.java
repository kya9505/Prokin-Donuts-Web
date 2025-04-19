package com.donut.prokindonutsweb.service.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseCheckDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseDeleteDTO;
import com.donut.prokindonutsweb.dto.warehouse.WarehouseUpdateDTO;
import com.donut.prokindonutsweb.mappers.warehouse.WarehouseMapper;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import com.donut.prokindonutsweb.vo.warehouse.WarehouseVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Log4j2
@RequiredArgsConstructor
public class WarehouseServiceImpl implements WarehouseService {
  private final ModelMapper modelMapper;
  private final WarehouseMapper warehouseMapper;
  
  @Override
  @Transactional(readOnly = true)
  public List<WarehouseDTO> findWarehouseList() {
    log.debug("Service : findWarehouseList called");
    return warehouseMapper.selectWarehouseList();
  }
  
  @Override
  public void addWarehouse(WarehouseDTO warehouseDTO) {
    log.debug("Service : addWarehouse called");
    WarehouseVO warehouseVO = modelMapper.map(warehouseDTO, WarehouseVO.class);
    warehouseMapper.insertWarehouse(warehouseVO);
  }
  
  @Override
  public void updateWarehouse(WarehouseUpdateDTO warehouseUpdateDTO) {
    log.debug("Service : updateWarehouse called");
    WarehouseVO warehouseVO = modelMapper.map(warehouseUpdateDTO, WarehouseVO.class);
    warehouseMapper.updateWarehouse(warehouseVO);
  }
  
  @Override
  public void deleteWarehouse(WarehouseDeleteDTO warehouseDeleteDTO) {
    log.debug("Service : deleteWarehouse called");
    WarehouseVO warehouseVO = modelMapper.map(warehouseDeleteDTO, WarehouseVO.class);
    warehouseMapper.deleteWarehouse(warehouseVO);
  }
  
  @Override
  @Transactional(readOnly = true)
  public List<MemberAccountVO> getUnassignedWarehouseManagers() {
    log.debug("Service : getUnassignedWarehouseManagers called");
    return warehouseMapper.selectUnAccountWMList();
  }
  
  @Override
  public boolean checkWarehouseDuplicate(WarehouseCheckDTO warehouseCheckDTO) {
    log.debug("Service : checkWarehouseDuplicate called");
    WarehouseVO warehouseVO = modelMapper.map(warehouseCheckDTO, WarehouseVO.class);
    int count = warehouseMapper.checkWarehouseDuplicate(warehouseVO);
    return count > 0;
  }
}
