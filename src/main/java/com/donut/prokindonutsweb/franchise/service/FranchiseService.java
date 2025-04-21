package com.donut.prokindonutsweb.franchise.service;

import com.donut.prokindonutsweb.franchise.dto.FranchiseCheckDTO;
import com.donut.prokindonutsweb.franchise.dto.FranchiseDTO;
import com.donut.prokindonutsweb.franchise.dto.FranchiseDeleteDTO;
import com.donut.prokindonutsweb.franchise.dto.FranchiseUpdateDTO;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;

import java.util.List;

public interface FranchiseService {
  List<FranchiseDTO> findFranchiseList();
  void saveFranchise(FranchiseDTO franchiseDTO);
  void updateFranchise(FranchiseUpdateDTO franchiseUpdateDTO);
  void deleteFranchise(FranchiseDeleteDTO franchiseDeleteDTO);
  List<MemberAccountVO> findUnassignedFranchiseManagers();
  boolean checkFranchiseDuplicate(FranchiseCheckDTO franchiseCode);
  String findFranchiseStatus(String franchiseCode);
}
