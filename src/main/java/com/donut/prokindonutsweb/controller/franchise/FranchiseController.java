package com.donut.prokindonutsweb.controller.franchise;


import com.donut.prokindonutsweb.dto.franchise.FranchiseCheckDTO;
import com.donut.prokindonutsweb.dto.franchise.FranchiseDTO;
import com.donut.prokindonutsweb.dto.franchise.FranchiseDeleteDTO;
import com.donut.prokindonutsweb.dto.franchise.FranchiseUpdateDTO;
import com.donut.prokindonutsweb.service.franchise.FranchiseService;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/qh/franchise")
public class FranchiseController {
  private final FranchiseService franchiseService;
  
  // 1. 전체 가맹점 목록 조회
  @GetMapping
  public void qhGetFranchiseList(Model model) {
    log.info("Controller : qhGetFranchiseList called");
    List<FranchiseDTO> franchiseList = franchiseService.findFranchiseList();
    List<MemberAccountVO> unassignedFMs = franchiseService.findUnassignedFranchiseManagers();
    
    for (FranchiseDTO dto : franchiseList) {
      String status = franchiseService.findFranchiseStatus(dto.getFranchiseCode());
      dto.setStatus(status != null ? status : "삭제가능");
    }
    
    model.addAttribute("franchiseList", franchiseList);
    model.addAttribute("unassignedFMs", unassignedFMs);
  }
  
  // 2. 가맹점 등록
  @PostMapping("/add")
  public String qhAddFranchise(FranchiseDTO franchiseDTO) {
    log.info("Controller : qhAddFranchise called");
    if ("null".equals(franchiseDTO.getMemberCode()) || "".equals(franchiseDTO.getMemberCode())) {
      franchiseDTO.setMemberCode(null);
    }
    
    franchiseService.saveFranchise(franchiseDTO);
    return "redirect:/qh/franchise";
  }
  
  // 3. 가맹점 수정
  @PostMapping("/update")
  public String qhUpdateFranchise(FranchiseUpdateDTO franchiseUpdateDTO) {
    log.info("Controller : qhUpdateFranchise called");
    if ("null".equals(franchiseUpdateDTO.getMemberCode()) || "".equals(franchiseUpdateDTO.getMemberCode())) {
      franchiseUpdateDTO.setMemberCode(null);
    }
    franchiseService.updateFranchise(franchiseUpdateDTO);
    return "redirect:/qh/franchise";
  }
  
  // 4. 가맹점 삭제
  @PostMapping("/delete")
  public String qhDeleteFranchise(FranchiseDeleteDTO franchiseDeleteDTO) {
    log.info("Controller : qhDeleteFranchise called");
    franchiseService.deleteFranchise(franchiseDeleteDTO);
    return "redirect:/qh/franchise";
  }
  
  // 5. 가맹점명 중복 확인
  @GetMapping(value = "/check", produces = "application/json")
  @ResponseBody
  public String qhCheckFranchiseDuplicate(
      @RequestParam("franchiseName") String franchiseName,
      @RequestParam(value = "franchiseCode", required = false) String franchiseCode) {
    log.info("Controller : qhCheckFranchiseDuplicate called");
    FranchiseCheckDTO dto = new FranchiseCheckDTO();
    dto.setFranchiseName(franchiseName);
    dto.setFranchiseCode(franchiseCode);
    return franchiseService.checkFranchiseDuplicate(dto) ? "true" : "false";
  }
}