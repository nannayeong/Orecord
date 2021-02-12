package impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import model.AudioBoardDTO;

public interface LikeImpl {
	public int like(String audio_idx,String like_id);
	public int nolike(String audio_idx,String like_id);
	
	public List<Integer> selectLike(String like_id, String id);

	public int myLike(int audio_idx, String like_id);
	
	public int countlike(int audio_idx);
	
	public int addlike(int audio_idx);
	public int removelike(int audio_idx);
	
	public ArrayList<AudioBoardDTO> myLikeSelect(String like_id, int start, int end);
} 
