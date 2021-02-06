package impl;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Service;

import model.PointDTO;

@Service
public interface PointImpl {

	public int selectChargeLogTotalCount(Map<String, Object> obj);
	public ArrayList<PointDTO> selectChargeLog(Map<String, Object> obj);
	
	public int selectSponsorLogTotalCount(Map<String, Object> obj);
	public ArrayList<PointDTO> selectSponsorLog(Map<String, Object> obj);
	
	public int selectPatronLogTotalCount(Map<String, Object> obj);
	public ArrayList<PointDTO> selectPatronLog(Map<String, Object> obj);
	
	public int selectExchangeLogTotalCount(Map<String, Object> obj);
	public ArrayList<PointDTO> selectExchangeLog(Map<String, Object> obj);
	
}
