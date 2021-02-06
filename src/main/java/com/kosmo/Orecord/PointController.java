package com.kosmo.Orecord;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import impl.PointImpl;
import model.PointDTO;

@Controller
public class PointController {

	@Autowired
	private SqlSession sqlSession;
	
	/*
	 1. 다른 페이지에서 결제하기 메뉴 버튼 누르면 충전 내역 조회 페이지로 보내기
	 2. 충전 내역 조회 페이지(결제하기 버튼 배치)
	 	- 매핑명 : "/chargeLog.do", 함수명 : charge() 뷰페이지 : "point/chargeLog", DB명 : chargeLog
	 	- 우상단 결제하기 버튼 클릭하면 결제창 로드
	 3. 스폰한 내역 조회 페이지(내가 스폰한 유저 아이디 누르면 유저 상세페이지로 보낼지?)
	    - 매핑명 : "/sponsorLog.do" 함수명 : sponsor() 뷰페이지 : "point/sponsorLog", DB명 : sponsorshipLog 공유
	    - 우상단에 조회기간에 따른 내가 스폰한 총 포인트, 유저수 보여주기
	 4. 스폰 받은 내역 조회 페이지(나를 스폰해준 유저 아이디 누르면 유저 상세페이지로 보낼지?)
	 	- 매핑명 : "/patronLog.do" 함수명 : patron() 뷰페이지 : "point/patronLog", DB명 : sponsorshipLog 공유
	 	- 우상단에 조회기간에 따른 내가 스폰 받은 총 포인트, 유저수 보여주기
	 5. 환전 내역 조회 페이지(환전하기 버튼 배치)
	 	- 매핑명 : "/exchangeLog.do" 함수명 : exchange() 뷰페이지 : "point/exchangeLog", DB명 : exchangeLog
	 	- 우상단에 환전하기 버튼 배치
	 	- 새창으로 처리할지 다른 페이지로 보낼지 생각해서 폼 작성
	  
	 */
	
	
	// 충전내역 조회 페이지 진입
	@RequestMapping("/chargeLog.do")
	public String charge(Model model) {
		UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String loginId = userInfo.getUsername();
		model.addAttribute("loginId", loginId);
		
		return "point/chargeLog";
	}

	// 후원한 내역 조회 페이지 진입
	@RequestMapping("/sponsorLog.do")
	public String sponsor(Model model) {
		UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String loginId = userInfo.getUsername();
		model.addAttribute("loginId", loginId);
	
		return "point/sponsorLog";
	}
	
	// 후원 받은 내역 조회 페이지 진입
	@RequestMapping("/patronLog.do")
	public String patron(Model model) {
		UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String loginId = userInfo.getUsername();
		model.addAttribute("loginId", loginId);
		
		return "point/patronLog";
	}
	
	// 환전 내역 조회 페이지 진입
	@RequestMapping("/exchangeLog.do")
	public String exchange(Model model) {
		UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String loginId = userInfo.getUsername();
		model.addAttribute("loginId", loginId);
		
		return "point/exchangeLog";
	}
	
	// 기간 설정후 조회버튼 눌렀을 때
	@RequestMapping("/searchingLog.do")
	@ResponseBody
	public Map searchingLog(@RequestParam Map<String,Object> param, HttpServletRequest req, Model model){
		
		// 로그인된 아이디 얻어와서 맵에 넣어주기
		UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String loginId = userInfo.getUsername();
		param.put("loginId", loginId);
		
		
		// 페이징 처리 위해 변수 값 구하기
		int recordPerPage = 11;
		int currentPage = (param.get("selectPage") == null) ?
				1 : Integer.parseInt(param.get("selectPage").toString());
		int startRecord = (int) (currentPage - 1) * recordPerPage + 1;
		int endRecord = currentPage * recordPerPage;
		
		param.put("startRecord", startRecord);
		param.put("endRecord", endRecord);
		
		
		// 4개 뷰 분기 시작
		String selectLog = param.get("selectLog").toString();
		int totalRecord = 0;
		ArrayList<PointDTO> list = new ArrayList<PointDTO>();
		
		if (selectLog.equals("chargeLog")) { // 충전 내역 조회시 매퍼
			totalRecord = sqlSession.getMapper(PointImpl.class).selectChargeLogTotalCount(param); // 검색된 총 건수 구하기
			list = sqlSession.getMapper(PointImpl.class).selectChargeLog(param); // 조회결과 리스트에 삽입
		}
		
		else if (selectLog.equals("sponsorLog")) { // 후원한 내역 조회시 매퍼
			totalRecord = sqlSession.getMapper(PointImpl.class).selectSponsorLogTotalCount(param);
			list = sqlSession.getMapper(PointImpl.class).selectSponsorLog(param);
		}

		else if (selectLog.equals("patronLog")) { // 후원 받은한 내역 조회시 매퍼
			totalRecord = sqlSession.getMapper(PointImpl.class).selectPatronLogTotalCount(param);
			list = sqlSession.getMapper(PointImpl.class).selectPatronLog(param);
		}
		
		else if (selectLog.equals("exchangeLog")) { // 환전 내역 조회시 매퍼
			totalRecord = sqlSession.getMapper(PointImpl.class).selectExchangeLogTotalCount(param);
			list = sqlSession.getMapper(PointImpl.class).selectExchangeLog(param);
		}

		int pagePerBlock = 10;
		int totalPage = (int) (Math.ceil(totalRecord / (double) recordPerPage));
		int startpageInBlock = ((int)Math.floor(currentPage/10) * 10) + 1;
		int endpageInBlock = startpageInBlock + pagePerBlock - 1;
		if (endpageInBlock > totalPage) { 
			endpageInBlock = totalPage;
		}				
		// Ajax로 호출되었으므로 URL아닌 map을 반환 
		Map map = new HashMap();
		map.put("list", list);
		map.put("endpageInBlock", endpageInBlock);
		map.put("totalPage", totalPage);
		map.put("startpageInBlock", startpageInBlock);
		map.put("currentPage", currentPage);
		
		return map;
	}
}
