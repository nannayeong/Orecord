package impl;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Service;

import model.ChargeDTO;
import model.ExchangeDTO;
import model.MemberDTO;
import model.SponsorshipDTO;

@Service
public interface PointImpl {

	// 유저 전체정보 조회 쿼리
	public MemberDTO selectUserInfo(String loginId);
	
	// 충전내역 조회 쿼리
	public int selectChargeLogTotalCount(Map<String, Object> obj);
	public ArrayList<ChargeDTO> selectChargeLog(Map<String, Object> obj);

	// 후원한 내역 조회 쿼리
	public int selectSponsorLogTotalCount(Map<String, Object> obj);
	public ArrayList<SponsorshipDTO> selectSponsorLog(Map<String, Object> obj);

	// 후원 받은 내역 조회 쿼리
	public int selectPatronLogTotalCount(Map<String, Object> obj);
	public ArrayList<SponsorshipDTO> selectPatronLog(Map<String, Object> obj);
	
	// 환불내역 조회 쿼리
	public int selectExchangeLogTotalCount(Map<String, Object> obj);
	public ArrayList<ExchangeDTO> selectExchangeLog(Map<String, Object> obj);
	
	// 결제시 충전 내역 삽입 쿼리
	public void insertChargeLog(Map<String, Object> obj);
	
}
