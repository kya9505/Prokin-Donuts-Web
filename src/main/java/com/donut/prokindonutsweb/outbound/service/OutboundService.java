package com.donut.prokindonutsweb.outbound.service;

import com.donut.prokindonutsweb.outbound.dto.OutboundCompletionResult;
import com.donut.prokindonutsweb.outbound.dto.OutboundDTO;
import com.donut.prokindonutsweb.outbound.dto.VehicleDTO;
import com.donut.prokindonutsweb.outbound.dto.VehicleScheduleDTO;

import java.util.List;

public interface OutboundService {

    List<OutboundDTO> findOutboundList(String warehouseCode);
    List<OutboundDTO> findApprovalOutboundList(String warehouseCode);
    List<OutboundDTO> findCompletionOutboundList(String warehouseCode);


    boolean checkSectionCode(String sectionCode);
    String findStoredType(String outboundCode);
    void completionOrder(String outboundCode);
    void SectionUpdate(String sectionCode ,int quantity);
    String getSectionCode(String warehouseCode, String outboundCode);
    boolean updateInventory(String outboundCode,String warehouseCode);
    String getWarehouseCode(String memberCode);
    VehicleScheduleDTO getVehicle(VehicleDTO vehicleDTO);
    boolean outboundVehicle(String outboundCode);
    void addVehicleshcedule(VehicleScheduleDTO vehicleScheduleDTO);
    boolean getVehicleSchedule(VehicleDTO vehicleDTO);
    void insertVehicleSchedule(VehicleDTO vehicleDTO);
    boolean processOutbound(String outboundCode, String warehouseCode);
    OutboundCompletionResult processCompletion(List<String> outboundCodeList, String warehouseCode);
}