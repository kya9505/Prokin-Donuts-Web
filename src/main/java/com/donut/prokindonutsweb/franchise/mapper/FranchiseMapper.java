package com.donut.prokindonutsweb.franchise.mapper;

import com.donut.prokindonutsweb.franchise.dto.FranchiseDTO;
import com.donut.prokindonutsweb.franchise.vo.FranchiseVO;
import com.donut.prokindonutsweb.member.vo.MemberAccountVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

public interface FranchiseMapper {
  List<FranchiseDTO> selectFranchiseList();
  void insertFranchise(FranchiseVO franchise);
  void updateFranchise(FranchiseVO franchise);
  void deleteFranchise(FranchiseVO franchise);
  List<MemberAccountVO> selectUnAccountFMList();
  int checkFranchiseDuplicate(FranchiseVO franchise);
  List<String> selectFranchiseCodesByPrefix(String prefix);
  String selectFranchiseStatus(String franchiseCode);
}
