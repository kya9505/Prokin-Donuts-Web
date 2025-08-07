package com.donut.prokindonutsweb.outbound.service;

import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.dto.VehicleDTO;
import com.donut.prokindonutsweb.outbound.dto.VehicleScheduleDTO;
import com.donut.prokindonutsweb.outbound.vo.OutboundVO;

import java.util.List;

public interface OutboundService {

    List<OutboundDTO> findOutboundList(String warehouseCode);
    List<OutboundDTO> findApprovalOutboundList(String warehouseCode);
    List<OutboundDTO> findCompletionOutboundList(String warehouseCode);


    boolean checkInventory(String outboundCode);
    boolean checkSectionCode(String sectionCode);
    int getQuantity(String outboundCode);
    void approveOutbound(String outboundCode);
    String findStoredType(String outboundCode);
    void completionOutbound(String outboundCode);
    void completionOrder(String outboundCode);
    void SectionUpdate(String sectionCode ,int quantity);
    String getSectionCode(String warehouseCode, String outboundCode);
    void updateInventory(String outboundCode,String warehouseCode);
    String getWarehouseCode(String memberCode);
    VehicleScheduleDTO getVehicle(VehicleDTO vehicleDTO);
    boolean outboundVehicle(String outboundCode);
    void addVehicleshcedule(VehicleScheduleDTO vehicleScheduleDTO);
    boolean getVehicleSchedule(VehicleDTO vehicleDTO);
    void insertVehicleSchedule(VehicleDTO vehicleDTO);
}