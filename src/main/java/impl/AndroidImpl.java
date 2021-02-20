package impl;

import java.util.ArrayList;

import model.MemberDTO;

public interface AndroidImpl {
	
	public ArrayList<MemberDTO> memberList();
	public MemberDTO memberLogin(MemberDTO memberDTO);
}
