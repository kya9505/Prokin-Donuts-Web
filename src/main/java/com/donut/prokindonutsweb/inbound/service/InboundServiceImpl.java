package com.donut.prokindonutsweb.inbound.service;

import com.donut.prokindonutsweb.inbound.dto.*;
import com.donut.prokindonutsweb.inbound.mapper.InboundMapper;
import com.donut.prokindonutsweb.inbound.vo.InboundDetailVO;
import com.donut.prokindonutsweb.inbound.vo.InboundVO;
import com.donut.prokindonutsweb.inbound.vo.InventoryVO;
import java.time.format.DateTimeFormatter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;

@Service
@RequiredArgsConstructor
@Slf4j
public class InboundServiceImpl implements InboundService {

	private final ModelMapper modelMapper;

	private final InboundMapper inboundMapper;

	@Override
	public Optional<List<ProductDTO>> findProductList() {
		// VO -> DTO 변환작업
		List<ProductDTO> list = inboundMapper.selectAllProductList()
				.stream()
				.map(vo -> modelMapper.map(vo, ProductDTO.class))
				.toList();// 또는 collect(Collectors.toList());
		return list.isEmpty() ? Optional.empty() : Optional.of(list);
	}

	/**
	 * 입고 요청 등록 입고 정보 + 입고 상세 정보 트랜잭션 처리
	 *
	 * @param '입고정보'
	 * @param '입고    상세 정보'
	 */
	@Override
	@Transactional
	public void addInbound(InboundDTO inboundDTO, List<InboundDetailDTO> inboundDetailList) {
		InboundVO inboundVO = modelMapper.map(inboundDTO, InboundVO.class);
		inboundMapper.insertInbound(inboundVO);

		List<InboundDetailVO> inboundDetailVOList = getInboundDetailList(inboundDetailList,
				inboundDTO);

		inboundMapper.insertInboundDetailList(inboundDetailVOList);
	}

	@Override
	public String getWarehouseCode(String memberCode) {
		return inboundMapper.selectWarehouseCode(memberCode);
	}

	private List<InboundDetailVO> getInboundDetailList(List<InboundDetailDTO> inboundDetailList,
			InboundDTO inboundDTO) {
		AtomicInteger i = new AtomicInteger(1);
		String inboundCode = inboundDTO.getInboundCode();
		String warehouseCode = inboundDTO.getWarehouseCode();

		return inboundDetailList.stream().map(
				dto -> InboundDetailVO.builder()
						.inboundDetailCode(inboundCode + "-" + i.getAndIncrement())
						.quantity(dto.getQuantity())
						.inboundCode(inboundCode)
						.productCode(dto.getProductCode())
						.sectionCode(warehouseCode + "-" + getSection(dto.getStoredType()))
						.build()
		).toList();
	}

	private String getSection(String storedType) {
		if (storedType.equals("냉동")) {
			return "F";
		} else if (storedType.equals("냉장")) {
			return "R";
		} else {
			return "A";
		}
	}

	/**
	 * 입고 코드 자동 생성기
	 *
	 * @return '입고코드'
	 */
	@Override
	public String findNextInboundCode() {
		String inboundCode = inboundMapper.selectInboundCode();
		int number = Integer.parseInt(inboundCode.replaceAll("\\D", ""));
		return "IN" + (number + 1);
	}

	//    입고관리 페이지에는 (입고요청, 승인대기) 상태 입고목록만 보여진다.
	@Override
	public List<InboundDTO> findInboundList(String warehouseCode) {
		List<InboundDTO> list = inboundMapper.selectAllInboundList().stream()
				.filter(vo -> InboundStatus.REQUEST.getStatus().equals(vo.getInboundStatus())
						|| InboundStatus.APPROVE.getStatus().equals(vo.getInboundStatus())
						&& vo.getWarehouseCode().equals(warehouseCode))
				.map(vo -> modelMapper.map(vo, InboundDTO.class)).
				toList();
		return list;
	}

	// 입고상세 목록 변환 작업
	@Override
	public List<InboundDetailDTO> findInboundDetailList() {
		List<InboundDetailDTO> list = inboundMapper.selectAllInboundDetailList()
				.stream()
				.map(vo -> InboundDetailDTO.builder()
						.inboundCode(vo.getInboundCode())
						.productCode(vo.getProductCode())
						.productName(inboundMapper.selectProductName(vo.getProductCode()))
						.productPrice(inboundMapper.selectProductPrice(vo.getProductCode()))
						.storedType(getStoredType(vo.getSectionCode()))
						.quantity(vo.getQuantity())
						.build()
				).toList();
		return list;
	}

	private String getStoredType(String sectionCode) {
		char type = sectionCode.charAt(sectionCode.length() - 1);
		if (type == 'R') {
			return "냉장";
		} else if (type == 'F') {
			return "냉동";
		} else {
			return "상온";
		}
	}

	// 입고 상태를 변경한다 (-> 입고완료)
	@Override
	public void approveInbound(String inboundCode) {
		inboundMapper.approveInbound(inboundCode);
	}

	@Override
	public Optional<List<InventoryDTO>> findInboundDetailList(String inboundCode) {
		return Optional.of(new ArrayList<>(inboundMapper.selectInboundDetailList(inboundCode)));
	}

	// 입고 완료 시 재고 변경사항 적용
	@Override
	public void updateInventory(List<InventoryDTO> inventoryList) {
		inventoryList.forEach(
				dto -> {
					LocalDate expirationDate = getExpirationDate(inboundMapper.selectStoredType(dto.getProductCode()));
					InventoryVO vo = InventoryVO.builder()
							.quantity(dto.getQuantity())
							.productCode(dto.getProductCode())
							.warehouseCode(dto.getWarehouseCode())
							.barcode(getBarCode(dto.getWarehouseCode(), dto.getProductCode(), expirationDate))
							.expirationDate(expirationDate)
							.build();
					log.info(vo.toString());
					inboundMapper.updateInventory(vo);
				}
		);
	}

	@Transactional
	@Override
	public void updateInbound(List<InboundUpdateDTO> list, LocalDate inboundDate) {
		String inboundCode = list.get(0).getInboundCode();
		inboundMapper.updateInboundDate(inboundDate, inboundCode);

		list.forEach(inboundMapper::updateInbound);
	}


	@Override
	public void deleteInbound(String inboundCode) {
		inboundMapper.deleteInbound(inboundCode);
	}

	@Override
	public Optional<List<InboundStatusDTO>> findWMInboundStatusList(String warehouseCode) {
		List<InboundStatusDTO> list = inboundMapper.selectAllInboundStatusList()
				.stream()
				.filter(vo -> vo.getSectionCode().split("-")[0].equals(warehouseCode))
				.map(vo -> modelMapper.map(vo, InboundStatusDTO.class))
				.toList();
		return list.isEmpty() ? Optional.empty() : Optional.of(list);
	}

	public Optional<List<InboundStatusDTO>> findInboundStatusList() {
		List<InboundStatusDTO> list = inboundMapper.selectAllInboundStatusList()
				.stream()
				.map(vo -> modelMapper.map(vo, InboundStatusDTO.class))
				.toList();
		return list.isEmpty() ? Optional.empty() : Optional.of(list);
	}

	@Override
	public void updateInboundStatus(String inboundCode) {
		inboundMapper.updateQhInboundStatus(inboundCode);
	}


	//    본사관리자 페이지에는 (입고요청) 상태 입고목록만 보여진다.
	@Override
	public Optional<List<InboundDTO>> findQhInboundList() {
		List<InboundDTO> list = inboundMapper.selectAllInboundList().stream()
				.filter(vo -> InboundStatus.REQUEST.getStatus().equals(vo.getInboundStatus()))
				.map(vo -> modelMapper.map(vo, InboundDTO.class))
				.toList();
		return list.isEmpty() ? Optional.empty() : Optional.of(list);
	}

	// 제품 보관 타입 -> 유통기한 정보 확인
	private LocalDate getExpirationDate(String storedType) {
		return switch (storedType) {
			case "냉장" -> LocalDate.now().plusDays(3);
			case "냉동" -> LocalDate.now().plusDays(30);
			case "상온" -> LocalDate.now().plusDays(365);
			default -> null;
		};
	}

	// 바코드 형식 만들기 (창코코드-제품코드-유통기한)
	private String getBarCode(String warehouseCode, String productCode, LocalDate expirationDate) {
		String dateStr = expirationDate.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		return warehouseCode +"-"+ productCode +"-"+ dateStr;
	}
}
