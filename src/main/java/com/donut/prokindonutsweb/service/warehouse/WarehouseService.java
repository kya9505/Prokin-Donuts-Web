package com.donut.prokindonutsweb.service.warehouse;

import com.donut.prokindonutsweb.dto.warehouse.WarehouseDTO;

import java.util.List;
import java.util.Optional;

public interface WarehouseService {
  List<WarehouseDTO> findWarehouseList();
}
