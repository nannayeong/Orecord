package impl;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Service;

import model.ChargeDTO;
import model.ExchangeDTO;
import model.SponsorshipDTO;

@Service
public interface PointImpl {

	public int selectChargeLogTotalCount(Map<String, Object> obj);
	public ArrayList<ChargeDTO> selectChargeLog(Map<String, Object> obj);
	
	public int selectSponsorLogTotalCount(Map<String, Object> obj);
	public ArrayList<SponsorshipDTO> selectSponsorLog(Map<String, Object> obj);
	
	public int selectPatronLogTotalCount(Map<String, Object> obj);
	public ArrayList<SponsorshipDTO> selectPatronLog(Map<String, Object> obj);
	
	public int selectExchangeLogTotalCount(Map<String, Object> obj);
	public ArrayList<ExchangeDTO> selectExchangeLog(Map<String, Object> obj);
	
	public int insertChargeLog(Map<String, Object> obj); 
}
