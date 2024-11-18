/**
 * YOU ARE STRICTLY PROHIBITED TO COPY, DISCLOSE, DISTRIBUTE, MODIFY OR USE THIS PROGRAM
 * IN PART OR AS A WHOLE WITHOUT THE PRIOR WRITTEN CONSENT OF HIMEDIA.CO.KR.
 * HIMEDIA.CO.KR OWNS THE INTELLECTUAL PROPERTY RIGHTS IN AND TO THIS PROGRAM.
 * COPYRIGHT (C) 2024 HIMEDIA.CO.KR ALL RIGHTS RESERVED.
 *
 * 하기 프로그램에 대한 저작권을 포함한 지적재산권은 himedia.co.kr에 있으며,
 * himedia.co.kr이 명시적으로 허용하지 않는 사용, 복사, 변경 및 제 3자에 의한 공개, 배포는 엄격히 금지되며
 * himedia.co.kr의 지적재산권 침해에 해당된다.
 * Copyright (C) 2024 himedia.co.kr All Rights Reserved.
 *
 *
 * Program		: kr.co.himedia.ecommerce
 * Description	:
 * Environment	: JRE 1.7 or more
 * File			: DetailSrvc.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241004170431][kogr0131#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.buy.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.challengefarm.front.basket.dao.BasketDao;
import kr.co.challengefarm.front.basket.dto.BasketDto;
import kr.co.challengefarm.front.buy.dao.BuyDao;
import kr.co.challengefarm.front.buy.dto.BuyDetailDto;
import kr.co.challengefarm.front.buy.dto.BuyDto;
import kr.co.challengefarm.front.buy.dto.BuyImgDto;
import kr.co.challengefarm.front.buy.dto.BuyMasterDto;
import kr.co.challengefarm.front.buy.dto.DeliveryDto;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;
import kr.co.challengefarm.front.member.dto.MemberDto;
import kr.co.challengefarm.front.mypage.dto.ReviewDto;
import kr.co.challengefarm.front.pay.dao.PayDao;
import kr.co.challengefarm.front.pay.dto.PayDto;
import kr.co.challengefarm.util.security.SKwithAES;

/**
 * @version 1.0.0
 * @author kogr0131#gmail.com
 * 
 * @since 2024-10-11
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */

@Service("kr.co.challengefarm.front.buy.service.BuySrvc")
public class BuySrvc {
	
	@Autowired
	Properties staticProperties;
	
	@Inject
	BuyDao buyDao;
	
	@Inject
	PayDao payDao;
	
	@Inject
	BasketDao basketDao;
	
	@Transactional("txFront")
	public int insertByOrderNum(BuyMasterDto buyMasterDto, ArrayList<BuyDetailDto> listBuyDetailDto, String num_order) {
			
		int result		= 0;
		int seq_buy_mst	= buyDao.sequenceMaster();
		
		// 구매 마스터 정보
		buyMasterDto.setSeq_buy_mst(seq_buy_mst);
		result += buyDao.insertMaster(buyMasterDto);
		
		// 구매 상세 정보들
		for (int loop = 0; loop < listBuyDetailDto.size(); loop++) {
			
			listBuyDetailDto.get(loop).setSeq_buy_dtl(buyDao.sequenceDetail());
			listBuyDetailDto.get(loop).setSeq_buy_mst(buyMasterDto.getSeq_buy_mst());
			//listBuyDetailDto.get(loop).setPrice((int) Math.floor(listBuyDetailDto.get(loop).getPrice() - listBuyDetailDto.get(loop).getPrice() * listBuyDetailDto.get(loop).getDiscount() / 100 ) * listBuyDetailDto.get(loop).getCount());
			listBuyDetailDto.get(loop).setPrice((listBuyDetailDto.get(loop).getPrice() - listBuyDetailDto.get(loop).getPrice() * listBuyDetailDto.get(loop).getDiscount() / 100 ) * listBuyDetailDto.get(loop).getCount());
			listBuyDetailDto.get(loop).setRegister(buyMasterDto.getRegister());
			result += buyDao.insertDetail(listBuyDetailDto.get(loop));
		}
		
		// 결제 정보
		PayDto payDto = new PayDto();
		payDto.setSeq_pay(payDao.sequence());
		payDto.setSeq_mbr(buyMasterDto.getSeq_mbr());
		payDto.setSeq_buy_mst(buyMasterDto.getSeq_buy_mst());
		payDto.setNum_order(num_order);
		payDto.setNum_deal("[INF]BASE ON ORDER NUM");
		payDto.setFlg_act("N");
		payDto.setRegister(buyMasterDto.getSeq_mbr());
		result += payDao.insert(payDto);
		
		if (result == 1 + listBuyDetailDto.size() + 1) return seq_buy_mst;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return 0;
		}
	}
	
	@Transactional("txFront")
	public boolean updateByOrderNum(String num_order, String num_deal, int updater, String flg_success, DeliveryDto deliveryDto) {
		
		int result = 0;
		
		PayDto payDto = new PayDto();
		payDto.setNum_order(num_order);
		payDto.setNum_deal(num_deal);
		payDto.setFlg_success(flg_success);			// 성공(Y), 실패(N)
		result += payDao.updateByOrderNum(payDto);
		
		payDto = payDao.select(payDto);
		BuyMasterDto buyMasterDto = new BuyMasterDto();
		buyMasterDto.setSeq_buy_mst(payDto.getSeq_buy_mst());
		buyMasterDto.setCd_state_pay(flg_success);	// 결제 전(NULL), 결제 완료(Y), 결제 실패(N), 결제 취소(C)
		buyMasterDto.setUpdater(updater);
		result += buyDao.update(buyMasterDto);
		
		// 결제 완료 후 배송 정보 추가
		deliveryDto.setSeq_dlv(buyDao.sequenceDelivery());
		deliveryDto.setSeq_buy_mst(buyMasterDto.getSeq_buy_mst());
		deliveryDto.setRegister(updater);
		result += buyDao.delivery(deliveryDto);
		
		// 장바구니에서 구매완료로 상태코드 변경
		BasketDto basketDto = new BasketDto();
		basketDto.setCd_state_pay("Y");
		basketDto.setUpdater(updater);
		basketDto.setSeq_mbr(updater);
		
		int basketSize = basketDao.selectState(basketDto);
		result += basketDao.updateState(basketDto);
				
		if (result == 3 + basketSize) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	public MemberDto info(BuyDto buyDto) {
		return buyDao.info(buyDto);
	}
	
	public BuyDto select(BuyDto buyDto) {
		return buyDao.select(buyDto);
	}
	
	public List<BuyImgDto> selectImg(BuyImgDto buyImgDto) {
		List<BuyImgDto> imageList = buyDao.selectImg(buyImgDto);
		
		if(!imageList.isEmpty()) {
			
		}
		return imageList;
	}

	public PagingListDto reviewlist(PagingDto pagingDto) {
		
		PagingListDto pagingListDto = new PagingListDto();
		
		// 전체 라인(행) 수
		int totalLine = buyDao.count(pagingDto);
		// 전체 페이지 수 = 전체 라인(행) 수 / 페이징할 라인수
		int totalPage = (int) Math.ceil((double)totalLine / (double)pagingDto.getLinePerPage());
		pagingDto.setTotalLine(totalLine);
		pagingDto.setTotalPage(totalPage);
		if (totalPage == 0) pagingDto.setCurrentPage(1);
		
		pagingListDto.setPaging(pagingDto);
		
		List<ReviewDto> reviewList = buyDao.reviewlist(pagingDto);
		
		String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
		SKwithAES aes		= new SKwithAES(staticKey);
		
		// 이메일 마스킹 처리
		String email = "";
		String localPart = "";
		String domainPart = "";
		String visiblePart = "";
		
		for (int loop = 0; loop < reviewList.size(); loop++) {
			
			try {
				email = aes.decode(reviewList.get(loop).getEmail());
			} catch (Exception e) {
				e.printStackTrace();
			}
			localPart = email.substring(0, email.indexOf("@"));
			domainPart = email.substring(email.indexOf("@"));
			visiblePart = localPart.substring(0, Math.min(3, localPart.length()));
			
			StringBuilder maskedPart = new StringBuilder();
			for (int i = 0; i < localPart.length() - visiblePart.length(); i++) {
				maskedPart.append("*");
			}
			reviewList.get(loop).setEmail(visiblePart + maskedPart + domainPart);
		}
		
		pagingListDto.setList(reviewList);
		
		return pagingListDto;
	}
}
