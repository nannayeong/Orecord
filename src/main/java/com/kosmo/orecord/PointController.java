package com.kosmo.orecord;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import impl.PointImpl;
import model.MemberDTO;

@Controller
public class PointController {

	@Autowired
	private SqlSession sqlSession;   
	
	// 충전내역 조회 페이지 진입
	@RequestMapping("/chargeLog.do")    
	public String charge(Model model) {
		String loginId = "";
		try {
			UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginId = userInfo.getUsername();
			System.out.println(loginId);
		}
		catch (Exception e) {
			return "redirect:member/login.do";
		}
		
		// 결제시 필요한 정보 입력을 위해 MemberDTO 반환
		MemberDTO memberDTO = sqlSession.getMapper(PointImpl.class).selectUserInfo(loginId);
		model.addAttribute("MemberDTO", memberDTO);
		return "point/chargeLog";
	}

	// 후원한 내역 조회 페이지 진입
	@RequestMapping("/sponsorLog.do")
	public String sponsor(Model model) {
		String loginId = "";
		try {
			UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginId = userInfo.getUsername();
			System.out.println(loginId);
		}
		catch (Exception e) {
			return "redirect:member/login.do";
		}
		model.addAttribute("loginId", loginId);
	
		MemberDTO memberDTO = sqlSession.getMapper(PointImpl.class).selectUserInfo(loginId);
		model.addAttribute("MemberDTO", memberDTO);
		return "point/sponsorLog";
	}
	
	// 후원 받은 내역 조회 페이지 진입
	@RequestMapping("/patronLog.do")
	public String patron(Model model) {
		String loginId = "";
		try {
			UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginId = userInfo.getUsername();
			System.out.println(loginId);
		}
		catch (Exception e) {
			return "redirect:member/login.do";
		}
		model.addAttribute("loginId", loginId);
		
		MemberDTO memberDTO = sqlSession.getMapper(PointImpl.class).selectUserInfo(loginId);
		model.addAttribute("MemberDTO", memberDTO);
		return "point/patronLog";
	}
	
	// 환전 내역 조회 페이지 진입
	@RequestMapping("/exchangeLog.do")
	public String exchange(Model model) {
		String loginId = "";
		try {
			UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginId = userInfo.getUsername();
			System.out.println(loginId);
		}
		catch (Exception e) {
			return "redirect:member/login.do";
		}
		model.addAttribute("loginId", loginId);
		
		MemberDTO memberDTO = sqlSession.getMapper(PointImpl.class).selectUserInfo(loginId);
		model.addAttribute("MemberDTO", memberDTO);
		return "point/exchangeLog";
	}
	

	// 환전 신청 페이지 진입
	@RequestMapping("/exchangeForm.do")
	public String exchangeForm(Model model) {
		String loginId = "";
		try {
			UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginId = userInfo.getUsername();
			System.out.println(loginId);
		}
		catch (Exception e) {
			return "redirect:member/login.do";
		}
		MemberDTO memberDTO = sqlSession.getMapper(PointImpl.class).selectUserInfo(loginId);
		model.addAttribute("MemberDTO", memberDTO);
		
		return "point/exchangeForm";
	}
	
	// 기간 설정후 조회버튼 눌렀을 때
	@RequestMapping("/searchingLog.do")
	@ResponseBody
	public Map searchingLog(@RequestParam Map<String,Object> param, HttpServletRequest req, Model model){
		
		// 로그인된 아이디 얻어와서 맵에 넣어주기
		String loginId = "";
		try {
			UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginId = userInfo.getUsername();
			System.out.println(loginId);
		}
		catch (Exception e) {
		}
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
		
		ArrayList list = new ArrayList();
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
		map.put("totalRecord", totalRecord);
		map.put("endpageInBlock", endpageInBlock);
		map.put("totalPage", totalPage);
		map.put("startpageInBlock", startpageInBlock);
		map.put("currentPage", currentPage);
		
		return map;
	}
	
	// 결제 진행시 충전 내역 로그에 삽입
	@RequestMapping("/insertChargeLog.do")
	@ResponseBody
	public void insertChargeLog(@RequestParam Map<String,Object> param, HttpServletRequest req, Model model, HttpSession session) {
		
		// 로그인된 아이디 얻어와서 맵에 넣어주기
		String loginId = "";
		try {
			UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginId = userInfo.getUsername();
			System.out.println(loginId);
			
			
		}
		catch (Exception e) {
		}
		param.put("loginId", loginId);
		
		String paymentType = param.get("paymentType").toString();
		String totalPaymentStr = param.get("totalPayment").toString();
		int totalPayment = Integer.parseInt(totalPaymentStr);
		int chargePoint = (int)(totalPayment/11*10);
		int VAT = totalPayment - chargePoint;
		param.put("chargePoint", chargePoint);
		param.put("VAT", VAT);
		param.put("paymentType", paymentType);
		
		MemberDTO mdto = (MemberDTO)session.getAttribute("user");
		mdto.setMypoint(mdto.getMypoint()+chargePoint);
		
		session.setAttribute("user", mdto);
		
		sqlSession.getMapper(PointImpl.class).insertChargeLog(param);
		sqlSession.getMapper(PointImpl.class).updateChargeMyPoint(param);
		
	}
	
	// 후원시 포인트 이동 처리
	@RequestMapping("/insertSponsorshipLog.do")
	@ResponseBody
	public void insertSponsorshipLog(@RequestParam Map<String, Object> param, Authentication authentication) {
		// 로그인된 아이디 얻어와서 sponsorId 변수에 넣어주기
		String sponsorId = "";
		try {
			UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			sponsorId = userInfo.getUsername();
			System.out.println(sponsorId);
		}
		catch (Exception e) {
		}
		int sponPoint = Integer.parseInt(param.get("sponPoint").toString());
		String patronId = param.get("patronId").toString();
		
		sqlSession.getMapper(PointImpl.class).updateSponsorPoint(sponsorId, sponPoint);
		sqlSession.getMapper(PointImpl.class).updatePatronPoint(patronId, sponPoint);
	}

	
	// 환전요청시 포인트 이동 처리
	@RequestMapping(value="/insertExchangeLog.do", method=RequestMethod.POST)
	public String insertExchangeLog(Model model, HttpServletRequest req) {
		String loginId = "";
		try {
			UserDetails userInfo = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			loginId = userInfo.getUsername();
			System.out.println(loginId);
		}
		catch (Exception e) {
			return "redirect:member/login.do";
		}
		
		String exchangeId = req.getParameter("exchangeId");
		int exchangePoint = Integer.parseInt(req.getParameter("exchangePoint"));
		String bankName = req.getParameter("bankName");
		String accountName = req.getParameter("accountName");
		String accountNum = req.getParameter("accountNum");
		
		int exchangeFee = (int) (exchangePoint * 0.3);
		int exchangedMoney = (int) (exchangePoint * 0.7);
		
		if (exchangePoint == (exchangeFee + exchangedMoney)) {
			System.out.println("환전 수수료, 입금액 이상 없음");
		}
		else {
			System.out.println("환전 수수료, 입금액 확인 필요");
		}
		
		Map<String, Object> map = new HashMap(); 
		map.put("exchangeId", exchangeId);
		map.put("exchangePoint", exchangePoint);
		map.put("exchangeFee", exchangeFee);
		map.put("exchangedMoney", exchangedMoney);
		map.put("bankName", bankName);
		map.put("accountName", accountName);
		map.put("accountNum", accountNum);

		sqlSession.getMapper(PointImpl.class).insertExchangeLog(map);
		sqlSession.getMapper(PointImpl.class).updateExchangeMyPoint(map);
		
		return "redirect:exchangeLog.do";   
	}
}