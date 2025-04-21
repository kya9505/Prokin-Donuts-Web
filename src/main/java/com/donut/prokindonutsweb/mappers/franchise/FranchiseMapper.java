package com.donut.prokindonutsweb.mappers.franchise;

import com.donut.prokindonutsweb.dto.franchise.FranchiseDTO;
import com.donut.prokindonutsweb.vo.franchise.FranchiseVO;
import com.donut.prokindonutsweb.vo.member.MemberAccountVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
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
