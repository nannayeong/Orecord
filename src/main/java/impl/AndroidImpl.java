package impl;

import java.util.ArrayList;

import model.AudioBoardDTO;
import model.MemberDTO;

public interface AndroidImpl {
	
	public ArrayList<MemberDTO> memberList();
	public MemberDTO memberLogin(MemberDTO memberDTO);
	
	public ArrayList<AudioBoardDTO> audioBoardView();
	
}
