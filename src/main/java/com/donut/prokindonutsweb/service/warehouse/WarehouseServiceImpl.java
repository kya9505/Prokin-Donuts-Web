package com.donut.prokindonutsweb.service.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;
import com.donut.prokindonutsweb.mappers.warehouse.WarehouseMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Log4j2
@RequiredArgsConstructor
public class WarehouseServiceImpl implements WarehouseService {
  //private final ModelMapper modelMapper;
  private final WarehouseMapper warehouseMapper;
  
  @Override
  @Transactional(readOnly = true)
  public List<WarehouseDTO> findWarehouseList() {
    log.debug("Service : findWarehouseList called");
    return warehouseMapper.selectWarehouseList();
  }
}
