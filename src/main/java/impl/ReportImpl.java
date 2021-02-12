package impl;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import model.ReportDTO;

@Service
public interface ReportImpl {
	
	//리스트보기
	public ArrayList<ReportDTO> listView(ReportDTO reportDTO);
	
	//신고수정폼
	public ReportDTO rpView(String s_id);
	
	/* 신고하기 */
	public int ReportInfo(@Param("s_id") String s_id, @Param("r_id") String r_id, @Param("kind") String kind, @Param("reason") String reason);
	
	/*신고글 수정하기*/
	public int ReportModify(String r_id, String kind, String reason, int r_idx);
	
	/*  */
}
