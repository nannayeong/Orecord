package impl;

import java.util.ArrayList;
import java.util.HashSet;

import org.springframework.stereotype.Service;

import model.AudioBoardDTO;
import model.FollowDTO;
import model.LikeDTO;
import model.MemberDTO;

@Service
public interface MainImpl {
	
	
	public Integer commentCount(int idx);
	public ArrayList<FollowDTO> mainFollwerIdList(String followId);
	public ArrayList<LikeDTO> mainLikeIdList(int audio_idx);
	
} 
