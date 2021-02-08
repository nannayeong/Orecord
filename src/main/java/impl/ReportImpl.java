package impl;

import org.springframework.stereotype.Service;

@Service
public interface ReportImpl {
	
	
	
	public int ReportInfo(String s_id, String r_id, String kind, String reason);
}
