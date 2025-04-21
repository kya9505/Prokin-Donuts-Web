package com.donut.prokindonutsweb.service.franchise;

import com.donut.prokindonutsweb.dto.franchise.FranchiseCheckDTO;
import com.donut.prokindonutsweb.dto.franchise.FranchiseDTO;
import com.donut.prokindonutsweb.dto.franchise.FranchiseDeleteDTO;
import com.donut.prokindonutsweb.dto.franchise.FranchiseUpdateDTO;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;

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
